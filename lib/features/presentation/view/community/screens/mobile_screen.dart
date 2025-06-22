part of '../community_layout.dart';

class _MobileScreen extends StatelessWidget {
  const _MobileScreen(this.user);
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.rW),
      child: Column(
        children: [
          _Header(account: user),
          CommunityChatPage(
            user: user,
          )
        ],
      ),
    );
  }
}

class CommunityChatPage extends StatefulWidget {
  const CommunityChatPage({super.key, required this.user});
  final UserEntity user;
  @override
  // ignore: library_private_types_in_public_api
  _CommunityChatPageState createState() => _CommunityChatPageState();
}

class _CommunityChatPageState extends State<CommunityChatPage> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    locator<UserRemoteData>().sendMessage(MessageModel(
        message: _messageController.text,
        sender: widget.user.fullName,
        timeSent: DateTime.now(),
        userPhoto: widget.user.photoUrl));

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          StreamBuilder<List<MessageModel>>(
            stream: locator<UserRemoteData>().getMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              var messages = snapshot.data!;

              return Expanded(
                child: ListView.builder(
                  reverse: true, // Latest messages at the bottom
                  itemCount: messages.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      sender: messages[index].sender,
                      message: messages[index].message,
                      photo: messages[index].userPhoto,
                    );
                  },
                ),
              );
            },
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextForm(
              controller: _messageController,
              hinText: 'message ...',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: MyColours.onTerniary),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String sender;
  final String message;
  final String photo;

  const ChatBubble(
      {super.key,
      required this.sender,
      required this.message,
      required this.photo});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.rH, horizontal: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
              color: MyColours.onPrimary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyColours.onTerniary, width: 2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.rH,
            children: [
              Row(
                spacing: 10.rW,
                children: [
                  CustomImageWidget(
                    width: 30.rW,
                    height: 30.rH,
                    isShadow: false,
                    url: photo,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    sender,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.rF,
                        color: MyColours.onTerniary),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                message,
                style: const TextStyle(color: MyColours.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({this.account});
  final UserEntity? account;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.rH),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  back;
                },
                child: Row(
                  spacing: 10,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: SvgPicture.asset(
                        MyIcons.triangelFilledRounded,
                        width: 20,
                        height: 20,
                        // ignore: deprecated_member_use
                        color: MyColours.onTerniary,
                      ),
                    ),
                    Text(
                      'Community',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 135, 112, 228),
                          fontSize: 30.rF,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  InkWell(
                      onTap: () {
                        // Get.offAll(
                        //   Routes.loginRoute,
                        // );
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Container(
                                    // padding: const EdgeInsets.all(10),
                                    width: SizeConfig.screenWidth * .5,
                                    height: SizeConfig.screenWidth * .3,
                                    decoration: const BoxDecoration(
                                        color: MyColours.onPrimary,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'You Sure You Want',
                                          style:
                                              TextStyle(color: MyColours.white),
                                        ),
                                        SizedBox(
                                          height: 10.rH,
                                        ),
                                        const Text(
                                          'To Sign Out ',
                                          style:
                                              TextStyle(color: MyColours.white),
                                        ),
                                        SizedBox(
                                          height: 10.rH,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: CustomButton(
                                                onTap: () {
                                                  authBloc(context)
                                                      .add(SignOutEvent());
                                                  Get.offAllNamed(
                                                      Routes.loginRoute);
                                                },
                                                lapel: 'Yes',
                                                lapelColur: MyColours.black,
                                                backgroundColor:
                                                    MyColours.onTerniary,
                                              )),
                                              Expanded(
                                                  child: CustomButton(
                                                onTap: () {
                                                  back;
                                                },
                                                lapel: 'No',
                                                backgroundColor:
                                                    MyColours.onSecondary,
                                              )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      child: const Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 135, 112, 228),
                      )),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.userProfile,
                          arguments: UserProfileLayout(
                            user: account,
                          ));
                    },
                    child: SvgPicture.asset(
                      MyIcons.profile,
                      height: 30,
                      width: 30,
                      // ignore: deprecated_member_use
                      color: const Color.fromARGB(255, 135, 112, 228),
                    ),
                  ),
                ],
              )
            ],
          )
        ]));
  }
}
