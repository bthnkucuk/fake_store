String firstLetterUpper(String letters) {
  return letters.toString()[0].toUpperCase() +
      letters.toString().substring(1).toLowerCase();
}
