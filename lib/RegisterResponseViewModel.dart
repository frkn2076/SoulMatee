class RegisterResponseViewModel {
  final bool isSuccess;
  final DialogBox dialogBox;
  RegisterResponseViewModel({this.isSuccess, this.dialogBox});
  factory RegisterResponseViewModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseViewModel(
      isSuccess: json['isSuccess'],
      dialogBox: DialogBox.fromJson(json['dialogBox']),
    );
  }
}

class DialogBox {
  final String message;
  final String subMessage;
  final ButtonModel button;
  final bool hasTextBox;
  DialogBox({this.message, this.subMessage, this.button, this.hasTextBox});
  factory DialogBox.fromJson(Map<String, dynamic> json) {
    return DialogBox(
      message: json['message'],
      subMessage: json['subMessage'],
      button: ButtonModel.fromJson(json['button']),
      hasTextBox: json['hasTextBox'],
    );
  }
}

class ButtonModel {
  final String message;
  final String subMessage;
  final ConfirmationType type;
  ButtonModel({this.message, this.subMessage, this.type});
  factory ButtonModel.fromJson(Map<String, dynamic> json) {
    return ButtonModel(
      message: json['message'],
      subMessage: json['subMessage'],
      type: ConfirmationType.values[json['type']] ,
    );
  }
}

enum ConfirmationType { Ok, Cancel }


