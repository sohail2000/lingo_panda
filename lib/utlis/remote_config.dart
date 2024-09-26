import 'package:firebase_remote_config/firebase_remote_config.dart';



Future<bool> getEmailMaskingSetting() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate(); 
  final maskEmail = remoteConfig.getBool('mask_email');
  print("shouldMaskEmail: ${maskEmail}");
  return maskEmail;

}