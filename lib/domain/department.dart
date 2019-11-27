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
  BIO_RESOURCES_ENGINEERING,
  NONE
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
    case Department.ADVANCED:
      return 15;
    default:
      throw Exception("Department Not Found");
  }
}

Department getDepartment(int id) {
  switch (id) {
    case 11:
      return Department.MECHANICAL_SYSTEMS_ENGINEERING;
    case 12:
      return Department.INFORMATION_AND_COMMUNICATION_SYSTEMS_ENGINEERING;
    case 13:
      return Department.MEDIA_INFORMATION_ENGINEERING;
    case 14:
      return Department.BIOLOGICAL_RESOURCES_ENGINEERING;
    case 15:
      return Department.ADVANCED;
    default:
      throw Exception("ID Not Found");
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
    case Course.NONE:
      return 0;
    default:
      throw Exception("Course Not Found");
  }
}

Course getCourse(int id) {
  switch (id) {
    case 21:
      return Course.MECHANICAL_SYSTEMS_ENGINEERING;
    case 22:
      return Course.ELECTRONIC_COMMUNICATION_SYSTEMS_ENGINEERING;
    case 23:
      return Course.INFORMATION_ENGINEERING;
    case 24:
      return Course.BIO_RESOURCES_ENGINEERING;
    default:
      return Course.NONE;
  }
}