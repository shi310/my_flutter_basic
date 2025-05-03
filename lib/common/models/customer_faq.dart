
import '../common.dart';

class CustomerFaqTypeListModel {
  List<CustomerFaqTypeModel> list;

  CustomerFaqTypeListModel({
    required this.list
  });

  factory CustomerFaqTypeListModel.fromJson(List<dynamic> json) => CustomerFaqTypeListModel(
    list: json.map((i) => CustomerFaqTypeModel.fromJson(i)).toList(),
  );

  factory CustomerFaqTypeListModel.empty() => CustomerFaqTypeListModel(list: []);


  Future<void> update() async {
    await UserController.to.myHttpClient?.get<CustomerFaqTypeListModel>(ApiPath.me.getCustomerFaqType,
      onSuccess: (code, msg, results) async {
        list = results.list;
      },
      onModel: (m) => CustomerFaqTypeListModel.fromJson(m),
    );
  }
}

class CustomerFaqTypeModel {
  int id;
  int sort;
  String categoryName;

  CustomerFaqTypeModel({
    required this.id,
    required this.categoryName,
    required this.sort,
  });

  factory CustomerFaqTypeModel.fromJson(Map<String, dynamic> json) => CustomerFaqTypeModel(
    id: json['id'] ?? -1,
    sort: json['sort'] ?? -1,
    categoryName: json['categoryName'] ?? '',
  );

  factory CustomerFaqTypeModel.empty() => CustomerFaqTypeModel(
      id: -1,
      sort: -1,
      categoryName: ''
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
    "sort": sort,
  };
}

class CustomerFaqListModel {
  List<CustomerFaqInfoModel> list;

  CustomerFaqListModel({required this.list});

  factory CustomerFaqListModel.fromJson(List<dynamic> json) => CustomerFaqListModel(
    list: json.map((i) => CustomerFaqInfoModel.fromJson(i)).toList(),
  );

  factory CustomerFaqListModel.empty() => CustomerFaqListModel(list: []);

  Map<String, dynamic> toJson() => {
    "list": list.map((i) => i.toJson()).toList(),
  };

  Future<void> update({required int typeId}) async {
    await UserController.to.myHttpClient?.post<CustomerFaqListModel>(ApiPath.me.getCustomerFaqList,
      onSuccess: (code, msg, results) async {
        list = results.list;
      },
      onModel: (m) => CustomerFaqListModel.fromJson(m),
      data: {
        "typeId": typeId,
      },
    );
  }
}

class CustomerFaqInfoModel {
  int id;
  String title;
  int symbol;
  String answer;
  String picUrl;
  int sort;

  CustomerFaqInfoModel({
    required this.id,
    required this.title,
    required this.symbol,
    required this.answer,
    required this.picUrl,
    required this.sort,
  });

  factory CustomerFaqInfoModel.fromJson(Map<String, dynamic> json) => CustomerFaqInfoModel(
    id: json["id"] ?? -1,
    title: json["title"] ?? "",
    symbol: json["symbol"] ?? -1,
    answer: json["answer"] ?? "",
    picUrl: json["picUrl"] ?? "",
    sort: json["sort"]?? -1,
  );

  factory CustomerFaqInfoModel.empty() => CustomerFaqInfoModel(
    id: -1,
    title: "",
    symbol: -1,
    answer: "",
    picUrl: "",
    sort: -1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "symbol": symbol,
    "answer": answer,
    "picUrl": picUrl,
    "sort": sort,
  };
}
