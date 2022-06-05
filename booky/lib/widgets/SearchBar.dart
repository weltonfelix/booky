import 'package:flutter/material.dart';

import '../util/debounce.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, this.label = "", required this.onSearchChange})
      : super(key: key);

  final String? label;
  final void Function(String) onSearchChange;

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(callback: onSearchChange);
    final theme = Theme.of(context);

    return TextField(
      onChanged: (value) => {debouncer.debounce(value)},
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.onSurfaceVariant),
          ),
          labelText: label,
          labelStyle: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: theme.textTheme.bodyLarge?.fontSize,
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
          floatingLabelStyle: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          filled: true,
          fillColor: theme.colorScheme.surfaceVariant),
      style: theme.textTheme.bodyLarge,
    );
  }
}
