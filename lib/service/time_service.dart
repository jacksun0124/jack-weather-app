class TimeService {
  unixToDateTime(int unixTime) {
    return DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
  }
}
