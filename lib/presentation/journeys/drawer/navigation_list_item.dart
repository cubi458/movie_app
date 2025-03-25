import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';

class NavigationListItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed; // Thay từ Function thành VoidCallback

  const NavigationListItem({
    Key? key, // Sửa Key thành Key? vì null safety
    required this.title,
    required this.onPressed, // Sửa @required thành required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2,
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white), // Thay subtitle1 bằng bodyMedium
          ),
        ),
      ),
    );
  }
}

class NavigationSubListItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed; // Thay từ Function thành VoidCallback

  const NavigationSubListItem({
    Key? key, // Sửa Key thành Key? vì null safety
    required this.title,
    required this.onPressed, // Sửa @required thành required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2,
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w.toDouble()), // Ép kiểu thành double
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white), // Thay subtitle1 bằng bodyMedium
          ),
        ),
      ),
    );
  }
}
