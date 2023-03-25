import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/utils/assets_constants.dart';
import 'package:logger/logger.dart';

import '../models/objects.dart';

class AuthenticationService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //-- create the user collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //Trigger sign in with google function
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final response =
          await FirebaseAuth.instance.signInWithCredential(credential);

      //-check if the user is successfully created in the firebase
      if (response.user != null) {
        //--------saving the additional data in cloud firestore
        await saveUserData(UserModel(
          response.user!.uid,
          response.user!.displayName!,
          response.user!.email!,
          response.user!.photoURL!,
          "",
        ));

        return response;
      } else {
        //------------if error occure
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //------------Save additional user data on cloud firestore
  Future<void> saveUserData(UserModel model) async {
    return users
        .doc(model.uid)
        .set(
          model.toJson(),
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("User Added"))
        .catchError((error) => Logger().e("Failed to add user: $error"));
  }

  //---------------fetch user data saved in cloud firestore
  Future<UserModel?> fetchUserData(String uid) async {
    try {
      //firebase Query that retrieve user data
      DocumentSnapshot snapshot = await users.doc(uid).get();
      Logger().i(snapshot.data());
      //------mapping fetch data to user model
      UserModel model =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      Logger().i(model.email);
      return model;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //-----------signup function---
  Future<void> registerUser(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    try {
      //-------send email and password to the firebase and create a user
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        //-------check if the user credentials object is not null
        Logger().w(value.user);
        if (value.user != null) {
          //------save other user data in cloud firestore
          await saveUserData(UserModel(
              value.user!.uid, name, email, AssetsConstants.profileimgurl, ""));
          //--------if user created successfully show an alert
          // ignore: use_build_context_synchronously
          AnimatedSnackBar.material(
            "User created successfully",
            type: AnimatedSnackBarType.success,
          ).show(context);
        }
      });
    } on FirebaseAuthException catch (e) {
      AnimatedSnackBar.material(
        "Cannot find the user for given email.",
        type: AnimatedSnackBarType.error,
      ).show(context);
    } catch (e) {
      AnimatedSnackBar.material(
        "User not created successfully",
        type: AnimatedSnackBarType.error,
      ).show(context);
    }
  }

  //-----------signin function---
  Future<void> signinUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      //-------send email and password to the firebase and create a user
      final credentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      AnimatedSnackBar.material(
        "Successfully created",
        type: AnimatedSnackBarType.error,
      ).show(context);
    } catch (e) {
      AnimatedSnackBar.material(
        "Cannot login due to an error",
        type: AnimatedSnackBarType.error,
      ).show(context);
      Logger().e(e);
    }
  }

  //--------sign out function
  Future<void> signoutUser() async {
    await GoogleSignIn().disconnect();
    await auth.signOut().catchError((e) => Logger().e(e));
  }
}
