// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:houseapp/helpers/auth.dart';
// import 'package:houseapp/models/Constants.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/otp_field_style.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:houseapp/helpers/auth_provider.dart';
//
// class LoginPageScreen extends StatefulWidget {
//   const LoginPageScreen({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _LoginPageScreen();
// }
//
// class _LoginPageScreen extends State<LoginPageScreen>{
//   late String phone;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   late String verId;
//   late bool codeSent = false;
//   late String _pin;
//   late ConfirmationResult _confirmationResult;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Center(
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.3,
//                 width: MediaQuery.of(context).size.width * 0.3,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image:
//                     AssetImage('assets/logo1.png'),
//                   ),),),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 codeSent ?
//                 OTPTextField(
//                   length: 6,
//                   fieldWidth: 30,
//                   width: MediaQuery.of(context).size.width,
//                   style: const TextStyle(
//                       fontSize: 20
//                   ),
//                   textFieldAlignment: MainAxisAlignment.spaceAround,
//                   fieldStyle: FieldStyle.underline,
//                   onCompleted: (pin){
//                     setState(() {
//                       _pin = pin;
//                     });
//                   },
//                   keyboardType: TextInputType.number,
//                   obscureText: false,
//                   otpFieldStyle: OtpFieldStyle(
//                       borderColor: Colors.transparent
//                   ),
//                 ) :
//                 Padding(
//                   padding: const EdgeInsets.only(top:15,right: 15,left: 15),
//                   child: IntlPhoneField(
//                     decoration: const InputDecoration(
//                         labelText: 'Enter Phone Number',
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide()
//                         )
//                     ),
//                     initialCountryCode: 'IN',
//                     autofocus: true,
//                     onChanged: (phoneNumber) {
//                       setState(() {
//                         phone = phoneNumber.completeNumber;
//                       });
//                     },
//                     showDropdownIcon: false,
//                     showCountryFlag: false,
//                     searchText: 'Select your Country',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                     onPressed: (){
//                       codeSent ?
//                       verifyPin(_pin) :
//                       verifyPhone(phone);
//                     },
//                     child: Text(codeSent ? "Verify" : "Send OTP")
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void verifyPhone(String phoneNumber) async {
//     if(kIsWeb){
//       var confirmationResult = await Auth().signInWithPhoneNumber(phoneNumber);
//       setState(() {
//         codeSent = true;
//         _confirmationResult = confirmationResult;
//       });
//       print(codeSent.toString().toUpperCase());
//     }
//     else {
//       await _firebaseAuth.verifyPhoneNumber(
//           phoneNumber: phoneNumber,
//           verificationCompleted: (PhoneAuthCredential credential) async {
//             await _firebaseAuth.signInWithCredential(credential);
//             const snackBar = SnackBar(
//                 content: Text("Login Successfully Completed"));
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           },
//           verificationFailed: (FirebaseAuthException exception) {
//             final snackBar = SnackBar(content: Text("${exception.message}"));
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           },
//           codeSent: (String verificationId, int? resendToken) {
//             setState(() {
//               codeSent = true;
//               verId = verificationId;
//             });
//           },
//           codeAutoRetrievalTimeout: (String verificationId) {
//             setState(() {
//               verId = verificationId;
//             });
//           },
//           timeout: const Duration(seconds: 60));
//     }
//   }
//
//   void verifyPin(String pin) async {
//     if(kIsWeb) {
//       var user = await Auth().confirmOtp(_confirmationResult, pin);
//     }
//     else {
//       AuthProvider
//           .of(context)
//           .auth
//           .verifyMobilePin(pin, phone, verId, context)
//           .then((value) {
//
//       });
//     }
//   }
// }