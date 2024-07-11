import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? value;
  String? id, userName, newNama, newNohp, newEmail;

  Future<void> saveSession(int val, String id, String username, String email,
      String no_tlp, String alamat, String nik) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("value", val);
    pref.setString("id", id);
    pref.setString("username", username);
    pref.setString("email", email);
    pref.setString("no_tlp", no_tlp);
    pref.setString("alamat", alamat);
    pref.setString("nik", nik);
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getInt("value");
    pref.getString("id");
    pref.getString("username");
    pref.getString("email");
    pref.getString("no_tlp");
    pref.getString("alamat");
    pref.getString("nik");
    return value;
  }

  Future getSesiIdUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("id");
    return id;
  }

  Future<void> updateUsername(
    String newUsername,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("username", newUsername);
  }

  Future<void> updateNama(
    String newNama,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("nama", newNama);
  }

  Future<void> updateNohp(
    String newNohp,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("nohp", newNohp);
  }

  Future<void> updateEmail(
    String newEmail,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("email", newEmail);
  }

  //clear session --> logout
  Future clearSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}

SessionManager session = SessionManager();
