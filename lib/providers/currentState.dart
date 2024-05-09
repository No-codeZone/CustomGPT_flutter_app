import 'package:chatgpt_flutter/models/chat_model.dart';
import 'package:chatgpt_flutter/services/apiCall.dart';
import 'package:flutter/material.dart';
import '../models/chatGpt_response.dart';

class CurrentState extends ChangeNotifier {
  bool loading = false;
  ApiCallService apiCallService = ApiCallService();
  String modelGPT = "gpt-3.5-turbo";
  String role = "user";
  bool useFineTune = true;

  List<MessageBuilderUiModel> listMessages = [];

  addMessage(MessageBuilderUiModel data) {
    listMessages.add(data);
    notifyListeners();
  }

  sendGptMessage(String message) async {
    addMessage(MessageBuilderUiModel(message: message, whoAmI: "user"));
    loading = true;
    notifyListeners();
    print(message);
    ChatGptResponse? response =
        await apiCallService.sendGptMessage(ChatSendModel(message: [
      MessageSend(
        message: message,
        role: role,
      )
    ], model: modelGPT, temperature: 0.7));
    debugPrint(
        'Message Send contains\t${MessageSend(message: message, role: 'user')}');
    if (response != null) {
      addMessage(MessageBuilderUiModel(
          message: response.choices![0].message?.content ?? "",
          whoAmI: "chatGpt"));
    }
    /*print('test101');
    ResponsePrimeGPT? botResponse=await apiCallService.sendBotMessage(ChatBotSendModel(message:
    [
      MessageBotSend(
        message: message,
        role: 'user',
      )
    ], trainingFileId: trainingFileID, temperature: 0.7)
    );
    print('test102');
    if(botResponse!=null){
      print('PrimeGPT response is here\t${botResponse.data![0].message}');
    }*/
    loading = false;
    notifyListeners();
  }

  /*addBotMessage(MessageBuilderUiModel botData) {
    listMessages.length.toString();
    listMessages.add(botData);
    print('listBotMessage length\t${botData.message.length}');
    notifyListeners();
  }

  sendBotMessage(String message) async {
    addBotMessage(MessageBuilderUiModel(message: message, whoAmI: 'user'));
    loading = true;
    notifyListeners();
    print(message);
    ResponsePrimeGPT? responseBot =
        await apiCallService.sendBotMessage(ChatBotSendModel(message: [
      MessageBotSend(
        message: message,
        role: 'user',
      )
    ], trainingFileId: trainingFileID, temperature: 0.7, model: botModelGPT));
    debugPrint(
        'Message Send contains\t${MessageBotSend(message: message, role: 'user')}');
    print('Bot response is here\t${responseBot.toString()}');
    if (responseBot != null) {
      addBotMessage(MessageBuilderUiModel(
          message: responseBot.data![0].message ?? "", whoAmI: 'chatGpt'));
    }
    loading = false;
    notifyListeners();
  }*/

  /*sendMessage(String message) {
    try {
      // if (useFineTune) {
      //   sendBotMessage(message);
      // }
      // useFineTune=false;
      sendGptMessage(message);
    } catch (e) {
      print('Exception occurred here\t${e.toString()}');
    }
  }*/
}
