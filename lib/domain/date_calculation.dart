Map<String, List<String>> getLackFoodList() {
  var lackFoodMap = <String, List<String>>{}; // var <Day, List<Time>>
  var homecomingDay = DateTime(2019, 10, 25);
  var returningDay = DateTime(2019, 10, 27);

  var diff = returningDay.difference(homecomingDay);
}


enum Timing {
  Morning,
  Noon,
  Evening
}

Timing getTiming(int hour) {
  if (hour >= 18) {
    return Timing.Evening;
  }
  if (hour >= 12) {
    return Timing.Noon;
  }
  return Timing.Morning;
}

