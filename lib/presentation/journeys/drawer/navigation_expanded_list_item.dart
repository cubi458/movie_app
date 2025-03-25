import 'package:flutter/material.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_list_item.dart';

class NavigationExpandedListItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;  // Thay `Function` bằng `VoidCallback`
  final List<String> children;

  const NavigationExpandedListItem({
    Key? key,  // Sử dụng Key? thay vì Key để hỗ trợ null safety
    required this.title,  // Dùng `required` thay vì `@required`
    required this.onPressed,  // Dùng `required` thay vì `@required`
    required this.children,  // Dùng `required` thay vì `@required`
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
        child: ExpansionTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),  // Thay `subtitle1` bằng `bodyMedium`
          ),
          children: [
            for (int i = 0; i < children.length; i++)
              NavigationSubListItem(
                title: children[i],
                onPressed: () {},
              ),
          ],
        ),
      ),
    );
  }
}
