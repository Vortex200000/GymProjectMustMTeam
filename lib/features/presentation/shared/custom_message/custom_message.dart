import 'package:flutter/material.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/helpers/screen_helpers.dart';
import 'package:mgym/core/size_config/size_config.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customMessage(
    {required BuildContext context, required String lapel, String? title}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: kpadding,
        decoration: BoxDecoration(
          color: MyColours.black87,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title == null
                ? Text(
                    'Ooops...',
                    style: TextStyle(fontSize: 16, color: MyColours.white),
                  )
                : const SizedBox.shrink(),
            SizedBox(
              height: 5.rH,
            ),
            Text(
              lapel.toString(),
              style: TextStyle(fontSize: 11, color: MyColours.white),
            ),
          ],
        ),
      )));
}
