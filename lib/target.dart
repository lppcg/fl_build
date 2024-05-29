/// Which is also called [Platform], but the Dart SDK already defines a class 
/// with that name, so we'll call it [Target].
enum Target {
  android,
  ios,
  web,
  mac,
  win,
  linux,
  ;

  static Target fromString(String str) {
    for (final item in values) {
      if (item.name == str) return item;
    }
    throw ArgumentError('Invalid target: $str');
  }
}
