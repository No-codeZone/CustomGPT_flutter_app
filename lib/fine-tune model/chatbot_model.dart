class ChatBotSendModel {
  double temperature;
  String trainingFileId;
  String model;
  List<MessageBotSend> message;

  ChatBotSendModel({
    required this.message,
    required this.trainingFileId,
    required this.model,
    required this.temperature,
  });

  Map<String, dynamic> toJson() {
    List toMapData = [];
    for (var element in message) {
      toMapData.add(element.toJson());
    }

    return {
      "temperature": temperature,
      "training_file": trainingFileId,
      "model":model,
      "messages": toMapData,
      "max_tokens": 100,
    };
  }
}

class MessageBotSend {
  String role;
  String message;

  MessageBotSend({required this.message, required this.role});

  Map<String, dynamic> toJson() {
    return {
      "role": role,
      "content": message,
    };
  }
}

class MessageBotBuilderUiModel {
  String messageBot;
  String chatBot;

  MessageBotBuilderUiModel({required this.messageBot, required this.chatBot});
}
