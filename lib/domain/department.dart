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
  switch (department) {
    case Department.MECHANICAL_SYSTEMS_ENGINEERING:
      return 11;
    case Department.INFORMATION_AND_COMMUNICATION_SYSTEMS_ENGINEERING:
      return 12;
    case Department.MEDIA_INFORMATION_ENGINEERING:
      return 13;
    case Department.BIOLOGICAL_RESOURCES_ENGINEERING:
      return 14;
    default:
      throw Exception("Department Not Found");
  }
}

int getCourseId(Course course) {
  switch (course) {
    case Course.MECHANICAL_SYSTEMS_ENGINEERING:
      return 21;
    case Course.ELECTRONIC_COMMUNICATION_SYSTEMS_ENGINEERING:
      return 22;
    case Course.INFORMATION_ENGINEERING:
      return 23;
    case Course.BIO_RESOURCES_ENGINEERING:
      return 24;
    default:
      throw Exception("Course Not Found");
  }
}