part of '../nutration_layout.dart';

class _Body extends StatefulWidget {
  const _Body(this.user, this.meals);
  final UserEntity user;
  final List<MealBlanEntity> meals;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final NutrationController _controller = NutrationController();

  @override
  void initState() {
    super.initState();
    _controller.initialize(nutrationBloc(context).mealsUserGoal);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StaggeredSlideIn(
          direction: SlideDirection.end,
          child: Text(
            'Best Meal Plans For Your Goal',
            style: TextStyle(color: MyColours.onTerniary, fontSize: 22.rF),
          ),
        ),
        SizedBox(
          height: 30.rH,
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.6,
          child: _MealPlanList(
            userMeals: widget.meals,
            controller: _controller,
          ),
        ),
        ValueListenableBuilder(
            valueListenable: _controller.mealIdd,
            builder: (context, value, child) => value != ''
                ? StaggeredSlideIn(
                    direction: SlideDirection.bottom,
                    child: CustomButton(
                      radius: 50,
                      width: SizeConfig.screenWidth * 0.3,
                      lapel: 'See Recipe',
                      lapelColur: MyColours.onPrimary,
                      onTap: () {
                        log(_controller.seeMealRecipe(value).toString());
                        Get.toNamed(Routes.recipes,
                            arguments: MealRecipeLayout(
                              user: widget.user,
                              ingreduants: _controller.seeMealRecipe(value),
                            ));
                      },
                      backgroundColor: MyColours.onTerniary,
                    ),
                  )
                : SizedBox.shrink())
      ],
    );
  }
}

class _MealPlanList extends StatelessWidget {
  const _MealPlanList({required this.userMeals, required this.controller});
  final List<MealBlanEntity> userMeals;
  final NutrationController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: userMeals.length,
      itemBuilder: (context, index) => StaggeredSlideIn(
          direction: SlideDirection.start,
          child: _MealPlanCard(
            index: index,
            userMeal: userMeals[index],
            controller: controller,
          )),
    );
  }
}

class _MealPlanCard extends StatefulWidget {
  const _MealPlanCard(
      {required this.userMeal, required this.controller, required this.index});
  final MealBlanEntity userMeal;
  final NutrationController controller;
  final int index;
  @override
  State<_MealPlanCard> createState() => _MealPlanCardState();
}

class _MealPlanCardState extends State<_MealPlanCard> {
  double initialHight = 0;
  final GlobalKey _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          initialHight = _key.currentContext!.size!.height;
        });
      },
    );
  }

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Material(
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: ValueListenableBuilder(
            valueListenable: widget.controller.mealIdd,
            builder: (context, value, child) => InkWell(
              radius: 100,
              splashColor: Colors.transparent,
              onTap: () {
                widget.controller
                    .toggleSelected(widget.index, widget.userMeal.id);
              },
              child: ValueListenableBuilder(
                valueListenable: widget.controller.selectedIndex,
                builder: (context, value, child) => Container(
                  padding: const EdgeInsets.all(5),
                  width: 30.rW,
                  height: 30.rH,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: MyColours.onSecondary, width: 1.rW),
                      shape: BoxShape.circle),
                  child: Container(
                    width: 10.rW,
                    height: 10.rH,
                    decoration: BoxDecoration(
                        color: value == widget.index
                            ? MyColours.onTerniary
                            : MyColours.onPrimary,
                        border: Border.all(
                            color: MyColours.onSecondary, width: 1.rW),
                        shape: BoxShape.circle),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            // padding: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.only(bottom: 20.0),

            child: Stack(
              key: _key,
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: MyColours.white,
                      border: const Border.fromBorderSide(BorderSide.none),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Text(
                              widget.userMeal.name,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: MyColours.onPrimary,
                                  fontSize: 15.rF,
                                  fontWeight: FontWeight.w700),
                            ),
                            // Text(
                            //   widget.articleEntity.articelTitle.substring(
                            //       9, widget.articleEntity.articelTitle.length),
                            //   textAlign: TextAlign.start,
                            //   style: TextStyle(
                            //       color: MyColours.onPrimary,
                            //       fontSize: 15.rF,
                            //       fontWeight: FontWeight.w700),
                            // ),
                            Text(
                              widget.userMeal.discription,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style:
                                  const TextStyle(color: MyColours.onPrimary),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              spacing: 5,
                              children: [
                                Row(
                                  spacing: 5,
                                  children: [
                                    // Icon(Icons.f) ,
                                    SvgPicture.asset(
                                      MyIcons.fire,
                                      // ignore: deprecated_member_use
                                      color: Colors.black,
                                      width: 10.rW,
                                      height: 10.rH,
                                    ),
                                    Text(
                                      '${widget.userMeal.calories} Cal',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          color: MyColours.onPrimary),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    // color: Colors.red,
                    // width: SizeConfig.screenWidth * 0.4,
                    // height: 50,
                    child: Image.network(
                      widget.userMeal.photoPath,
                      width: SizeConfig.screenWidth * 0.4,
                      height: initialHight,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
