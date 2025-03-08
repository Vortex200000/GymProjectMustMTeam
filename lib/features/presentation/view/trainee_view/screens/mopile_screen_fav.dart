part of '../trainee_view_layout.dart';

class _MopileScreenFav extends StatefulWidget {
  const _MopileScreenFav(this.account);
  final UserEntity? account;

  @override
  State<_MopileScreenFav> createState() => _MopileScreenFavState();
}

class _MopileScreenFavState extends State<_MopileScreenFav> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          _HeaderFav(),
          _BodyFav(),
        ],
      ),
    );
  }
}

class _HeaderFav extends StatelessWidget {
  const _HeaderFav();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        children: [
          Text(
            'Favorites',
            style: TextStyle(
                color: const Color.fromARGB(255, 135, 112, 228),
                fontSize: 30.rF,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _BodyFav extends StatelessWidget {
  const _BodyFav();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      final bloc = locator<CombonentsBloc>(); // Get the bloc
      bloc.add(GetAllFavoritesEvent()); // Dispatch event separately
      return bloc;
    }, child: BlocBuilder<CombonentsBloc, CombonentsState>(
      builder: (context, state) {
        return Expanded(
          child: AnimatedSwitcher(
            duration: Duration(microseconds: 200),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: state is GetAllFavoritesLoading
                ? SizedBox.shrink()
                : state is GetAllFavoritesLoaded
                    ? _FavListV(favorites: state.favorites)
                    : state is GetAllFavoritesFailure
                        ? Text('Error')
                        : SizedBox.shrink(),
          ),
        );
      },
    ));
  }
}
