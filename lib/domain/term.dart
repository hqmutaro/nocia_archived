enum Term {
  First,
  Final
}

Term getTerm(int term) {
  if (term == 0) {
    return Term.First;
  }
  if (term == 1) {
    return Term.Final;
  }
  throw Exception("Not Found This Term");
}