part of '../trainee_view_layout.dart';

class HomeControllerT {
  late UserEntity _user;
  UserEntity get user => _user;
  late List<Widget> _widgetList;

  late List<BottomNavigationBarItem> _itemList;
  List<BottomNavigationBarItem> get itemList => _itemList;
  List<Widget> get widgetList => _widgetList;

  final double size = 30;
  void initializeHomeController(UserEntity user) {
    _user = user;
    _itemList = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          MyIcons.home,
          width: size,
          height: size,
          // ignore: deprecated_member_use
          color: MyColours.white,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            MyIcons.vidList,
            width: size,
            height: size,
            // ignore: deprecated_member_use
            color: MyColours.white,
          ),
          label: ''),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            MyIcons.favorite,
            width: size,
            height: size,
            // ignore: deprecated_member_use
            color: MyColours.white,
          ),
          label: ''),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            MyIcons.support,
            width: size,
            height: size,
            // ignore: deprecated_member_use
            color: MyColours.white,
          ),
          label: ''),
    ];
    _widgetList = [
      _MopileScreen(user),
      _MopileScreenVad(user),
      _MopileScreenFav(user),
      // _MopileScreenVad(user),
      Text(
        'Coming soon ...',
        style: TextStyle(color: Colors.white),
      )
    ];
  }
}
