import '../../../common/common.dart';

class QichatHistory {
  Request request;
  List<QichatInfoModel> list;
  String lastMsgId;
  String nick;
  List<QichatInfoModel> replyList;

  QichatHistory({
    required this.request,
    required this.list,
    required this.lastMsgId,
    required this.nick,
    required this.replyList,
  });

  factory QichatHistory.fromJson(Map<String, dynamic> json) => QichatHistory(
    request: Request.fromJson(json["request"] ?? {}),
    list: json["list"] == null ? [] : List<QichatInfoModel>.from(json["list"].map((x) => QichatInfoModel.fromJson(x))),
    lastMsgId: json["lastMsgId"] ?? '',
    nick: json["nick"] ?? '',
    replyList: json["replyList"] == null ? [] : List<QichatInfoModel>.from(json["replyList"].map((x) => QichatInfoModel.fromJson(x))),
  );

  factory QichatHistory.empty() => QichatHistory(
    request: Request.empty(),
    list: [],
    lastMsgId: '',
    nick: '',
    replyList: [],
  );

  Map<String, dynamic> toJson() => {
    "request": request.toJson(),
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "lastMsgId": lastMsgId,
    "nick": nick,
    "replyList": List<dynamic>.from(replyList.map((x) => x.toJson())),
  };

  Future<void> update({
    MyHttpClient? myHttpClient,
    required Map<String, dynamic> data,
  }) async {
    await myHttpClient?.post<QichatHistory>(ApiPath.qichat.messageHistory,
      onSuccess: (code, msg, data) async {
        request = data.request;
        list = data.list;
        lastMsgId = data.lastMsgId;
        nick = data.nick;
        replyList = data.replyList;
      },
      data: data,
      onModel: (m) => QichatHistory.fromJson(m),
    );
  }
}

class QichatInfoModel {
  String chatId;
  String msgId;
  String msgTime;
  String sender;
  String replyMsgId;
  String msgOp;
  int worker;
  AutoReplyFlag autoReplyFlag;
  String msgFmt;
  String consultId;
  List<WithAutoReplyMessage> withAutoReplies;
  String msgSourceType;
  String payloadId;
  Content content;
  Media image;
  Media audio;
  Media video;
  Geo geo;
  FileClass file;
  WorkerTrans workerTrans;
  Blacklist blacklistApply;
  Blacklist blacklistConfirm;
  AutoReply autoReply;
  WorkerChanged workerChanged;

  QichatInfoModel({
    required this.chatId,
    required this.msgId,
    required this.msgTime,
    required this.sender,
    required this.replyMsgId,
    required this.msgOp,
    required this.worker,
    required this.autoReplyFlag,
    required this.msgFmt,
    required this.consultId,
    required this.withAutoReplies,
    required this.msgSourceType,
    required this.payloadId,
    required this.content,
    required this.image,
    required this.audio,
    required this.video,
    required this.geo,
    required this.file,
    required this.workerTrans,
    required this.blacklistApply,
    required this.blacklistConfirm,
    required this.autoReply,
    required this.workerChanged,
  });

  factory QichatInfoModel.fromJson(Map<String, dynamic> json) => QichatInfoModel(
    chatId: json["chatId"] ?? '',
    msgId: json["msgId"] ?? '',
    msgTime: json["msgTime"] ?? '',
    sender: json["sender"] ?? '',
    replyMsgId: json["replyMsgId"] ?? '',
    msgOp: json["msgOp"] ?? '',
    worker: json["worker"] ?? 0,
    autoReplyFlag: json["autoReplyFlag"] == null
        ? AutoReplyFlag.empty()
        : AutoReplyFlag.fromJson(json["autoReplyFlag"]),
    msgFmt: json["msgFmt"] ?? '',
    consultId: json["consultId"] ?? '',
    withAutoReplies: json["withAutoReplies"] == null
        ? []
        : List<WithAutoReplyMessage>.from(json["withAutoReplies"].map((x) => WithAutoReplyMessage.fromJson(x))),
    msgSourceType: json["msgSourceType"] ?? '',
    payloadId: json["payloadId"] ?? '',
    content: json["content"] == null ? Content.empty() : Content.fromJson(json["content"]),
    image: json["image"] == null ? Media.empty() : Media.fromJson(json["image"]),
    audio: json["audio"] == null ? Media.empty() : Media.fromJson(json["audio"]),
    video: json["video"] == null ? Media.empty() : Media.fromJson(json["video"]),
    geo: json["geo"] == null ? Geo.empty() : Geo.fromJson(json["geo"]),
    file: json["file"] == null ? FileClass.empty() : FileClass.fromJson(json["file"]),
    workerTrans: json["workerTrans"] == null ? WorkerTrans.empty() : WorkerTrans.fromJson(json["workerTrans"]),
    blacklistApply: json["blacklistApply"] == null ? Blacklist.empty() : Blacklist.fromJson(json["blacklistApply"]),
    blacklistConfirm: json["blacklistConfirm"] == null ? Blacklist.empty() : Blacklist.fromJson(json["blacklistConfirm"]),
    autoReply: json["autoReply"] == null ? AutoReply.empty() : AutoReply.fromJson(json["autoReply"]),
    workerChanged: json["workerChanged"] == null ? WorkerChanged.empty() : WorkerChanged.fromJson(json["workerChanged"]),
  );

  Map<String, dynamic> toJson() => {
    "chatId": chatId,
    "msgId": msgId,
    "msgTime": msgTime,
    "sender": sender,
    "replyMsgId": replyMsgId,
    "msgOp": msgOp,
    "worker": worker,
    "autoReplyFlag": autoReplyFlag.toJson(),
    "msgFmt": msgFmt,
    "consultId": consultId,
    "withAutoReplies": List<dynamic>.from(withAutoReplies.map((x) => x.toJson())),
    "msgSourceType": msgSourceType,
    "payloadId": payloadId,
    "content": content.toJson(),
    "image": image.toJson(),
    "audio": audio.toJson(),
    "video": video.toJson(),
    "geo": geo.toJson(),
    "file": file.toJson(),
    "workerTrans": workerTrans.toJson(),
    "blacklistApply": blacklistApply.toJson(),
    "blacklistConfirm": blacklistConfirm.toJson(),
    "autoReply": autoReply.toJson(),
    "workerChanged": workerChanged.toJson(),
  };
}

class Media {
  String uri;

  Media({
    required this.uri,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    uri: json["uri"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "uri": uri,
  };

  factory Media.empty() => Media(uri: '');
}

class AutoReply {
  String id;
  String title;
  int delaySec;
  List<Qa> qa;

  AutoReply({
    required this.id,
    required this.title,
    required this.delaySec,
    required this.qa,
  });

  factory AutoReply.fromJson(Map<String, dynamic> json) => AutoReply(
    id: json["id"] ?? '',
    title: json["title"] ?? '',
    delaySec: json["delaySec"] ?? 0,
    qa: json["qa"] == null
        ? []
        : List<Qa>.from(json["qa"].map((x) => Qa.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "delaySec": delaySec,
    "qa": List<dynamic>.from(qa.map((x) => x.toJson())),
  };

  factory AutoReply.empty() => AutoReply(
    id: '',
    title: '',
    delaySec: 0,
    qa: [],
  );
}

class Answer {
  Content content;
  Media image;
  Media audio;
  Media video;
  Geo geo;
  FileClass file;

  Answer({
    required this.content,
    required this.image,
    required this.audio,
    required this.video,
    required this.geo,
    required this.file,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    content: json["content"] == null ? Content.empty() : Content.fromJson(json["content"]),
    image: json["image"] == null ? Media.empty() : Media.fromJson(json["image"]),
    audio: json["audio"] == null ? Media.empty() : Media.fromJson(json["audio"]),
    video: json["video"] == null ? Media.empty() : Media.fromJson(json["video"]),
    geo: json["geo"] == null ? Geo.empty() : Geo.fromJson(json["geo"]),
    file: json["file"] == null ? FileClass.empty() : FileClass.fromJson(json["file"]),
  );

  Map<String, dynamic> toJson() => {
    "content": content.toJson(),
    "image": image.toJson(),
    "audio": audio.toJson(),
    "video": video.toJson(),
    "geo": geo.toJson(),
    "file": file.toJson(),
  };

  factory Answer.empty() => Answer(
    content: Content.empty(),
    image: Media.empty(),
    audio: Media.empty(),
    video: Media.empty(),
    geo: Geo.empty(),
    file: FileClass.empty(),
  );
}

class FileClass {
  String uri;
  String fileName;
  int size;

  FileClass({
    required this.uri,
    required this.fileName,
    required this.size,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
    uri: json["uri"] ?? '',
    fileName: json["fileName"] ?? '',
    size: json["size"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "uri": uri,
    "fileName": fileName,
    "size": size,
  };

  factory FileClass.empty() => FileClass(
    uri: '',
    fileName: '',
    size: 0,
  );
}

class Geo {
  String longitude;
  String latitude;

  Geo({
    required this.longitude,
    required this.latitude,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    longitude: json["longitude"] ?? '',
    latitude: json["latitude"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "longitude": longitude,
    "latitude": latitude,
  };

  factory Geo.empty() => Geo(
    longitude: '',
    latitude: '',
  );
}

class AutoReplyFlag {
  String id;
  int qaId;

  AutoReplyFlag({
    required this.id,
    required this.qaId,
  });

  factory AutoReplyFlag.fromJson(Map<String, dynamic> json) => AutoReplyFlag(
    id: json["id"] ?? '',
    qaId: json["qaId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "qaId": qaId,
  };

  factory AutoReplyFlag.empty() => AutoReplyFlag(
    id: '',
    qaId: 0,
  );
}

class Blacklist {
  int workerId;

  Blacklist({
    required this.workerId,
  });

  factory Blacklist.fromJson(Map<String, dynamic> json) => Blacklist(
    workerId: json["workerId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "workerId": workerId,
  };

  factory Blacklist.empty() => Blacklist(
    workerId: 0,
  );
}

class WithAutoReplyMessage {
  String id;
  String title;
  String createdTime;
  List<Answer> answers;

  WithAutoReplyMessage({
    required this.id,
    required this.title,
    required this.createdTime,
    required this.answers,
  });

  factory WithAutoReplyMessage.fromJson(Map<String, dynamic> json) => WithAutoReplyMessage(
    id: json["id"] ?? '',
    title: json["title"] ?? '',
    createdTime: json["createdTime"] ?? '',
    answers: json["answers"] == null
        ? []
        : List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "createdTime": createdTime,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };

  factory WithAutoReplyMessage.empty() => WithAutoReplyMessage(
    id: '',
    title: '',
    createdTime: '',
    answers: [],
  );
}

class WorkerChanged {
  String workerClientId;
  int workerId;
  String name;
  String avatar;
  String greeting;
  String state;
  String consultId;

  WorkerChanged({
    required this.workerClientId,
    required this.workerId,
    required this.name,
    required this.avatar,
    required this.greeting,
    required this.state,
    required this.consultId,
  });

  factory WorkerChanged.fromJson(Map<String, dynamic> json) => WorkerChanged(
    workerClientId: json["workerClientId"] ?? '',
    workerId: json["workerId"] ?? 0,
    name: json["name"] ?? '',
    avatar: json["avatar"] ?? '',
    greeting: json["greeting"] ?? '',
    state: json["State"] ?? '',
    consultId: json["consultId"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "workerClientId": workerClientId,
    "workerId": workerId,
    "name": name,
    "avatar": avatar,
    "greeting": greeting,
    "State": state,
    "consultId": consultId,
  };

  factory WorkerChanged.empty() => WorkerChanged(
    workerClientId: '',
    workerId: 0,
    name: '',
    avatar: '',
    greeting: '',
    state: '',
    consultId: '',
  );
}

class WorkerTrans {
  int workerId;
  String workerName;
  String workerAvatar;
  int consultId;

  WorkerTrans({
    required this.workerId,
    required this.workerName,
    required this.workerAvatar,
    required this.consultId,
  });

  factory WorkerTrans.fromJson(Map<String, dynamic> json) => WorkerTrans(
    workerId: json["workerId"] ?? 0,
    workerName: json["workerName"] ?? '',
    workerAvatar: json["workerAvatar"] ?? '',
    consultId: json["consultId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "workerId": workerId,
    "workerName": workerName,
    "workerAvatar": workerAvatar,
    "consultId": consultId,
  };

  factory WorkerTrans.empty() => WorkerTrans(
    workerId: 0,
    workerName: '',
    workerAvatar: '',
    consultId: 0,
  );
}

class Request {
  String chatId;
  String msgId;
  int count;
  bool withLastOne;
  int workerId;
  int consultId;
  int userId;

  Request({
    required this.chatId,
    required this.msgId,
    required this.count,
    required this.withLastOne,
    required this.workerId,
    required this.consultId,
    required this.userId,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    chatId: json["chatId"] ?? '',
    msgId: json["msgId"] ?? '',
    count: json["count"] ?? 0,
    withLastOne: json["withLastOne"] ?? false,
    workerId: json["workerId"] ?? 0,
    consultId: json["consultId"] ?? 0,
    userId: json["userId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "chatId": chatId,
    "msgId": msgId,
    "count": count,
    "withLastOne": withLastOne,
    "workerId": workerId,
    "consultId": consultId,
    "userId": userId,
  };

  factory Request.empty() => Request(
    chatId: '',
    msgId: '',
    count: 0,
    withLastOne: false,
    workerId: 0,
    consultId: 0,
    userId: 0,
  );
}


class Content {
  String data;

  Content({
    required this.data,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    data: json["data"] ?? '',
  );

  factory Content.empty() => Content(
    data: '',
  );

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}

class Qa {
  int id;
  Question question;
  String content;
  List<Question> answer;
  List<Qa> related;

  Qa({
    required this.id,
    required this.question,
    required this.content,
    required this.answer,
    required this.related,
  });

  factory Qa.fromJson(Map<String, dynamic> json) => Qa(
    id: json["id"] ?? 0,
    question: json["question"] == null ? Question.empty() : Question.fromJson(json["question"]),
    content: json["content"] ?? '',
    answer: json["answer"] == null ? [] : List<Question>.from(json["answer"]!.map((x) => Question.fromJson(x))),
    related: json["related"] == null ? [] : List<Qa>.from(json["related"]!.map((x) => Qa.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question.toJson(),
    "content": content,
    "answer": List<dynamic>.from(answer.map((x) => x.toJson())),
    "related": List<dynamic>.from(related.map((x) => x.toJson())),
  };
}

class Question {
  String chatId;
  String msgId;
  String msgTime;
  String sender;
  String replyMsgId;
  String msgOp;
  int worker;
  String autoReplyFlag;
  String msgFmt;
  String consultId;
  List<dynamic> withAutoReplies;
  String msgSourceType;
  String payloadId;
  Content content;
  ImageUrl image;

  Question({
    required this.chatId,
    required this.msgId,
    required this.msgTime,
    required this.sender,
    required this.replyMsgId,
    required this.msgOp,
    required this.worker,
    required this.autoReplyFlag,
    required this.msgFmt,
    required this.consultId,
    required this.withAutoReplies,
    required this.msgSourceType,
    required this.payloadId,
    required this.content,
    required this.image,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    chatId: json["chatId"] ?? '',
    msgId: json["msgId"] ?? '',
    msgTime: json["msgTime"] ?? '',
    sender: json["sender"] ?? '',
    replyMsgId: json["replyMsgId"] ?? '',
    msgOp: json["msgOp"] ?? '',
    worker: json["worker"] ?? 0,
    autoReplyFlag: json["autoReplyFlag"] ?? '',
    msgFmt: json["msgFmt"] ?? '',
    consultId: json["consultId"] ?? '',
    withAutoReplies: json["withAutoReplies"] == null ? [] : List<dynamic>.from(json["withAutoReplies"]!.map((x) => x)),
    msgSourceType: json["msgSourceType"] ?? '',
    payloadId: json["payloadId"] ?? '',
    content: json["content"] == null ? Content.empty() : Content.fromJson(json["content"]),
    image: json["image"] == null ? ImageUrl.empty() : ImageUrl.fromJson(json["image"]),
  );

  factory Question.empty() => Question(
    chatId: '',
    msgId: '',
    msgTime: '',
    sender: '',
    replyMsgId: '',
    msgOp: '',
    worker: 0,
    autoReplyFlag: '',
    msgFmt: '',
    consultId: '',
    withAutoReplies: [],
    msgSourceType: '',
    payloadId: '',
    content: Content.empty(),
    image: ImageUrl.empty(),
  );

  Map<String, dynamic> toJson() => {
    "chatId": chatId,
    "msgId": msgId,
    "msgTime": msgTime,
    "sender": sender,
    "replyMsgId": replyMsgId,
    "msgOp": msgOp,
    "worker": worker,
    "autoReplyFlag": autoReplyFlag,
    "msgFmt": msgFmt,
    "consultId": consultId,
    "withAutoReplies": List<dynamic>.from(withAutoReplies.map((x) => x)),
    "msgSourceType": msgSourceType,
    "payloadId": payloadId,
    "content": content.toJson(),
    "image": image.toJson(),
  };
}

class ImageUrl {
  String uri;

  ImageUrl({
    required this.uri,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
    uri: json["uri"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "uri": uri,
  };

  factory ImageUrl.empty() => ImageUrl(
    uri: '',
  );
}