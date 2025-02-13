

String interpolate(String string, List<Object> params) {
  String result = string;
  for (int i = 1; i < params.length + 1; i++) {
    result = result.replaceAll('{%$i}', params[i - 1].toString());
  }

  return result;
}

extension StringExtension on String {
  /// const String text = 'Today is {%1} and tomorrow is {%2}';
  /// final List<Object> placeHolders = ['Monday', 'Tuesday'];
  String format(List<Object> params) => interpolate(this, params);
}
