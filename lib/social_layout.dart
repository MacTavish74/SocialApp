import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shopCubit.dart';
import 'package:social_app/shopStates.dart';

class SocialLayout extends StatefulWidget {
  const SocialLayout({super.key});

  @override
  State<SocialLayout> createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('News Feed'),
          ),
          body:  state is SocialGetUserSuccessState ?
          Column(children: [
                if (!FirebaseAuth.instance.currentUser!.emailVerified)
                  Container(
                    height: 50,
                    color: Colors.amber.withOpacity(.6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(child: Text('Please Verify Your Email')),
                          SizedBox(
                            width: 4,
                          ),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification();
                                    Fluttertoast.showToast(
        msg: "Check Your Email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
                              },
                              child: Text('send'))
                        ],
                      ),
                    ),
                  ),
              ]) :Center(child: CircularProgressIndicator())






           
          





          
        );
      },
    );
  }
}
