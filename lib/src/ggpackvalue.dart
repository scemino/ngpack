enum GGPackValueKind { Null, Map, Array, Int, Double, String }

class GGPackValue {
  GGPackValueKind _kind;
  Map<String, GGPackValue> _map;
  List<GGPackValue> _array;
  String _string;
  int _int;
  double _double;

  GGPackValue() {
    _kind = GGPackValueKind.Null;
  }

  GGPackValue.fromMap(Map<String, GGPackValue> map) {
    _kind = GGPackValueKind.Map;
    _map = map;
  }

  GGPackValue.fromArray(List<GGPackValue> array) {
    _kind = GGPackValueKind.Array;
    _array = array;
  }

  GGPackValue.fromString(String string) {
    _kind = GGPackValueKind.String;
    _string = string;
  }

  GGPackValue.fromInt(int value) {
    _kind = GGPackValueKind.Int;
    _int = value;
  }

  GGPackValue.fromDouble(double value) {
    _kind = GGPackValueKind.Double;
    _double = value;
  }

  GGPackValueKind getKind() {
    return _kind;
  }

  String getString() {
    return _string;
  }

  int getInt() {
    return _int;
  }

  double getDouble() {
    return _double;
  }

  List<GGPackValue> getArray() {
    return _array;
  }

  Map<String, GGPackValue> getMap() {
    return _map;
  }

  GGPackValue operator [](dynamic key) {
    if (key is String) {
      return _map[key];
    }
    return _array[key];
  }

  dynamic toJson() {
    switch(_kind){
      
      case GGPackValueKind.Null:
        return 'null';
      case GGPackValueKind.Map:
        return _map;
      case GGPackValueKind.Array:
        return _array;
      case GGPackValueKind.Int:
        return _int;
      case GGPackValueKind.Double:
        return _double;
      case GGPackValueKind.String:
        return _string;
    }
  }
}
