// class GetTaskToMapResponse {
//   GetTaskToMapResponse({
//     required this.id,
//     required this.images,
//     required this.category,
//     required this.executor,
//     required this.creator,
//     required this.createDateTime,
//     required this.isDone,
//     required this.isExpired,
//   });
//
//   late final int id;
//   late final Images? images;
//   late final Category? category;
//   late final Executor? executor;
//   late final Creator? creator;
//   late final String? createDateTime;
//   late final bool? isDone;
//   late final bool? isExpired;
//
//   GetTaskToMapResponse.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     images = Images.fromJson(json['images']);
//     category = Category.fromJson(json['category']);
//     executor = Executor.fromJson(json['executor']);
//     creator = Creator.fromJson(json['creator']);
//     createDateTime = json['createDateTime'];
//     isDone = json['is_done'];
//     isExpired = json['is_expired'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['images'] = images?.toJson();
//     data['category'] = category?.toJson();
//     data['executor'] = executor?.toJson();
//     data['creator'] = creator?.toJson();
//     data['createDateTime'] = createDateTime;
//     data['is_done'] = isDone;
//     data['is_expired'] = isExpired;
//     return data;
//   }
// }
//
// class Images {
//   Images({
//     required this.id,
//     required this.url,
//   });
//
//   late final int id;
//   late final String? url;
//
//   Images.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['url'] = url;
//     return data;
//   }
// }
//
// class Category {
//   Category({
//     required this.id,
//     required this.name,
//   });
//
//   late final int id;
//   late final String name;
//
//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     return data;
//   }
// }
//
// class Executor {
//   Executor({
//     required this.id,
//     required this.isSuperuser,
//     required this.username,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.isCreator,
//     required this.isExecutor,
//     required this.numberPhone,
//     required this.groups,
//   });
//
//   late final int id;
//   late final bool? isSuperuser;
//   late final String? username;
//   late final String? firstName;
//   late final String? lastName;
//   late final String? email;
//   late final bool? isCreator;
//   late final bool? isExecutor;
//   late final String? numberPhone;
//   late final List<int>? groups;
//
//   Executor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     isSuperuser = json['is_superuser'];
//     username = json['username'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     isCreator = json['is_creator'];
//     isExecutor = json['is_executor'];
//     numberPhone = json['number_phone'];
//     groups = List.castFrom<dynamic, int>(json['groups']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['is_superuser'] = isSuperuser;
//     data['username'] = username;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['email'] = email;
//     data['is_creator'] = isCreator;
//     data['is_executor'] = isExecutor;
//     data['number_phone'] = numberPhone;
//     data['groups'] = groups;
//     return data;
//   }
// }
//
// class Creator {
//   Creator({
//     required this.id,
//     required this.isSuperuser,
//     required this.username,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.isCreator,
//     required this.isExecutor,
//     required this.numberPhone,
//     required this.groups,
//   });
//
//   late final int id;
//   late final bool? isSuperuser;
//   late final String? username;
//   late final String? firstName;
//   late final String? lastName;
//   late final String? email;
//   late final bool? isCreator;
//   late final bool? isExecutor;
//   late final String? numberPhone;
//   late final List<int>? groups;
//
//   Creator.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     isSuperuser = json['is_superuser'];
//     username = json['username'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     isCreator = json['is_creator'];
//     isExecutor = json['is_executor'];
//     numberPhone = json['number_phone'];
//     groups = List.castFrom<dynamic, int>(json['groups']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['is_superuser'] = isSuperuser;
//     data['username'] = username;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['email'] = email;
//     data['is_creator'] = isCreator;
//     data['is_executor'] = isExecutor;
//     data['number_phone'] = numberPhone;
//     data['groups'] = groups;
//     return data;
//   }
// }
class GetTaskToMapResponse {
  GetTaskToMapResponse({
    required this.id,
    required this.images,
    required this.category,
    required this.executor,
    required this.creator,
    required this.createDateTime,
    required this.isDone,
    required this.isExpired,
  });
  late final int id;
  late final Images images;
  late final Category category;
  late final Executor executor;
  late final Creator creator;
  late final String createDateTime;
  late final bool isDone;
  late final bool isExpired;

  GetTaskToMapResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    images = Images.fromJson(json['images']);
    category = Category.fromJson(json['category']);
    executor = Executor.fromJson(json['executor']);
    creator = Creator.fromJson(json['creator']);
    createDateTime = json['createDateTime'];
    isDone = json['is_done'];
    isExpired = json['is_expired'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['images'] = images.toJson();
    data['category'] = category.toJson();
    data['executor'] = executor.toJson();
    data['creator'] = creator.toJson();
    data['createDateTime'] = createDateTime;
    data['is_done'] = isDone;
    data['is_expired'] = isExpired;
    return data;
  }
}

// class Images {
//   Images();
//
//   Images.fromJson(Map json);
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     return data;
//   }
// }

class Images {
  Images(this.id, this.url,);

  late final int ?id;
  late final String? url;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Executor {
  Executor({
    required this.id,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isCreator,
    required this.isExecutor,
    required this.numberPhone,
    required this.groups,
  });
  late final int id;
  late final bool isSuperuser;
  late final String username;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final bool isCreator;
  late final bool isExecutor;
  late final String numberPhone;
  late final List<int> groups;

  Executor.fromJson(Map<String, dynamic> json){
    id = json['id'];
    isSuperuser = json['is_superuser'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isCreator = json['is_creator'];
    isExecutor = json['is_executor'];
    numberPhone = json['number_phone'];
    groups = List.castFrom<dynamic, int>(json['groups']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['is_superuser'] = isSuperuser;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['is_creator'] = isCreator;
    data['is_executor'] = isExecutor;
    data['number_phone'] = numberPhone;
    data['groups'] = groups;
    return data;
  }
}

class Creator {
  Creator({
    required this.id,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isCreator,
    required this.isExecutor,
    required this.numberPhone,
    required this.groups,
  });
  late final int id;
  late final bool isSuperuser;
  late final String username;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final bool isCreator;
  late final bool isExecutor;
  late final String numberPhone;
  late final List<int> groups;

  Creator.fromJson(Map<String, dynamic> json){
    id = json['id'];
    isSuperuser = json['is_superuser'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isCreator = json['is_creator'];
    isExecutor = json['is_executor'];
    numberPhone = json['number_phone'];
    groups = List.castFrom<dynamic, int>(json['groups']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['is_superuser'] = isSuperuser;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['is_creator'] = isCreator;
    data['is_executor'] = isExecutor;
    data['number_phone'] = numberPhone;
    data['groups'] = groups;
    return data;
  }
}