part of '../meal_recipee_layout.dart';

class _MopileScreem extends StatelessWidget {
  const _MopileScreem({required this.ingreduants, required this.user});
  final MealBlanEntity? ingreduants;
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.rW),
          child: _Header(
            account: user,
          ),
        ),
        _Body(ingreduants!)
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.meal);
  final MealBlanEntity meal;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.rW),
          child: Text(
            meal.name,
            style: TextStyle(color: MyColours.onTerniary, fontSize: 22.rF),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.rW, vertical: 10),
          child: Row(
            spacing: 5,
            children: [
              // Icon(Icons.f) ,
              SvgPicture.asset(
                MyIcons.fire,
                // ignore: deprecated_member_use
                color: MyColours.onSecondary,
                width: 10.rW,
                height: 10.rH,
              ),
              Text(
                '${meal.calories} Cal',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: const TextStyle(color: MyColours.white),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30.rW, vertical: 20.rH),
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenWidth * 0.6,
          color: MyColours.onSecondary,
          child: ClipRRect(
              borderRadius: const  BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                meal.photoPath,
                fit: BoxFit.cover,
              )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25.rH, horizontal: 30.rW),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ingredients',
                style: TextStyle(color: MyColours.onTerniary, fontSize: 16.rF),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: meal.ingrediants.length,
                  itemBuilder: (context, index) =>
                      _IngrediantCard(ingrediant: meal.ingrediants[index]))
            ],
          ),
        )
      ],
    );
  }
}

class _IngrediantCard extends StatelessWidget {
  const _IngrediantCard({required this.ingrediant});
  final String ingrediant;
  @override
  Widget build(BuildContext context) {
    return Text(
      '  . $ingrediant',
      style: TextStyle(
          color: MyColours.white, fontSize: 16.rF, fontWeight: FontWeight.bold),
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
                      'Recipes',
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
                                        borderRadius:  BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                       const  Text(
                                          'You Sure You Want',
                                          style:
                                              TextStyle(color: MyColours.white),
                                        ),
                                        SizedBox(
                                          height: 10.rH,
                                        ),
                                       const  Text(
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
                      child:const  Icon(
                        Icons.logout,
                        color: const Color.fromARGB(255, 135, 112, 228),
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
