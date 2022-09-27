class CheckInRecord {
  String user = "";
  String phone = "";
  DateTime checkInTime;

  CheckInRecord(this.user, this.phone, this.checkInTime);

  @override
  String toString() {
    return "Name: $user\n\n"
        "Contact Info: $phone\n\n"
        "Checked in at: $checkInTime\n\n";
  }
}