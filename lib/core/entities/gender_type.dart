abstract class GenderType {
  static const male = 1;
  static const female = 2;
  static const others = 3;

  static String genderTypeToString(int genderType) {
    switch (genderType) {
      case female:
        return 'Female';
      case others:
        return 'Others';
      case male:
      default:
        return 'Male';
    }
  }
}
