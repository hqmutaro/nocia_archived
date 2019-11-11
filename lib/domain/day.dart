enum Day {
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY
}

String toString(Day day) =>
    day.toString().replaceFirst(day.toString().split('.')[0] + "." , "" );