import 'dart:convert';
import 'package:chatgpt_flutter/fine-tune%20model/chatbot_model.dart';
import 'package:chatgpt_flutter/models/chatGpt_response.dart';
import 'package:http/http.dart' as http;
import '../fine-tune model/ResponsePrimeGPT.dart';
import '../models/chat_model.dart';

class ApiCallService {
  String apiKeyGpt = "sk-proj-9RedY7XIWbb7yh74AAGWT3BlbkFJyJXIz4aB9baah8Gyez3h";
  String apiKeyBot = "sk-proj-iAb7UWi0r61z6JOECBftT3BlbkFJ01bzzTOKTXqgGyWTllFL";
  String modelGPT = "gpt-3.5-turbo";
  // String botModelGPT = "ft:gpt-3.5-turbo-0125:techstern:responseprimegpt:9MBSADAE";
  String botModelGPT = "ft:gpt-3.5-turbo-0125:techstern:botchatgpt:9MvZqRAc";
  String trainingFileID = "file-p63hmoLdE3paZiN3XZZtRGhL";
  late bool useFineTuned;

  Future<ChatGptResponse?> sendGptMessage(ChatSendModel message) async {
    print(message.toJson());
    var link = Uri.parse("https://api.openai.com/v1/chat/completions");
    var data = await http.post(link,
        headers: {
          "Authorization": "Bearer $apiKeyGpt",
          "Content-Type": "application/json",
        },
        body: jsonEncode(message.toJson()));

    Map<String, dynamic> dataAll = jsonDecode(data.body);
    ChatGptResponse? response = ChatGptResponse.fromJson(dataAll);
    print('Max token size is here\t${response.usage?.totalTokens.toString()}\n'
        'Prompt token size is here\t${response.usage?.promptTokens.toString()}\n'
        'Completion token size si here\t${response.usage?.completionTokens.toString()}');
    // int? completionTokens=response.usage?.completionTokens;
    print(response.model);
    print('Data is here\t$dataAll');
    print('Response is here\t$response');
    return response;
  }

  fetchModels() async {
    var link = Uri.parse("https://api.openai.com/v1/models");
    var data = await http.get(link, headers: {
      "Authorization": "Bearer $apiKeyGpt",
    });

    Map dataAll = jsonDecode(data.body);
    print(dataAll);
  }

  Future<ResponsePrimeGPT?> sendBotMessage(ChatBotSendModel messageGPT) async {
    print('MessageGPT\t${messageGPT.toJson()}');
    var link = Uri.parse("https://api.openai.com/v1/fine_tuning/jobs");
    var dataBot = await http.post(link,
        headers: {
          "Authorization": "Bearer $apiKeyBot",
          "Content-Type": "application/json",
        },
        body: jsonEncode(messageGPT.toJson()));

    Map<String, dynamic> dataAll = jsonDecode(dataBot.body);
    print('BotData1 is here\t$dataAll');
    ResponsePrimeGPT? responseBot = ResponsePrimeGPT.fromJson(dataAll);
    print('Fine-tuned model response is here\t${responseBot.toString()}');
    print('BotResponse is here\t$responseBot');
    return responseBot;
  }

  /*Future<dynamic> sendMessage(String message) async {
    try {
      if (useFineTuned) {
        // First, try to get a response from the fine-tuned model
        ResponsePrimeGPT? fineTuneResponse = await sendBotMessage(
          ChatBotSendModel(
            message: [
              MessageBotSend(
                message: message,
                role: 'user',
              )
            ],
            trainingFileId: trainingFileID,
            temperature: 0.7,
            model: botModelGPT,
          ),
        );
        if (fineTuneResponse != null && fineTuneResponse.data != null && fineTuneResponse.data!.isNotEmpty) {
          print('BotGPT response is here\t${fineTuneResponse.toString()}');
          print('BotGPT object is here\t${fineTuneResponse.data![0].object.toString()}');
          return fineTuneResponse.data;
        }
      }
        useFineTuned=false;
        // If the fine-tuned model doesn't return a response or useFineTuned is false,
        // try to get a response from the GPT-3.5-Turbo model
        ChatGptResponse? gptResponse = await sendGptMessage(
          ChatSendModel(
            message: [
              MessageSend(
                message: message,
                role: 'user',
              )
            ],
            model: modelGPT,
            temperature: 0.7,
          ),
        );

        if (gptResponse != null && gptResponse.choices != null && gptResponse.choices!.isNotEmpty) {
          print('GPT response is here\t${gptResponse.toString()}');
          // If the GPT-3.5-Turbo model returns a response, use that
          return gptResponse.choices!.first;
        }
    } catch (e) {
      print('Error: $e');
    }
    // If neither model returns a response, return a default message
    return 'Sorry, I couldn\'t find a suitable response.';
  }*/


}
