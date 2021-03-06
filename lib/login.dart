import 'package:SoulMatee/dashboard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'RegisterRequestViewModel.dart';
import 'RegisterResponseViewModel.dart';
import 'utilities.dart';
import 'holder.dart';
import 'serviceProvider.dart';

class Login extends StatelessWidget {
  Login({Key key, this.isSignInParam = true}) : super(key: key);
  final bool isSignInParam;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/dashboard': (context) => Dashboard(/*ModalRoute.of(context).settings.arguments*/),
      },
      // initialRoute: '/',
      // onGenerateRoute: RouteGenerator.generateRoute,
      // onUnknownRoute: (RouteSettings setting) {
      //   return new MaterialPageRoute(builder: (_) => NotFoundPage());
      // },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(isSignIn: isSignInParam),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.isSignIn = false}) : super(key: key);

  final bool isSignIn;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var languages = <String>['Türkçe', 'English'];
  RegisterResponseViewModel _register1;
  RegisterResponseViewModel _register2;
  Future<String> _deviceId;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController keyController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 70.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 30.0,
                        child: DropdownButton<String>(
                          // dropdownColor: Colors.transparent,
                          underline: Container(), //to remove underline
                          items: languages.map((String value) {
                            return new DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          value: Holder.isTurkish ? languages[0] : languages[1],
                          onChanged: (String newVal) {
                            setState(() {
                              Holder.isTurkish = newVal == languages[0];
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 80.0),
                      Text(
                        widget.isSignIn ? Holder.signIn : Holder.login,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      buildEmail(),
                      SizedBox(
                        height: 30.0,
                      ),
                      buildPassword(),
                      SizedBox(
                        height: 70.0,
                      ),
                      buildORText(),
                      SizedBox(
                        height: 10.0,
                      ),
                      buildLogin(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: Holder.enterEmail,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Holder.password,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: Holder.enterPassword,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[buildEnterButton()]))
      ],
    );
  }

  Widget buildORText() {
    return Column(
      children: <Widget>[
        Text(
          Holder.or,
          style: TextStyle(
            color: Colors.white38,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget buildLogin() {
    return Container(
        child: RichText(
      text: TextSpan(
          style: TextStyle(
            color: Colors.white54,
            letterSpacing: 1.5,
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
          children: <TextSpan>[
            TextSpan(text: Holder.clickHere),
            TextSpan(
                text: widget.isSignIn ? Holder.login2 : Holder.signIn,
                style: TextStyle(
                  color: Colors.white54,
                  letterSpacing: 1.5,
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Login(isSignInParam: !widget.isSignIn);
                    }));
                  }),
          ]),
    ));
  }

  Widget buildEnterButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: 100.0,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            
            register(RegisterRequestViewModel(
                    email: emailController.text,
                    password: passwordController.text,
                    isTurkish: Holder.isTurkish,
                    deviceId: "deneme"))
                .then((value) {
              setState(() {
                _register1 = value;
              });
            });
            // Then koyduğum için data'nın gelmesini bekliyor, o yüzden null olmuyor hiç, daha sonra async yaparsın.
            // if (isLoading) {
            //   alert();
            //   Alert(
            //     closeFunction: () => alert(),
            //           context: context,
            //           title: Holder.processing,
            //           content: CircularProgressIndicator())
            //       .show();
            // } else {
            Alert(
                context: context,
                title: Holder.enterKey,
                content: TextField(
                  controller: keyController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: Holder.key,
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6)
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/dashboard'/*, arguments: 3*/);
                    },
                    child: Text(
                      Holder.send,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Icon(
            Icons.arrow_forward,
            color: Color(0xFF527DAA),
            size: 30.0,
          )),
    );
  }
}
