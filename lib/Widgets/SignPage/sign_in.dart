import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mindfocus/Widgets/SignPage/sign_up.dart';
import 'package:provider/provider.dart';
import 'package:mindfocus/Services/authentication.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool email = true;
  bool pass = true;
  String emailerr="Must have a valid email address";
  String passerr="Must be at least 6 character";

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color(0xFF0E1643),
      body:  Stack(
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
                Padding(
                  padding: const EdgeInsets.only(top: 60.0,bottom: 20),
                  child: Center(
                    child: Text("Welcome Back!",style: TextStyle(fontSize: 28,fontFamily: "Helvetica Neue",color: Colors.white),),
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
                      onPressed: ()async{
                        String msg =await context.read<Authentication>().signInWithGoogle(context);
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
                        }
                      },
                      child: Center(
                        child: ListTile(

                          title: Text(
                            "CONTINUE WITH GOOGLE",
                            style: TextStyle(color: Colors.white,fontFamily: "Helvetica Neue",fontSize: 15),
                          ),
                          leading: Image.asset("assets/signpage/google.png",width: 25,height: 25,),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      onPressed: ()async{
                        String msg =await context.read<Authentication>().signInAnonymus();
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
                        }
                      },
                      child: Center(
                        child: ListTile(

                          title: Text(
                            "CONTINUE WITH GUEST",
                            style: TextStyle(color: Colors.white,fontFamily: "Helvetica Neue",fontSize: 15),
                          ),
                          leading: Image.asset("assets/signpage/google.png",width: 25,height: 25,),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Center(
                    child: Text("OR LOG IN WITH EMAIL",style: TextStyle(fontSize: 15,fontFamily: "Helvetica Neue",color: Colors.white,),),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        errorText:email ? null : emailerr ,
                        errorStyle: TextStyle(color: Colors.redAccent),
                        filled: true,
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
                        errorText:pass ? null : passerr ,
                        errorStyle: TextStyle(color: Colors.redAccent),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        hintText: 'Enter secure password'),
                  ),
                ),
                TextButton(
                  onPressed: ()async{
                    if(emailController.text.isEmpty){
                      Flushbar(
                        icon: ImageIcon(AssetImage('assets/logo.jpg'),color: Colors.blueAccent,),
                        backgroundColor: Colors.transparent,
                        barBlur:05 ,
                        flushbarStyle: FlushbarStyle.GROUNDED,
                        flushbarPosition: FlushbarPosition.BOTTOM,
                        borderRadius: BorderRadius.circular(8),
                        title:  "Mindfocus",
                        message:  "Please Enter your email address",
                        duration:  Duration(seconds: 5),
                      )..show(context);
                    }else{
                     String msg= await context.read<Authentication>().resetPassword(emailController.text);
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
                    }
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Color(0xFF777BF1), borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () async{
                      setState(() {
                        if(passwordController.text.length<6)
                          pass=false;
                        else
                          pass=true;
                        email = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text);
                      });
                      if(email&&pass){
                        String msg=await context.read<Authentication>().signIn(
                          email: emailController.text.trim(),
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
                        }
                      }


                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));
                },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New User?',style: TextStyle(color: Colors.white70,),),
                        Text(' Create Account',style: TextStyle(color: Colors.indigo,),),
                      ],
                    )
                )
              ],
          ),
        ),
            ),]
      ),
    );
  }
}
