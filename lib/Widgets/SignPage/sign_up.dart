import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mindfocus/Services/authentication.dart';
import 'package:url_launcher/url_launcher.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool policy = true;
  bool name = true;
  bool email = true;
  bool pass = true;
  String nameerr="Must be at least 3 character";
  String emailerr="Must have a valid email address";
  String passerr="Must be at least 6 character";
  String policyerr="Please confirm the privacy policy";
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E1643),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
              child: Container(
                child:Image.asset("assets/signpage/Vector1.png")
          )),
          Positioned(
            bottom: 0,
            right: 0,
              child: Container(
                child:Image.asset("assets/signpage/Vector2.png")
          )),
          Positioned(
            top: 0,
            right:0,
              child: Container(
                child:Image.asset("assets/signpage/Vector3.png")
          )),
          Positioned(
              top: 0,
              right:0,
              child: Container(
                child:Image.asset("assets/signpage/Vector4.png")
          )),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only( top:40.0,left: 10),
                      child: IconButton(onPressed: ()=>Navigator.pop(context),icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),iconSize: 35,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0,bottom: 20),
                    child: Center(
                      child: Text("Create your account",style: TextStyle(fontSize: 28,fontFamily: "Helvetica Neue",color: Colors.white70),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 60,
                      child: ElevatedButton(
                        style:ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(40.0))),
                          backgroundColor: MaterialStateProperty.all(Color(0xFF5F69B6)),
                        ),
                        onPressed: () async{
                        String msg= await context.read<Authentication>().signInWithFacebook();
                       if(msg!="true"){
                            Flushbar(
                            icon: ImageIcon(AssetImage('assets/logo.jpg'),color: Colors.blueAccent,),
                            backgroundColor: Colors.transparent,
                            barBlur:05 ,
                            flushbarStyle: FlushbarStyle.GROUNDED,
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            borderRadius: BorderRadius.circular(8),
                            title:  "Mindfocus",
                            message:  msg,
                            duration:  Duration(seconds: 5),
                            )..show(context);
                           }else{
                         Navigator.pop(context);
                       }
                        },
                        child: Center(
                          child: ListTile(
                            title: Text(
                              "CONTINUE WITH FACEBOOK",
                              style: TextStyle(color: Colors.white,fontFamily: "Helvetica Neue",fontSize: 15),
                            ),
                            leading: Image.asset("assets/signpage/facebook.png",width: 25,height: 25,color: Colors.white,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border:Border.all(color: Colors.white,width: 0.5),
                          borderRadius: BorderRadius.circular(40.0)
                      ),
                      child: ElevatedButton(
                        style:ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0),
                              )),

                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                        },
                        child: Center(
                          child: ListTile(
                            onTap: ()async{
                              String msg= await context.read<Authentication>().signInWithGoogle(context);
                              if(msg!="true"){
                                Flushbar(
                                  icon: ImageIcon(AssetImage('assets/logo.jpg'),color: Colors.blueAccent,),
                                  backgroundColor: Colors.transparent,
                                  barBlur:05 ,
                                  flushbarStyle: FlushbarStyle.GROUNDED,
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  borderRadius: BorderRadius.circular(8),
                                  title:  "Mindfocus",
                                  message:  msg,
                                  duration:  Duration(seconds: 5),
                                )..show(context);
                              }else{
                                Navigator.pop(context);
                              }
                            },
                            title: Text(
                              "CONTINUE WITH GOOGLE",
                              style: TextStyle(color: Colors.white,fontFamily: "Helvetica Neue",fontSize: 15),
                            ),
                            leading: Image.asset("assets/signpage/google.png",width: 25,height: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only( bottom: 15),
                    child: Center(
                      child: Text("OR SIGN UP WITH EMAIL",style: TextStyle(fontSize: 15,fontFamily: "Helvetica Neue",color: Colors.white,),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 15),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          errorText:name ? null : nameerr ,
                          filled: true,
                          errorStyle: TextStyle(color: Colors.redAccent),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter your name'),
                    ),
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          errorText:email ? null : emailerr ,
                          filled: true,
                          errorStyle: TextStyle(color: Colors.redAccent),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          hintText: 'Email address'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          errorText:pass ? null : passerr,
                          filled: true,
                          errorStyle: TextStyle(color: Colors.redAccent),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          hintText: 'Enter secure password'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child:Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white70),
                      child: CheckboxListTile(
                        value: policy,
                        onChanged: (bool value) {
                          setState(() {
                          policy=value;});
                        },
                        subtitle: policy?null:Text(policyerr,style: TextStyle(color: Colors.redAccent),),
                        title: Row(children: [
                          Text("I have read the",style: TextStyle(color: Colors.white70),),
                          TextButton(onPressed: (){_launchInBrowser("http://sayhiproduction.co/mind-focuss.docx");},child: Text("Privace Policy")),
                        ],),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 20),
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Color(0xFF777BF1), borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: ()async {
                          setState(() {
                            if (nameController.text.length < 3)
                              name = false;
                            else
                              name = true;
                            if (passwordController.text.length < 6)
                              pass = false;
                            else
                              pass=true;
                            email = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(emailController.text);
                          });
                          if(name&&pass&&policy&&email){
                            String msg= await context.read<Authentication>().signUp(
                              email: emailController.text.trim(),
                              name: nameController.text,
                              password: passwordController.text.trim(),
                            );
                            if(msg!="true"){
                              Flushbar(
                                icon: ImageIcon(AssetImage('assets/logo.jpg'),color: Colors.blueAccent,),
                                backgroundColor: Colors.transparent,
                                barBlur:05 ,
                                flushbarStyle: FlushbarStyle.GROUNDED,
                                flushbarPosition: FlushbarPosition.BOTTOM,
                                borderRadius: BorderRadius.circular(8),
                                title:  "Mindfocus",
                                message:  msg,
                                duration:  Duration(seconds: 5),
                              )..show(context);
                            }else{
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
