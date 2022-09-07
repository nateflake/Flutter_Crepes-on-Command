import 'package:flutter/material.dart';

class GenericProgressIndicator extends StatelessWidget {
  final bool isLoading;
  final List? list;
  final Function action;

  const GenericProgressIndicator({
    Key? key,
    required this.isLoading,
    this.list,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : list == null || list!.isEmpty
              ? const Text('No Products Available')
              : action(),
    );
  }
}
