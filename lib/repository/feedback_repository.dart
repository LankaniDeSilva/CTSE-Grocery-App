import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../models/objects.dart';

class FeedbackRepository {
  CollectionReference feedback =
      FirebaseFirestore.instance.collection('feedback');

  //------------Save order in firestore cloud
  Future<void> saveFeedbacks(UserModel user, String message, String subject,
      BuildContext context) async {
    //-getting an unique document ID
    String docid = feedback.doc().id;

    return feedback
        .doc(docid)
        .set({
          'id': docid,
          'user': user.toJson(),
          'subject': subject,
          'message': message,
          'reply': ""
        })
        .then((value) => //------show the snackbar
            AnimatedSnackBar.material(
              "Feedback saved successfuly",
              type: AnimatedSnackBarType.success,
            ).show(context))
        .catchError((error) => Logger().e("Failed to add feedback: $error"));
  }

  //----------fetch feedback
  Future<List<FeedbackModel>> getProducts() async {
    try {
      //----------query for fetching all the feedback list
      QuerySnapshot snapshot = await feedback.get();

      //----------feedback list
      List<FeedbackModel> feedbackList = [];

      //----------mapping fetch data to feedback model and store in feedback list
      for (var element in snapshot.docs) {
        //-----mapping to single feedback model
        FeedbackModel model =
            FeedbackModel.fromJson(element.data() as Map<String, dynamic>);

        //-----adding to the list
        feedbackList.add(model);
      }

      return feedbackList;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<void>? deleteFeedback(String id, BuildContext context) {
    try {
      return feedback
          .doc(id)
          .delete()
          .then((_) => AnimatedSnackBar.material(
                "Feedback is successfully delete",
                type: AnimatedSnackBarType.success,
              ).show(context))
          .catchError((error) => Logger().e(error));
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
