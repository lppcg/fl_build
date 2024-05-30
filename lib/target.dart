/// Which is also called [Platform], but the Dart SDK already defines a class 
/// with that name, so we'll call it [Target].
enum Target {
  android,
  ios,
  web,
  mac(aliases: ["macos"]),
  win(aliases: ["windows"]),
  linux,
  ;

  const Target({
    this.aliases = const [],
  });

  final List<String> aliases;

  static Target fromString(String str) {
    str = str.toLowerCase();
    for (final item in values) {
      if (item.name == str) return item;
      if (item.aliases.contains(str)) return item;
    }
    throw ArgumentError('Invalid target: $str');
  }
}
