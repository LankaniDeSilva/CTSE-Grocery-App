import 'package:flutter/material.dart';
import 'package:grocery_app/repository/feedback_repository.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../models/objects.dart';
import '../auth/user_provider.dart';

class FeedbackProvider extends ChangeNotifier {
  final _feedbackRepository = FeedbackRepository();

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //------initialize the baby model list
  List<FeedbackModel> _feedback = [];

  //-----getter for baby list
  List<FeedbackModel> get feedback => _feedback;

  final _subjectController = TextEditingController();

  TextEditingController get subjectController => _subjectController;

  final _messageController = TextEditingController();

  TextEditingController get messageController => _messageController;

  Future<void> saveFeedbacks(BuildContext context) async {
    try {
      //----get cuser
      UserModel user =
          Provider.of<UserProvider>(context, listen: false).userModel;

      await _feedbackRepository.saveFeedbacks(
          user, _messageController.text, subjectController.text, context);

      _messageController.clear();
      _subjectController.clear();

      fetchFeedback();
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  //-----fetch feedback function
  Future<void> fetchFeedback() async {
    try {
      //------start the loader
      setLoading(true);

      //----start fetching feedback
      _feedback = await _feedbackRepository.getProducts();

      notifyListeners();

      //-----stop loading
      setLoading(false);
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }

  //---------remove feedback
  void removeFeedback(String feedbackId, BuildContext context) {
    try {
      _feedbackRepository.deleteFeedback(feedbackId, context);
      fetchFeedback();
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }
}
