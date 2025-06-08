part of '../nutration_layout.dart';

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
                      'Nutration',
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
