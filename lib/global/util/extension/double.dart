extension DoubleExtension on double? {
  String toString2(){
    if(this == null) return '0.0';
    return this!.toString();
  }
}