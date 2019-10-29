enum Department {
  MECHANICAL_SYSTEMS_ENGINEERING,
  INFORMATION_AND_COMMUNICATION_SYSTEMS_ENGINEERING,
  MEDIA_INFORMATION_ENGINEERING,
  BIOLOGICAL_RESOURCES_ENGINEERING,
  ADVANCED
}

enum Course {
  MECHANICAL_SYSTEMS_ENGINEERING,
  ELECTRONIC_COMMUNICATION_SYSTEMS_ENGINEERING,
  INFORMATION_ENGINEERING,
  BIO_RESOURCES_ENGINEERING
}

int getDepartmentId(Department department) {
  if (department == Department.MECHANICAL_SYSTEMS_ENGINEERING) {
    return 11;
  }
  if (department == Department.INFORMATION_AND_COMMUNICATION_SYSTEMS_ENGINEERING) {
    return 12;
  }
  if (department == Department.MEDIA_INFORMATION_ENGINEERING) {
    return 13;
  }
  if (department == Department.BIOLOGICAL_RESOURCES_ENGINEERING) {
    return 14;
  }
  throw Exception("Department Not Found");
}

int getCourseId(Course course) {
  if (course == Course.MECHANICAL_SYSTEMS_ENGINEERING) {
    return 21;
  }
  if (course == Course.ELECTRONIC_COMMUNICATION_SYSTEMS_ENGINEERING) {
    return 22;
  }
  if (course == Course.INFORMATION_ENGINEERING) {
    return 23;
  }
  if (course == Course.BIO_RESOURCES_ENGINEERING) {
    return 24;
  }
  throw Exception("Course Not Found");
}