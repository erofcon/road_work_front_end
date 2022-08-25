

class ReportGetCountTaskResponse {
  ReportGetCountTaskResponse({
    required this.labels,
    required this.datasets,
  });
  late final List<String> labels;
  late final Datasets datasets;

  ReportGetCountTaskResponse.fromJson(Map<String, dynamic> json){
    labels = List.castFrom<dynamic, String>(json['labels']);
    datasets = Datasets.fromJson(json['datasets']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['labels'] = labels;
    data['datasets'] = datasets.toJson();
    return data;
  }
}

class Datasets {
  Datasets({
    required this.countAllTasks,
    required this.countExecutedTasks,
    required this.countExpiredTasks,
  });
  late final List<int> countAllTasks;
  late final List<int> countExecutedTasks;
  late final List<int> countExpiredTasks;

  Datasets.fromJson(Map<String, dynamic> json){
    countAllTasks = List.castFrom<dynamic, int>(json['count_all_tasks']);
    countExecutedTasks = List.castFrom<dynamic, int>(json['count_executed_tasks']);
    countExpiredTasks = List.castFrom<dynamic, int>(json['count_expired_tasks']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count_all_tasks'] = countAllTasks;
    data['count_executed_tasks'] = countExecutedTasks;
    data['count_expired_tasks'] = countExpiredTasks;
    return data;
  }
}