import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/register_cubit.dart';
import 'package:social_app/register_states.dart';
import 'package:social_app/shared_prefrences.dart';
import 'package:social_app/social_layout.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({Key? key}) : super(key: key);

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
if (state is CreateUserSuccessState) {
         
            CacheHelper.savaData(
                    key: 'uID', value: FirebaseAuth.instance.currentUser!.uid)
                .then((value) {
 Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => const SocialLayout()),
          (route) {
        return false;
      });




                });
          }
        


        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register'),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter name';
                            }
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'name',
                            border: OutlineInputBorder(),
                            prefix: Icon(Icons.person),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is Too Short';
                            }
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'email',
                            border: OutlineInputBorder(),
                            prefix: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter password';
                            }
                          },
                          controller: passController,
                          decoration: InputDecoration(
                            labelText: 'pass',
                            border: OutlineInputBorder(),
                            prefix: Icon(Icons.password),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter phone';
                            }
                          },
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'phone',
                            border: OutlineInputBorder(),
                            prefix: Icon(Icons.phone_android),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: state is RegisterLoadingState
                                ? Center(child: CircularProgressIndicator())
                                : MaterialButton(
                                    onPressed: () {
                                      SocialRegisterCubit.get(context)
                                          .userRegister(
                                        email: emailController.text,
                                        password: passController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                     
                                    },
                                    child: Text(
                                      'REGISTER',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                        SizedBox(
                          height: 30,
                        ),
                      
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
