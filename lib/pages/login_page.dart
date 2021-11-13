import 'package:catelog_app/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async{
    if(_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });

      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);

      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              const SizedBox(height: 40),

              Image.asset(
                  "lib/assets/images/login_image.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),

              Text(
                "Welcome $name",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [

                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Enter Username",
                          labelText: "Username"
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "username cannot be empty";
                        }
                        else{
                          return null;
                        }
                      },
                      onChanged: (value){
                        setState(() {
                          name = value;
                        });
                      },
                    ),

                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "password cannot be empty";
                        }
                        else{
                          if(value.length <= 6){
                            return "password length must be atleast six";
                          }
                          else{
                            return null;
                          }
                        }
                      },

                    ),

                    const SizedBox(height: 40),

                    Material(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(changeButton ? 40 : 8),
                      child: InkWell(
                        onTap: () => moveToHome(context),
                        child: AnimatedContainer(
                          width: changeButton ? 60 : 150,
                          height: 40,
                          alignment: Alignment.center,
                          duration: const Duration(seconds: 1),
                          child: changeButton ? const Icon(Icons.done,color: Colors.white) : const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}