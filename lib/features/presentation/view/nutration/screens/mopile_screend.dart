part of '../nutration_layout.dart';

class _MobileScreen extends StatefulWidget {
  const _MobileScreen(this.user);
  final UserEntity user;

  @override
  State<_MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<_MobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.rW),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _Header(
              account: widget.user,
            ),
            BlocBuilder<NutrationBloc, NutrationState>(
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: state is GetUserMealsLoading
                      ? const SizedBox.shrink()
                      : state is GetUserMealsLoaded
                          ? _Body(widget.user, state.meals)
                          : state is GetUserMealsFailure
                              ? const Text('Error')
                              : const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
