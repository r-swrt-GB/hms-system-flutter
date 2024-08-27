String coalesceString(value) {
  if (value == null || (value is String && value.isEmpty)) {
    return '';
  }
  return value;
}

dynamic coalesceNull(value) {
  if (value == null || (value is String && value.isEmpty)) {
    return null;
  }
  return value;
}

coalesceDate(data) {
  if (data == null || data == "") return null;
  DateTime parsed = DateTime.parse(data).toLocal();
  return DateTime(
    parsed.year,
    parsed.month,
    parsed.day,
    parsed.hour,
    parsed.minute,
    parsed.second,
  );
}

coalesceObject<T>(map, key, func) {
  if (map.containsKey(key) && map[key] != null) {
    return func();
  } else {
    return null;
  }
}

coalesceList<T>(map, key, func) {
  if (map.containsKey(key) && map[key] != null) {
    return func();
  } else {
    return <T>[];
  }
}

int coalesceInt(String? value) {
  if (value == null || value.isEmpty) {
    return 0;
  }
  return int.parse(value);
}
