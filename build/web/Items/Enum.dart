library ENUM;

abstract class Enum<T,N>
{
  final T value;
  final N NAME;
  const Enum(this.value, this.NAME);
  toString() => "${this.value}";
}