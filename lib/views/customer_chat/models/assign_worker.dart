
import '../../../common/common.dart';

class AssignWorkerModel {
  String nick;
  String avatar;
  int workerId;
  String nimid;
  String tips;
  String chatId;

  AssignWorkerModel({
    required this.nick,
    required this.avatar,
    required this.workerId,
    required this.nimid,
    required this.tips,
    required this.chatId,
  });

  factory AssignWorkerModel.fromJson(Map<String, dynamic> json) => AssignWorkerModel(
    nick: json["nick"] ?? '',
    avatar: json["avatar"] ?? '',
    workerId: json["workerId"] ?? 0,
    nimid: json["nimid"] ?? '',
    tips: json["tips"] ?? '',
    chatId: json["chatId"] ?? '',
  );

  factory AssignWorkerModel.empty() => AssignWorkerModel(
    nick: '',
    avatar: '',
    workerId: 0,
    nimid: '',
    tips: '',
    chatId: '',
  );

  Map<String, dynamic> toJson() => {
    "nick": nick,
    "avatar": avatar,
    "workerId": workerId,
    "nimid": nimid,
    "tips": tips,
    "chatId": chatId,
  };

  Future<void> update({
    MyHttpClient? myHttpClient,
    required Map<String, dynamic> data,
  }) async {
    await myHttpClient?.post<AssignWorkerModel>(ApiPath.qichat.assignWorker,
      onSuccess: (code, msg, data) async {
        nick = data.nick;
        avatar = data.avatar;
        workerId = data.workerId;
        nimid = data.nimid;
        tips = data.tips;
        chatId = data.chatId;
      },
      data: data,
      onModel: (m) => AssignWorkerModel.fromJson(m),
    );
  }
}