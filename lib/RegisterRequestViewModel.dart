import 'package:SoulMatee/helper.dart';

class RegisterRequestViewModel{
  final String email;
  final String password;
  final String deviceId;
  final bool isTurkish;
  RegisterRequestViewModel({this.email,this.password,this.isTurkish, this.deviceId});
  Map<String,dynamic> toJson() => { 
      "email": this.email,
      "password": this.password,
      "deviceId": this.deviceId,
      "isTurkish": this.isTurkish
  };
}