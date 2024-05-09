import 'package:flutter/cupertino.dart';
import '../fine-tune model/ResponsePrimeGPT.dart';
import '../fine-tune model/chatGptBot_response.dart';
import '../fine-tune model/chatbot_model.dart';
import '../services/apiCall.dart';

class CurrentBotState extends ChangeNotifier {
  bool loading = false;
  ApiCallService apiCallService = ApiCallService();
  String modelGPT = "gpt-3.5-turbo";
  // String botModelGPT = "ft:gpt-3.5-turbo-0125:techstern:responseprimegpt:9MBSADAE";
  String botModelGPT = "ft:gpt-3.5-turbo-0125:techstern:botchatgpt:9MvZqRAc";
  // String trainingFileID = "file-p63hmoLdE3paZiN3XZZtRGhL";
  String trainingFileID = "file-DO7CPxbRBKeOkV9Z1th7wUIW";
  String role = "user";

  List<MessageBotBuilderUiModel> listBotMessages = [];

  addBotMessage(MessageBotBuilderUiModel botData) {
    var listSizeBefore=listBotMessages.length.toString();
    listBotMessages.add(botData);
    print('listBotMessage length\t${botData.messageBot.length}');
    notifyListeners();
  }

  sendBotMessage(String message) async {
    addBotMessage(MessageBotBuilderUiModel(
        messageBot: message, chatBot: "user"));
    loading = true;
    notifyListeners();
    print(message);
    ResponsePrimeGPT? responseBot =
    await apiCallService.sendBotMessage(ChatBotSendModel(message: [
      MessageBotSend(
        message: message,
        role: role,
      )
    ], trainingFileId: trainingFileID, temperature: 0.7, model: botModelGPT));

    debugPrint(
        'Message Send contains\t${MessageBotSend(message: message, role: 'user')}');
    print('Bot response is here\t${responseBot.toString()}');
    if (responseBot != null) {
      addBotMessage(MessageBotBuilderUiModel(
          messageBot: responseBot.data![10].message ?? "",
          chatBot: "chatGpt"));
    }
    loading = false;
    notifyListeners();
  }
}
