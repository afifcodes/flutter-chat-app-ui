import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/utils/fade_animation.dart';
import 'package:flutter_chat_app_ui/utils/system_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

void main() =>
    runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String PROFILE_PIC = 'assets/profile_pic.jpg';
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController =
      TextEditingController(text: '');
  List<Widget> messages = [
    const ChatCard(
      isRight: true,
      text: 'Hey, how the things going?',
    ),
    const ChatCard(
        text:
            "Thanks Afif! Almost there. I'll work on making those changes you suggested and will shot it over."),
    const ChatCard(
        text:
            "Hey Afif, ive finished with the requirements doc! I made some notes in the gdoc as well for Phoenix to look over."),
    const ChatCard(
      isRight: true,
      text: "Awesome! Thanks. I'll look at this today",
    ),
    const ChatCard(
        text: "No rush though - we still have to wait for Lana's design"),
    const ChatCard(
        text:
            "Hey Afif, can you please review the latest design when you can?"),
    const ChatCard(
      isRight: true,
      text: "Sure thing, I'll have a look today. They're looking great!",
    ),
    const ChatCard(
        isRight: true,
        text:
            "Hey Humeyra, I've seen your design, I just have a few revisions on this. You could make the spacing even more consistent as I noticed a few different spacing. You can also change the primary color to be a bit more contrasting. The rest is very good."),
    const ChatCard(
        text: "Hey Afif, thank you for your feedback, looking forward to do it")
  ];

  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 0.5,
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Ionicons.arrow_back,
            color: Colors.blue,
          )),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                image: DecorationImage(
                    image: AssetImage(PROFILE_PIC), fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Humeyra',
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                'last seen 19:45',
                style: GoogleFonts.inter(
                  color: Colors.grey[700],
                  fontSize: 12,
                ),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.videocam_outline,
              color: Colors.blue,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.call_outline,
              color: Colors.blue,
            )),
      ],
    );
  }

  Container bottomBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[300]!, width: 1))),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Ionicons.add_outline,
                color: Colors.blue,
                size: 20,
              ),
            ),
            Expanded(
                child: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxHeight: 72, maxWidth: double.infinity),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  width: double.infinity,
                  child: TextFormField(
                    controller: _textEditingController,
                    style: GoogleFonts.inter(),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        isCollapsed: true,
                        isDense: true,
                        border: InputBorder.none),
                  )),
            )),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () {
                String text = _textEditingController.text;
                setState(() {
                  messages.add(ChatCard(isRight: true, text: text));
                });
                _textEditingController.clear();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Ionicons.paper_plane,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //
  // @afifcodes
  // afifcodes.vercel.app
  //

  @override
  Widget build(BuildContext context) {
    systemUI();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: appBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                child: ListView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(
                  height: 16,
                ),
                ...messages,
                const SizedBox(
                  height: 16,
                )
              ],
            )),
            bottomBar(),
          ],
        ),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  final bool isRight;
  final String text;
  const ChatCard({Key? key, required this.text, this.isRight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: isRight ? Colors.blue : Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 1)
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isRight ? 16 : 0),
                      bottomRight: Radius.circular(isRight ? 0 : 16))),
              child: Text(
                text,
                softWrap: true,
                style: GoogleFonts.inter(
                    color: isRight ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
