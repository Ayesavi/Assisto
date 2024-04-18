Map<String, dynamic> ignoreNullFields(Map<String, dynamic> inputMap) {
  final Map<String, dynamic> resultMap = {};
  inputMap.forEach((key, value) {
    if (value != null) {
      resultMap[key] = value;
    }
  });
  return resultMap;
}
