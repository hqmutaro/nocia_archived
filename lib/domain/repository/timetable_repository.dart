import 'package:nocia/domain/lecture.dart';

abstract class TimetableRepository {
  Future<dynamic> createTimetable();
  Future<dynamic> lectureTimetables();
  Future<void> setLecture(int cell, Lecture lecture);
  Future<void> deleteLecture(int cell);
}