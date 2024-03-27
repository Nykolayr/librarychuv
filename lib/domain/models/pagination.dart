class Pagination {
  int currentPage;
  int pageCount;
  int recordCount;

  Pagination(
      {required this.currentPage,
      required this.pageCount,
      required this.recordCount});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    int currentPage = 0;
    int pageCount = 1;
    int recordCount = 10;
    if (json['CurrentPage'] != null) {
      if (json['CurrentPage'] is String) {
        currentPage = int.parse(json['CurrentPage']);
      } else if (json['CurrentPage'] != null && json['CurrentPage'] is int) {
        currentPage = json['CurrentPage'];
      }
    }

    if (json['PageCount'] != null) {
      if (json['PageCount'] is String) {
        pageCount = int.parse(json['PageCount']);
      } else if (json['PageCount'] != null && json['PageCount'] is int) {
        pageCount = json['PageCount'];
      }
    }

    if (json['RecordCount'] != null) {
      if (json['RecordCount'] is String) {
        recordCount = int.parse(json['RecordCount']);
      } else if (json['RecordCount'] != null && json['RecordCount'] is int) {
        recordCount = json['RecordCount'];
      }
    }
    return Pagination(
      currentPage: currentPage,
      pageCount: pageCount,
      recordCount: recordCount,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CurrentPage'] = currentPage;
    data['PageCount'] = pageCount;
    data['RecordCount'] = recordCount;
    return data;
  }

  factory Pagination.init() {
    return Pagination(currentPage: 0, pageCount: 1, recordCount: 0);
  }
}
