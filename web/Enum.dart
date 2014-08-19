library ENUM;

abstract class Enum<T>
{
  final T value;
  const Enum(this.value);
  toString() => "${this.value}";
}