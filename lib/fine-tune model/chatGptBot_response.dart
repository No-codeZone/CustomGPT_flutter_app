///Addition model to look for the status of tuned model, whether succededor failed 
class ChatGptBotResponse {
  ChatGptBotResponse({
     this.object,
     this.id,
     this.model,
     this.createdAt,
    this.fineTunedModel,
     this.organizationId,
     this.resultFiles,
     this.status,
    this.validationFile,
     this.trainingFile,
  });
   String? object;
   String? id;
   String? model;
   int? createdAt;
   String? fineTunedModel;
   String? organizationId;
   List<dynamic>? resultFiles;
   String? status;
   Null validationFile;
   String? trainingFile;

  ChatGptBotResponse.fromJson(Map<String, dynamic> json){
    object = json['object'];
    id = json['id'];
    model = json['model'];
    createdAt = json['created_at'];
    fineTunedModel = null;
    organizationId = json['organization_id'];
    resultFiles = List.castFrom<dynamic, dynamic>(json['result_files']);
    status = json['status'];
    validationFile = null;
    trainingFile = json['training_file'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['object'] = object;
    _data['id'] = id;
    _data['model'] = model;
    _data['created_at'] = createdAt;
    _data['fine_tuned_model'] = fineTunedModel;
    _data['organization_id'] = organizationId;
    _data['result_files'] = resultFiles;
    _data['status'] = status;
    _data['validation_file'] = validationFile;
    _data['training_file'] = trainingFile;
    return _data;
  }
}
