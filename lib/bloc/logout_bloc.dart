import 'package:responsi1_muthiakhanza_c/helpers/user_info.dart';

class LogoutBloc {
  static Future logout() async {
    await UserInfo().logout();
  }
}
