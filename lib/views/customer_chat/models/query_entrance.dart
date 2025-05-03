
import '../../../common/common.dart';

class QueryEntranceModel {
  String name;
  String nick;
  String avatar;
  String guide;
  int defaultConsultId;
  String changeDefaultTime;
  List<Consult> consults;

  QueryEntranceModel({
    required this.name,
    required this.nick,
    required this.avatar,
    required this.guide,
    required this.defaultConsultId,
    required this.changeDefaultTime,
    required this.consults,
  });

  factory QueryEntranceModel.fromJson(Map<String, dynamic> json) => QueryEntranceModel(
    name: json["name"] ?? '',
    nick: json["nick"] ?? '',
    avatar: json["avatar"] ?? '',
    guide: json["guide"] ?? '',
    defaultConsultId: json["defaultConsultId"] ?? 0,
    changeDefaultTime: json["changeDefaultTime"] ?? '',
    consults: json["consults"] == null ? [] : List<Consult>.from(json["consults"]!.map((x) => Consult.fromJson(x))),
  );

  factory QueryEntranceModel.empty() => QueryEntranceModel(
    name: '',
    nick: '',
    avatar: '',
    guide: '',
    defaultConsultId: 0,
    changeDefaultTime: '',
    consults: [],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "nick": nick,
    "avatar": avatar,
    "guide": guide,
    "defaultConsultId": defaultConsultId,
    "changeDefaultTime": changeDefaultTime,
    "consults": List<dynamic>.from(consults.map((x) => x.toJson())),
  };

  Future<void> update({MyHttpClient? myHttpClient}) async {
    await myHttpClient?.post<QueryEntranceModel>(ApiPath.qichat.queryEntrance,
      onSuccess: (code, msg, data) async {
        name = data.name;
        nick = data.nick;
        avatar = data.avatar;
        guide = data.guide;
        defaultConsultId = data.defaultConsultId;
        changeDefaultTime = data.changeDefaultTime;
        consults = data.consults;
      },
      onModel: (m) => QueryEntranceModel.fromJson(m)
    );
  }
}

class Consult {
  int consultId;
  String name;
  String guide;
  List<Work> works;
  int unread;
  int priority;

  Consult({
    required this.consultId,
    required this.name,
    required this.guide,
    required this.works,
    required this.unread,
    required this.priority,
  });

  factory Consult.fromJson(Map<String, dynamic> json) => Consult(
    consultId: json["consultId"] ?? 0,
    name: json["name"] ?? '',
    guide: json["guide"] ?? '',
    works: json["Works"] == null ? [] : List<Work>.from(json["Works"]!.map((x) => Work.fromJson(x))),
    unread: json["unread"] ?? 0,
    priority: json["priority"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "consultId": consultId,
    "name": name,
    "guide": guide,
    "Works": List<dynamic>.from(works.map((x) => x.toJson())),
    "unread": unread,
    "priority": priority,
  };
}

class Work {
  String nick;
  String avatar;
  int workerId;
  String nimId;
  String connectState;
  String onlineState;

  Work({
    required this.nick,
    required this.avatar,
    required this.workerId,
    required this.nimId,
    required this.connectState,
    required this.onlineState,
  });

  factory Work.fromJson(Map<String, dynamic> json) => Work(
    nick: json["nick"] ?? '',
    avatar: json["avatar"] ?? '',
    workerId: json["workerId"] ?? 0,
    nimId: json["nimId"] ?? '',
    connectState: json["connectState"] ?? '',
    onlineState: json["onlineState"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "nick": nick,
    "avatar": avatar,
    "workerId": workerId,
    "nimId": nimId,
    "connectState": connectState,
    "onlineState": onlineState,
  };
}