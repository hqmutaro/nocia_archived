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
  throw Exception("This Term Not Found");
}

int getTermId(Term term) {
  switch (term) {
    case Term.First:
      return 0;
    case Term.Final:
      return 1;
    default:
      throw Exception("ID Not Found");
  }
}