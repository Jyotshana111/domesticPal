import 'package:domestic_pal/screens/home_employee/update_details.dart';
import 'package:domestic_pal/shared/emploading.dart';
import 'package:flutter/material.dart';
import 'package:domestic_pal/services/auth_employee.dart';
import 'package:domestic_pal/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterEmployee extends StatefulWidget {
  final Function toggleView;
  RegisterEmployee({this.toggleView});

  @override
  _RegisterEmployeeState createState() => _RegisterEmployeeState();
}

class _RegisterEmployeeState extends State<RegisterEmployee> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  bool _showPassword = false;

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          setState(() => loading = true);
          dynamic result = await _auth
              .registerWithEmailAndPasswordEmployee(
              email, password);
          if (result == null) {
            setState(() => error =
            'could not register with those credentials');
            loading = false;
          } else {
            setState(() => error = 'Registered successfully');

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => UpdateEmployeeDetails()),
                    (Route<dynamic> route) => false);
          }
        }
      },
      child: Container(

        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors:[Color(0xffffd22e),Color(0xffdc85ff)]
            )),
        child: Text(
          'Register',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? emploading()
        : Scaffold(
            /*backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              //elevation: 0.0,
              //title: Text('domesticPal'),
            ),*/
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                 decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg2.png'),
                    fit: BoxFit.cover,
                )),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 150.0),
                      RichText(
                        textAlign: TextAlign.center,
                         text: TextSpan(
                           text: 'domesticPal',
                        style: GoogleFonts.dancingScript(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 60,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87
                        ),
                         )
                      ),
                      SizedBox(height: 40.0),
                      /*TextFormField(
                        decoration:
                            textInputDecorationEmp.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),*/
                      Container(
                          margin:EdgeInsets.symmetric(vertical: 10),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Email ID',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration:
                                InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true
                                ),
                                validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                            ],
                          )

                      ),
                      SizedBox(height: 20.0),
                      /*TextFormField(
                        obscureText: true,
                        decoration: textInputDecorationEmp.copyWith(
                            hintText: 'Password'),
                        validator: (val) =>
                            val.length < 6 ? 'Enter a password' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),*/
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Password',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      //labelText: 'Password',
                                      //hintText: 'Enter your password',
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _showPassword
                                              ? Icons.visibility_sharp
                                              : Icons.visibility_off_sharp,
                                          color: Colors.blueGrey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _showPassword = !_showPassword;
                                          });
                                        },
                                      )),
                                  obscureText: !_showPassword,
                                  validator: (val) => val.length < 6
                                      ? 'Enter a password 6+ chars long'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  }),
                            ]

                        ),
                      ),
                      SizedBox(height: 40.0),
                      _submitButton(),
                      /*RaisedButton(
                        color: Colors.cyan[800],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),

                      ),*/
                      SizedBox(height: 15.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                          FlatButton(
                            child: Text('Login',
                                style: TextStyle(color: Color(0xffdc85ff))),
                            onPressed: () {
                              widget.toggleView();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
