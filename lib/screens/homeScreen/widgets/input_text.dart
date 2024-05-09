import 'dart:async';
import 'package:chatgpt_flutter/models/chat_model.dart';
import 'package:chatgpt_flutter/utils/our_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import '../../../fine-tune model/chatbot_model.dart';
import '../../../providers/currentBotState.dart';
import '../../../providers/currentState.dart';

class BottomCommentBar extends StatefulWidget {
  BottomCommentBar({Key? key}) : super(key: key);

  @override
  State<BottomCommentBar> createState() => _BottomCommentBarState();
}

class _BottomCommentBarState extends State<BottomCommentBar> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final FocusNode _commentFocus = FocusNode();
  Color ourWhite = Color(0xffebf7f9);
  bool enable = false;
  String model = "gpt-3.5-turbo";
  String trainingFileID = "file-p63hmoLdE3paZiN3XZZtRGhL";


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    CurrentBotState _instanceBot = Provider.of<CurrentBotState>(context, listen: false);
    return Container(
      //margin: EdgeInsets.all(5),
      height: size.height / 12,
      color: darkGrey,
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: TextField(
              focusNode: _commentFocus,
              controller: _commentController,
              style: GoogleFonts.openSans(color: ourWhite, fontSize: 14),
              onTap: () {},
              onChanged: (value) {
                if (_commentController.text.isNotEmpty) {
                  // enable the comment icon
                  if (enable != true) {
                    setState(() {
                      enable = true;
                    });
                  }
                } else {
                  // disable the comment icon
                  if (enable != false) {
                    setState(() {
                      enable = false;
                    });
                  }
                }
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: enable == true ? ourWhite : const Color(0xff8b8b8b),
                  ),
                  onPressed: () {
                    /*Timer(const Duration(milliseconds: 500), () {
                      SizedBox(
                        height: 5,
                        width: 20,
                        child: Lottie.asset('assets/animation/loading.json'),
                      );
                    });*/
                    if (_commentController.text.isNotEmpty) {
                      if (enable) {
                        Timer(const Duration(milliseconds: 500), () {
                          SizedBox(
                            height: 20,
                            width: 20,
                            child:
                                Lottie.asset('assets/animation/loading.json'),
                          );
                        });
                        try{
                          print('input test1');
                          // if(_instance.apiCallService.sendMessage(ChatSendModel(
                          //     message: _instance.sendMessage(_commentController.text),
                          //     model: model,
                          //     temperature: 0.7)).asStream().isBroadcast){
                          //   print('input test2');
                          //   _instance.sendMessage(_commentController.text);
                            print('input test3');
                              _instance.sendGptMessage(_commentController.text);
                              // _instanceBot.sendBotMessage(_commentController.text);
                          // }
                          // else if(_instanceBot.apiCallService.sendBotMessage(ChatBotSendModel(
                          //   message: _instanceBot.sendBotMessage(_commentController.text),
                          //   temperature: 0.7,
                          //   trainingFileId: trainingFileID)).asStream().isBroadcast){
                            print('input test4');
                            // _instanceBot.sendBotMessage(_commentController.text);
                            print('input test5');
                          // }
                        }catch(e){
                          print('Exception while triggering input data is\t${e.toString()}');
                        }
                      }
                      _commentController.clear();
                      _commentFocus.unfocus();
                      enable = false;
                      setState(() {});
                    } else if (_commentController.text.isEmpty) {
                      showToastBlankMsgFailure();
                    }
                  },
                ),
                contentPadding: const EdgeInsets.only(left: 30, top: 14),
                hintStyle: GoogleFonts.openSans(
                    fontSize: 12, color: const Color(0xff8b8b8b)),
                hintText: "How can I help you ?",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  showToastBlankMsgFailure() {
    return toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text(
        'PrimeGPT says',
        style: TextStyle(color: Colors.red),
      ),
      // you can also use RichText widget for title and description parameters
      description: RichText(
          text: const TextSpan(
              text: 'Please type something !',
              style: TextStyle(color: Color(0xff343541)))),
      alignment: Alignment.center,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 800),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(
        Icons.close,
        color: Colors.red,
      ),
      primaryColor: Color(0xff343541),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }
}
