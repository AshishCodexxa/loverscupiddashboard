import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_dashboard/constants/constants.dart';
import 'package:dating_app_dashboard/datas/app_info.dart';
import 'package:dating_app_dashboard/datas/user.dart';
import 'package:dating_app_dashboard/models/app_model.dart';
import 'package:dating_app_dashboard/screens/dashboard.dart';
import 'package:dating_app_dashboard/widgets/app_logo.dart';
import 'package:dating_app_dashboard/widgets/default_button.dart';
import 'package:dating_app_dashboard/widgets/default_card_border.dart';
import 'package:dating_app_dashboard/widgets/show_scaffold_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Variables
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscurePass = true;



  // static Future<User?> loginUsingEmailPassword( String email,  String password,  BuildContext context) async{
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //   try{
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //         email: email, password: password)
  //   }
  // }



  @override
  Widget build(BuildContext context) {


    FirebaseAuth? _auth;

    final firestore = FirebaseFirestore.instance;



    // Future<List> fetchAllContact() async {
    //   List contactList = [];
    //   DocumentSnapshot documentSnapshot =
    //   await firestore.collection('AppInfo').doc('settings').get();
    //   contactList = documentSnapshot.data()!['admin_username'];
    //   return contactList;
    // }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30.0),
        child: Center(
          child: SizedBox(
            width: 400,
            child: Card(
              shape: defaultCardBorder(),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    /// App logo
                    AppLogo(),
                    SizedBox(height: 10),

                    /// App name
                    Text(APP_NAME,
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    SizedBox(height: 20),
                    Text("Sign in with your username and password",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                    SizedBox(height: 22),

                    /// Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          /// Username field
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                labelText: "Username",
                                hintText: "Enter your username",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                prefixIcon: Icon(Icons.person_outline)),
                            keyboardType: TextInputType.emailAddress,
                            validator: (username) {
                              // Basic validation
                              if (username?.isEmpty ?? true) {
                                return "Please enter your username";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          /// Password field
                          TextFormField(
                            controller: _passController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              labelText: "Password",
                              hintText: "Enter your password",
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() => _obscurePass = !_obscurePass);
                                  }),
                            ),
                            obscureText: _obscurePass,
                            validator: (pass) {
                              if (pass?.isEmpty ?? true) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          /// Sign In button
                          SizedBox(
                            width: double.maxFinite,
                            child: DefaultButton(
                              child:
                                  Text("Sign In", style: TextStyle(fontSize: 18)),
                              onPressed: () async{
                                /// Validate form


                                String username = _usernameController.text.trim();
                                String password = _passController.text.trim();

                                QuerySnapshot snap = await FirebaseFirestore.instance.collection("AppInfo")
                                .where('admin_username', isEqualTo: username).get();

                                QuerySnapshot snaps = await FirebaseFirestore.instance.collection("AppInfo")
                                .where('admin_password', isEqualTo: password).get();

                                print(snap.docs[0]['admin_username']);
                                print(snaps.docs[0]['admin_password']);

                                Navigator.of(context).pushReplacement(
                                    new MaterialPageRoute(
                                        builder: (context) => Dashboard()));
                                showScaffoldMessage(
                                    context: context,
                                    scaffoldkey: _scaffoldKey,
                                    message: "Admin sign in successfully!");


/*

                                final String username = _usernameController.text.trim();
                                final String password = _passController.text.trim();

                                if(username.isEmpty){
                                  print("Username is Empty");
                                } else {
                                  if(password.isEmpty){
                                    print("Password is Empty");
                                  } else {




                                    QuerySnapshot snap = await FirebaseFirestore.instance.collection("AppInfo")
                                        .where("admin_username ", isEqualTo: username).get();
                                    AppModel().login(
                                      snap.docs[0]['settings'][0]['admin_username'],
                                      password,
                                    );
                                  }
                                }
*/

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}


