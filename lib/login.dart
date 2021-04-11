import 'package:byahero_app/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

/*void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(title: 'Tabang byahero'),
    );
  }
}*/

class Login extends StatefulWidget {
  @override
  Login({Key key, this.title}) : super(key: key);

  final String title;
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool showPassword = true;
  String email, password;
  final formKey = GlobalKey<FormState>();

  void signIn(String inputEmail, String inputPassword) {
    auth
        .signInWithEmailAndPassword(
            email: inputEmail.trim(), password: inputPassword)
        .then((authResut) {
      //MenuDrawer('B');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }).catchError((e) {
      if (e.code == ("ERROR_WRONG_PASSWORD") ||
          e.code == ("ERROR_INVALID_EMAIL")) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("Incorrect email and password!"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      } else if (e.code == ("ERROR_TOO_MANY_REQUESTS")) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                  "This account has been temporarily disable due to many failed login attempts! Try again later."),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      } else if (e.code == ("ERROR_USER_NOT_FOUND")) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("User not found!"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/login.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //height: 110,
                  //width: 328,
                  height: MediaQuery.of(context).size.height * 0.135,
                  width: MediaQuery.of(context).size.width * 0.810,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image/byahero_logo.png"),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 23, bottom: 10, left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: TextFormField(
                      onChanged: (textValue) {
                        setState(() {
                          email = textValue;
                        });
                      },
                      validator: (emailValue) {
                        if (emailValue.isEmpty) {
                          return null;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person_outline),
                        hintText: "Email",
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: TextFormField(
                      onChanged: (textValue) {
                        setState(() {
                          password = textValue;
                        });
                      },
                      validator: (passwordValue) {
                        if (passwordValue.isEmpty) {
                          return null;
                        }
                        return null;
                      },
                      obscureText: showPassword,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: "Password",
                        suffixIcon: IconButton(
                            icon: showPassword
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () => {
                                  setState(() {
                                    showPassword = !showPassword;
                                  })
                                }),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: Colors.blue,
                    ),
                    child: FlatButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          signIn(email, password);
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ? ",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      GestureDetector(
                        child: Text(
                          "Sign-up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register())),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
