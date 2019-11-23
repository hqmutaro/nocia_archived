import 'package:nocia/domain/lecture.dart';
import 'package:nocia/domain/term.dart';

class LectureDTO {

  static Lecture decode(Map<String, dynamic> map) {
    return Lecture(
        name: map["name"],
        id: map["id"],
        staffList: map["staffs"],
        grade: map["grade"],
        term: getTerm(map["term"])
    );
  }

  static Map<String, dynamic> encode(Lecture lecture) {
    return <String, dynamic>{
      "name": lecture.name,
      "staffs": lecture.staffList,
      "grade": lecture.grade,
      "term": getTermId(lecture.term)
    };
  }
}