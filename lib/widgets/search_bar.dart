import 'package:flutter/material.dart';
import 'package:odiya_news_app/constants/app_strings.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final VoidCallback? onMicTap;
  final bool showMicIcon;
  final bool showClearIcon;
  final EdgeInsetsGeometry? padding;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = AppStrings.searchHint,
    this.readOnly = false,
    this.onTap,
    this.onSubmitted,
    this.onClear,
    this.onMicTap,
    this.showMicIcon = true,
    this.showClearIcon = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPadding = padding ?? const EdgeInsets.all(16.0);
    
    return Padding(
      padding: defaultPadding,
      child: readOnly
          ? _buildReadOnlySearchBar(context)
          : _buildInteractiveSearchBar(context),
    );
  }

  Widget _buildReadOnlySearchBar(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Text(
              hintText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            if (showMicIcon)
              Icon(
                Icons.mic,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveSearchBar(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        suffixIcon: _buildSuffixIcon(context),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    final hasText = controller?.text.isNotEmpty ?? false;
    
    if (hasText && showClearIcon) {
      return IconButton(
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onPressed: onClear,
      );
    } else if (showMicIcon) {
      return IconButton(
        icon: Icon(
          Icons.mic,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onPressed: onMicTap ?? () {
          // Default mic action - show not implemented message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppStrings.voiceSearchNotImplemented),
            ),
          );
        },
      );
    }
    
    return null;
  }
}