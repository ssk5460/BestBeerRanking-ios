import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:best_beer_ranking/theme/app_colors.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:best_beer_ranking/ui/theme/font_size.dart';
import 'package:best_beer_ranking/utils/utils.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class OutlineTextFieldField extends HookConsumerWidget {
  const OutlineTextFieldField({
    Key? key,
    this.errorText,
    this.isShowError,
    this.controller,
    this.keyboardType,
    this.keyboardAction,
    this.label,
    this.initialValue,
    this.hintText,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.isShowBorder,
  }) : super(key: key);

  final String? errorText;
  final bool? isShowError;
  final String? label;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? keyboardAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool? isShowBorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appThemeProvider).appColors;

    final labelWidget = label == null
        ? const SizedBox()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: TextStyle(
                    color: appColors.secondaryText, fontSize: FontSize.pt10),
              ),
              isShowError == null
                  ? const SizedBox()
                  : _errorText(errorText ?? '', isShowError ?? false, appColors)
            ],
          ).paddingEdge(
            const EdgeInsets.only(bottom: LayoutSize.sizePaddingMedium));

    return Column(
      children: [
        labelWidget,
        SizedBox(
          child: TextField(
            controller: TextEditingController(text: initialValue),
            focusNode: focusNode,
            maxLines: null,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: appColors.primaryText)),
                enabledBorder: OutlineInputBorder(
                  borderSide: isShowBorder == true
                      ? BorderSide(color: appColors.primaryText)
                      : BorderSide(color: appColors.border),
                ),
                contentPadding:
                    const EdgeInsets.all(LayoutSize.sizePadding10),
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: FontSize.pt13)),
            keyboardType: keyboardType,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }

  Widget _errorText(String errorText, bool isVisible, AppColors appColors) {
    return Visibility(
      visible: isVisible,
      child: Text(
        errorText,
        style: TextStyle(fontSize: FontSize.pt10, color: appColors.dangerText),
      ),
    );
  }
}
