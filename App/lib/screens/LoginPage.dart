import 'package:flutter/material.dart';
import 'package:houseapp/helpers/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bool _obscureText = true;
  // late bool _displayRegister = false;

  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();

  final prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Container(
          color: const Color.fromRGBO(173, 195, 209, 0.2),
          child: Center(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(10, MediaQuery.of(context).size.height *0.2, 10, 10),
              children: <Widget>[
                Image(
                  image: Image.asset('assets/logo1.png').image,
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 10),
                // _displayRegister
                //     ? _signUpButtons()
                //     :
                _signInButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _signInButtons() {
    return Column(
      children: <Widget> [
        SizedBox(
          width: 400,
          child: TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Enter Email",
                labelText: "Email"
            ),
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
        ),
        SizedBox(
          width: 400,
          child: TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: "Enter Password",
              labelText: "Password",
            ),
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscureText,
            controller: _passwordController,
          ),
        ),
        const SizedBox(height: 15),
        InkWell(
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blue,
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (ctxDialog){
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    elevation: 16,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        const Center(child: Text('Forgot Password')),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 400,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: "Enter Email",
                                labelText: "Email"
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Auth().forgotPassword(_emailController.text);

                                  setState(() {
                                    _emailController.text = "";
                                  });
                                  Navigator.of(ctxDialog).pop();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    'Reset Password',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ),
                            const SizedBox(width: 15),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(ctxDialog).pop();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Text(
                                        'Close',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }
            );
          },
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Auth().signIn(_emailController.value.text, _passwordController.value.text).then((resp) async {
                  if(resp == null){
                    var snackBar = const SnackBar(content: Text("Please enter Email or password"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // _displayRegister = true;
                  _displayNameController.text = "";
                  _emailController.text = "";
                  _passwordController.text = "";
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  // Widget _signUpButtons() {
  //   return Column(
  //     children: <Widget> [
  //       SizedBox(
  //         width: 400,
  //         child: TextFormField(
  //           decoration: const InputDecoration(
  //               prefixIcon: Icon(Icons.person),
  //               hintText: "Enter Name",
  //               labelText: "Display Name"
  //           ),
  //           keyboardType: TextInputType.text,
  //           controller: _displayNameController,
  //         ),
  //       ),
  //       SizedBox(
  //         width: 400,
  //         child: TextFormField(
  //           decoration: const InputDecoration(
  //               prefixIcon: Icon(Icons.email),
  //               hintText: "Enter Email",
  //               labelText: "Email"
  //           ),
  //           keyboardType: TextInputType.emailAddress,
  //           controller: _emailController,
  //         ),
  //       ),
  //       SizedBox(
  //         width: 400,
  //         child: TextFormField(
  //           decoration: const InputDecoration(
  //             prefixIcon: Icon(Icons.lock),
  //             hintText: "Enter Password",
  //             labelText: "Password",
  //           ),
  //           keyboardType: TextInputType.visiblePassword,
  //           obscureText: _obscureText,
  //           controller: _passwordController,
  //         ),
  //       ),
  //       const SizedBox(height: 15),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           ElevatedButton(
  //             onPressed: () {
  //               setState(() {
  //                 _displayRegister = false;
  //                 _displayNameController.text = "";
  //                 _emailController.text = "";
  //                 _passwordController.text = "";
  //               });
  //             },
  //             child: const Padding(
  //               padding: EdgeInsets.all(0),
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: EdgeInsets.all(0),
  //                     child: Text(
  //                       'Back to Login',
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //           const SizedBox(width: 15),
  //           ElevatedButton(
  //             onPressed: () {
  //               Auth().createUser(_emailController.value.text, _passwordController.value.text).then((resp) async {
  //                 if(resp == null){
  //                   var snackBar = const SnackBar(content: Text("Please enter Email or password"));
  //                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //                 }
  //                 else{
  //                   FirebaseFirestore.instance
  //                       .collection("users")
  //                       .doc(resp)
  //                       .set({
  //                     "emailId": _emailController.text,
  //                     "username": _displayNameController.text,
  //                   }).then((value) {
  //                     var snackBar = const SnackBar(content: Text("User added and logged in Successfully."));
  //                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //                   });
  //                 }
  //               });
  //             },
  //             child: const Padding(
  //               padding: EdgeInsets.all(0),
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: EdgeInsets.all(0),
  //                     child: Text(
  //                       'Register',
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ],
  //   );
  // }
}