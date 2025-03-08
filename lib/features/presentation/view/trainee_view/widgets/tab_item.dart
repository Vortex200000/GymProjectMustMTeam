part of '../trainee_view_layout.dart';

class _TabItem extends StatelessWidget {
  const _TabItem(this.iconPath, this.lapel, this.iconColour, this.lapelColour,
      this.rotationAngel);
  final String iconPath;
  final String lapel;
  final Color iconColour;
  final Color lapelColour;
  final double rotationAngel;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Transform.rotate(
          angle: rotationAngel,
          child: SvgPicture.asset(
            iconPath,
            width: 40,
            height: 40,
            // ignore: deprecated_member_use
            color: iconColour,
          ),
        ),
        Text(
          lapel,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
              color: lapelColour, fontSize: 8.rF, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
