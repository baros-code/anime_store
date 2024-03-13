import 'package:flutter/material.dart';

import '../../../extensions/build_context_ext.dart';

class PageTitle extends StatelessWidget {
  const PageTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.headlineLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
