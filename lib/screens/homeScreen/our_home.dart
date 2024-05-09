import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt_flutter/providers/currentState.dart';
import 'package:chatgpt_flutter/screens/homeScreen/widgets/input_text.dart';
import 'package:chatgpt_flutter/utils/our_colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import '../../fine-tune model/chatbot_model.dart';
import '../../models/chat_model.dart';
import '../../providers/currentBotState.dart';

class OurHome extends StatefulWidget {
  const OurHome({super.key});

  @override
  State<OurHome> createState() => _OurHomeState();
}

class _OurHomeState extends State<OurHome> {
  late ScrollController _chatListController;

  var checkConnectivity =
  (Connectivity().checkConnectivity() == ConnectivityResult.mobile &&
      Connectivity().checkConnectivity() == ConnectivityResult.wifi &&
      Connectivity().checkConnectivity() == ConnectivityResult.vpn &&
      Connectivity().checkConnectivity() == ConnectivityResult.bluetooth);

  // List<dynamic> getCombinedMessages(CurrentState currentState, CurrentBotState currentBotState) {
  //   List<dynamic> combinedMessages = [];
  //   combinedMessages.addAll(currentState.listMessages);
  //   combinedMessages.addAll(currentBotState.listBotMessages);
  //
  //   combinedMessages.sort((a, b) {
  //     if (a is MessageBuilderUiModel && b is MessageBuilderUiModel) {
  //       return a.message.compareTo(b.message);
  //     } else if (a is MessageBotBuilderUiModel && b is MessageBotBuilderUiModel) {
  //       return a.messageBot.compareTo(b.messageBot);
  //     } else {
  //       return 0;
  //     }
  //   });
  //
  //   return combinedMessages;
  // }

  // List<dynamic> getCombinedMessages(CurrentState currentState) {
  //   List<dynamic> combinedMessages = [];
  //   combinedMessages.addAll(currentState.listMessages);
  //
  //   combinedMessages.sort((a, b) {
  //     if (a is MessageBuilderUiModel && b is MessageBuilderUiModel) {
  //       return a.message.compareTo(b.message);
  //     } else {
  //       return 0;
  //     }
  //   });
  //   return combinedMessages;
  // }

  @override
  void initState() {
    super.initState();
    _chatListController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _chatListController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CurrentState currentState =
    Provider.of<CurrentState>(context, listen: false);

    CurrentBotState currentBotState =
    Provider.of<CurrentBotState>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: appGreyBg,
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/chatGptLogo.svg",
                width: 40,
              ),
              const SizedBox(
                width: 30,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "ChatGPT",
                  style: GoogleFonts.openSans(),
                ),
              )
            ],
          ),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: appGreyBg,
        body: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: appGreyBg,
            //resizeToAvoidBottomInset: true,
            bottomNavigationBar: BottomCommentBar(),
            body: checkConnectivity == false
                ? SafeArea(
              child: CustomScrollView(
                controller: _chatListController,
                // reverse: true,
                slivers: [
                  SliverToBoxAdapter(
                      child: Consumer2<CurrentState, CurrentBotState>(
                        builder: (context, currentState, currentBotState, _) {
                          // int itemCountProvider =
                          //     currentState.listMessages.length;
                          // int itemCountBotProvider =
                          //     currentBotState.listBotMessages.length;
                          // int itemFinalCountProvider = currentState.listMessages.length >
                          //         currentBotState.listBotMessages.length
                          //     ? currentState.listMessages.length
                          //     : currentBotState.listBotMessages.length ;
                          // >= currentBotState.listBotMessages.length)
                          // ? currentState.listMessages.length
                          // : currentBotState.listBotMessages.length;
                          // , __

                          return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final isGptMessage =
                                  index < currentState.listMessages.length;
                              final message = isGptMessage
                                  ? currentState.listMessages[index]
                                  : currentBotState.listBotMessages[
                              index - currentState.listMessages.length];
                              return
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  color:
                                  currentState.listMessages[index].whoAmI ==
                                      "chatGpt"
                                      ? Colors.white
                                      : darkGrey,
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child:
                                        currentState.listMessages[index]
                                            .whoAmI ==
                                            "chatGpt"
                                            ? SvgPicture.asset(
                                          "assets/chatGptLogo.svg",
                                          width: 20,
                                          height: 20,
                                        )
                                            : const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        )
                                        ,
                                      ),
                                      /*Expanded(
                                          flex: 10,
                                          child:
                                          // currentState
                                          //             .listMessages[index]
                                          //             .whoAmI ==
                                          //         "chatGpt"
                                          //             ||
                                          //         currentBotState
                                          //                 .listBotMessages[
                                          //                     index]
                                          //                 .messageBot ==
                                          //             "chatGpt"
                                          // message is MessageBuilderUiModel
                                          //     ?
                                          message is MessageBuilderUiModel &&
                                              message.whoAmI == "chatGpt"
                                              ? AnimatedTextKit(
                                              totalRepeatCount: 1,
                                              onFinished: () {
                                                debugPrint('test1');
                                                showChatList();
                                                debugPrint('test2');
                                                if (message.message.length >=
                                                    350) {
                                                  print(
                                                      'Response token limit to your request exceeded !');
                                                  toastOnTokenExceeds();
                                                } else {
                                                  print(
                                                      'Response to your request is within the defined token limit');
                                                }
                                              },
                                              animatedTexts: [
                                                TyperAnimatedText(
                                                  // message.message
                                                    message.message
                                                    //     '${currentBotState.listBotMessages[index].messageBot}'
                                                    ,
                                                    textStyle: GoogleFonts
                                                        .openSans(
                                                        color: Colors
                                                            .black))
                                              ])
                                              : Text(
                                            // message.message
                                                currentBotState.listBotMessages[index].messageBot
                                            ,
                                            style:
                                            GoogleFonts.openSans(
                                              color: Colors.white,
                                            ),
                                          )
                                        // : const SizedBox()
                                      )*/
                                      Expanded(
                                        flex: 10,
                                        child: message is MessageBuilderUiModel
                                            ? message.whoAmI == "chatGpt"
                                            ? AnimatedTextKit(
                                          totalRepeatCount: 1,
                                          onFinished: () {
                                            debugPrint('test1');
                                            showChatList();
                                            debugPrint('test2');
                                            print('message Length\t${message.message.length}');
                                            if (message.message.length >= 350) {
                                              print('Response token limit to your request exceeded !');
                                              toastOnTokenExceeds();
                                            } else {
                                              print('Response to your request is within the defined token limit');
                                            }
                                          },
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              message.message,
                                              textStyle: GoogleFonts.openSans(color: Colors.black),
                                            )
                                          ],
                                        )
                                            : Text(
                                          message.message,
                                          style: GoogleFonts.openSans(color: Colors.white),
                                        )
                                            : message is MessageBotBuilderUiModel
                                            ? message.chatBot == "chatGpt"
                                            ? AnimatedTextKit(
                                          totalRepeatCount: 1,
                                          onFinished: () {
                                            debugPrint('test1');
                                            showChatList();
                                            debugPrint('test2');
                                            print('message Length\t${message.messageBot.length}');
                                            if (message.messageBot.length >= 350) {
                                              print('Response token limit to your request exceeded !');
                                              toastOnTokenExceeds();
                                            } else {
                                              print('Response to your request is within the defined token limit');
                                            }
                                          },
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              message.messageBot,
                                              textStyle: GoogleFonts.openSans(color: Colors.black),
                                            )
                                          ],
                                        )
                                            : Text(
                                          message.messageBot,
                                          style: GoogleFonts.openSans(color: Colors.white),
                                        )
                                            :
                                        const SizedBox(),
                                      ),
                                      /*Expanded(
                                        flex: 10,
                                        child:
                                        Consumer2<CurrentState,
                                            CurrentBotState>(
                                          builder: (context, currentState,
                                              currentBotState, child) {
                                            final combinedMessages = [
                                              ...currentState.listMessages,
                                              ...currentBotState.listBotMessages
                                            ];

                                            if (index >=
                                                combinedMessages.length) {
                                              return const SizedBox
                                                  .shrink(); // Return an empty widget if the index is out of range
                                            }

                                            final message = combinedMessages[index];

                                            if (message is MessageBuilderUiModel &&
                                                message.whoAmI == "chatGpt") {
                                              return AnimatedTextKit(
                                                totalRepeatCount: 1,
                                                onFinished: () {
                                                  debugPrint('test1');
                                                  showChatList();
                                                  debugPrint('test2');
                                                  if (message.message.length >=
                                                      350) {
                                                    print(
                                                        'Response token limit to your request exceeded !');
                                                    toastOnTokenExceeds();
                                                  } else {
                                                    print(
                                                        'Response to your request is within the defined token limit');
                                                  }
                                                },
                                                animatedTexts: [
                                                  TyperAnimatedText(
                                                    message.message,
                                                    textStyle: GoogleFonts
                                                        .openSans(
                                                        color: Colors.black),
                                                  )
                                                ],
                                              );
                                            } else
                                            if (message is MessageBotBuilderUiModel) {
                                              return Text(
                                                message.messageBot,
                                                style: GoogleFonts.openSans(
                                                  color: Colors.white,
                                                ),
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          },
                                        ),
                                      )*/
                                    ],
                                  ),
                                );
                            },
                            // itemCount: currentState.listMessages.length +
                            //     currentBotState.listBotMessages.length,
                            itemCount: currentState.listMessages.length,
                          );
                        },
                      ))
                ],
              ),
            )
                : const Text('You are offline')));
  }

  showChatList() {
    _chatListController.animateTo(_chatListController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
  }

  toastOnTokenExceeds() {
    return toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      context: context,
      autoCloseDuration: const Duration(seconds: 6),
      title: const Text(
        'PrimeGPT says',
        style: TextStyle(color: Colors.red),
      ),
      description: RichText(
          text: const TextSpan(
              text:
              'Oops !!!\nYou have exceeded the response completion limit for the request !',
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
        Icons.warning,
        color: Colors.yellow,
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
