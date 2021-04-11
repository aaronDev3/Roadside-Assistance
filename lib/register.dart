import 'package:byahero_app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool showPassword = true;
  bool showConfirmPassword = true;
  String email, password, confirmPassword;
  final formKey = GlobalKey<FormState>();

  void createUser(String email, String pass) {
    auth
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .then((authResult) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Account saved!"),
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
    }).catchError((e) {
      if (e.code == ("ERROR_WRONG_PASSWORD") ||
          e.code == ("ERROR_INVALID_EMAIL")) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("Invalid email. Try again!"),
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
      } else if (e.code == ("ERROR_EMAIL_ALREADY_IN_USE")) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("This email already used!"),
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
                /*Container(
                  height: MediaQuery.of(context).size.height * 0.135,
                  width: MediaQuery.of(context).size.width * 0.810,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image/byahero_logo.png"),
                    ),
                  ),
                ),*/
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
                          return "required";
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
                          return "required";
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
                          confirmPassword = textValue;
                        });
                      },
                      validator: (confirmPasswordValue) {
                        if (confirmPasswordValue.isEmpty) {
                          return "required";
                        }
                        return null;
                      },
                      obscureText: showConfirmPassword,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: "Confirm password",
                        suffixIcon: IconButton(
                          icon: showConfirmPassword
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () => {
                            setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            })
                          },
                        ),
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
                        if (password.trim() != confirmPassword.trim()) {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text("Password not matched!"),
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
                        } else if (password.length <= 5) {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text(
                                    "Password must be at least 6 characters!"),
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
                        } else if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          createUser(email, password);
                        }
                      },
                      child: Text(
                        "Register",
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
                        "Already have an account ? ",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      GestureDetector(
                        child: Text(
                          "Sign-in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login())),
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
