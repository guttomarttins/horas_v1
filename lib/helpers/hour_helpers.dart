class HourHelper{
  static int hoursToMinutes(String hours){
    List<String> parts = hours.split(':');
    int h = int.parse(parts[0]);
    int m = int.parse(parts[1]);
    return (h * 60) + m;
  }

  static String minutesToHours(int minutos){
    int h = minutos ~/ 60;
    int m = minutos % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }
}