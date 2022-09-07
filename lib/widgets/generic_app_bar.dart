import 'package:flutter/material.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(55);
  final String barTitle;
  final Widget item;
  final Widget routePage;

  const GenericAppBar({
    Key? key,
    required this.barTitle,
    required this.item,
    required this.routePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(barTitle),
      actions: [
        const SizedBox(width: 0),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => routePage),
              );
            },
            child: item,
          ),
        ),
      ],
    );
  }
}
