abstract class StateType {
  static const queensland = 1;
  static const southAustralia = 2;
  static const tasmania = 3;
  static const victoria = 4;
  static const westernAustralia = 5;
  static const northernTerritory = 6;
  static const australianCapitalTerritory = 7;
  static const newSouthWales = 8;

  static String stateTypeToString(int stateType) {
    switch (stateType) {
      case queensland:
        return 'Queensland';

      case southAustralia:
        return 'South Australia';

      case tasmania:
        return 'Tasmania';

      case victoria:
        return 'Victoria';

      case westernAustralia:
        return 'Western Australia';

      case northernTerritory:
        return 'Northern Territory';

      case australianCapitalTerritory:
        return 'Australian Capital Territory';

      case newSouthWales:
      default:
        return 'New South Wales';
    }
  }
}
