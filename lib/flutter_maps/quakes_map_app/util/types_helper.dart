class TypesHelper {
  static int toInt(num? val) {
    try {
      if (val == null) {
        return 0;
      } else if (val is int) {
        return val;
      } else {
        return val.toInt();
      }
    } catch (error) {
      print(error);
      return 0;
    }
  }

  static double toDouble(num? val) {
    try {
      if (val == null) {
        return 0.0;
      } else if (val is double) {
        return val;
      } else {
        return val.toDouble();
      }
    } catch (error) {
      print(error);
      return 0.0;
    }
  }
}
