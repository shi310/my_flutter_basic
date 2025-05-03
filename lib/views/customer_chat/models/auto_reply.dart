import '../../../common/common.dart';
import 'index.dart';

class AutoReplyModel {
  AutoReplyItemModel autoReplyItem;
  String createTime;

  AutoReplyModel({
    required this.autoReplyItem,
    required this.createTime,
  });

  factory AutoReplyModel.fromJson(Map<String, dynamic> json) => AutoReplyModel(
    autoReplyItem: json["autoReplyItem"] == null ? AutoReplyItemModel.empty() : AutoReplyItemModel.fromJson(json["autoReplyItem"]),
    createTime: json["createTime"] ?? '',
  );

  factory AutoReplyModel.empty() => AutoReplyModel(
    autoReplyItem: AutoReplyItemModel.empty(),
    createTime: '',
  );

  Future<void> update({
    MyHttpClient? myHttpClient,
    required Map<String, dynamic> data,
  }) async {
    await myHttpClient?.post<AutoReplyModel>(ApiPath.qichat.queryAutoReply,
      onSuccess: (code, msg, data) async {
        autoReplyItem = data.autoReplyItem;
        createTime = DateTime.now().toString().split('.').first;
      },
      data: data,
      onModel: (m) => AutoReplyModel.fromJson(m),
    );
  }
}

class AutoReplyItemModel {
  String id;
  String name;
  String title;
  List<Qa> qa;
  List<int> workerId;
  List<String> workerNames;

  AutoReplyItemModel({
    required this.id,
    required this.name,
    required this.title,
    required this.qa,
    required this.workerId,
    required this.workerNames,
  });

  factory AutoReplyItemModel.empty() => AutoReplyItemModel(
    id: '',
    name: '',
    title: '',
    qa: [],
    workerId: [],
    workerNames: [],
  );

  factory AutoReplyItemModel.fromJson(Map<String, dynamic> json) => AutoReplyItemModel(
    id: json["id"] ?? '',
    name: json["name"] ?? '',
    title: json["title"] ?? '',
    qa: json["qa"] == null ? [] : List<Qa>.from(json["qa"]!.map((x) => Qa.fromJson(x))),
    workerId: json["workerId"] == null ? [] : List<int>.from(json["workerId"]!.map((x) => x)),
    workerNames: json["workerNames"] == null ? [] : List<String>.from(json["workerNames"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "qa": List<dynamic>.from(qa.map((x) => x.toJson())),
    "workerId": List<dynamic>.from(workerId.map((x) => x)),
    "workerNames": List<dynamic>.from(workerNames.map((x) => x)),
  };
}