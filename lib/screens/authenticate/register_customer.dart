import 'package:domestic_pal/screens/home_customer/update_details.dart';
import 'package:flutter/material.dart';
import 'package:domestic_pal/services/auth_customer.dart';
import 'package:domestic_pal/shared/constants.dart';
import 'package:domestic_pal/shared/cusloading.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterCustomer extends StatefulWidget {
  final Function toggleView;
  @override
  RegisterCustomer({this.toggleView});
  _RegisterCustomerState createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  final AuthService _authCustomer = AuthService();
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
            dynamic result = await _authCustomer
                .registerWithEmailAndPassword(
                email, password);
            if (result == null) {
              setState(() => error =
              'could not register with those credentials');
              loading = false;
            } else {
              setState(
                      () => error = 'registered successfully');
              //Navigator.pop(context);

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          UpdateCustomerDetails()),
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
        ? CusLoading()
        : Scaffold(
            /*appBar: AppBar(
              backgroundColor: Colors.amber[500],
              elevation: 0.0,
              title: Text('domesticPal'),
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
                      /*Text(
                        'Register as a Customer',
                        style: TextStyle(color: Colors.grey, fontSize: 20.0),
                      ),*/
                      SizedBox(height: 40.0),
                      /*TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: 'Email', hintText: 'Enter email'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          }),*/
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
                          decoration: textInputDecoration.copyWith(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
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
                          }),*/
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
