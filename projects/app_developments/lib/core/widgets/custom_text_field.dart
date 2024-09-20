import 'package:app_developments/core/constants/dark_theme_color_constants.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? prefixIcon;
  final String? labelText;
  final bool showVisibilityToggle;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Widget? label;
  final bool Function(String?)? isValid;
  final Color? hintTextColor;
  final bool outlineBorder;
  final double? width;
  final Icon? icon;
  final Color? fillColor;
  final double hintFontSize;
  final bool removePadding;

  const CustomTextField(
      {Key? key,
      this.hintText,
      this.labelText,
      this.icon,
      this.prefixIcon,
      this.showVisibilityToggle = false,
      this.fillColor,
      this.textInputAction,
      this.keyboardType = TextInputType.text,
      this.label,
      this.width,
      required this.controller,
      this.validator,
      this.isValid,
      this.hintTextColor,
      this.hintFontSize = 16,
      this.outlineBorder = false,
      this.removePadding = false})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obsecureText = true;
  final FocusNode _focusNode = FocusNode();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (mounted) {
        setState(() {}); // Update the state when the focus changes
      }
    });
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          _isTyping = widget.controller.text.isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller.removeListener(() {
      setState(() {
        _isTyping = widget.controller.text.isNotEmpty;
      });
    });
    super.dispose();
  }

  void _toggleObsecureText() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  bool _isPrefixIconGiven() {
    return widget.prefixIcon != null && widget.prefixIcon!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    // Check if the current theme is dark or light
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: widget.width ?? context.dynamicWidth(0.83),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: _obsecureText && widget.showVisibilityToggle,
        focusNode: _focusNode,
        textInputAction: widget.textInputAction,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: widget.fillColor ??
              (isDarkMode
                  ? AppDarkColorConstants.bgLight // Dark theme background color
                  : AppLightColorConstants
                      .bgLight), // Light theme background color
          filled: true,
          prefixIcon: _isPrefixIconGiven() && _isTyping
              ? Padding(
                  padding: context.onlyLeftPaddingLow,
                  child: Text(
                    widget.prefixIcon!,
                    style: const TextStyle(
                      color: AppLightColorConstants.contentTeritaryColor,
                      fontSize: 16,
                    ),
                  ),
                )
              : null,
          prefixIconConstraints: _isPrefixIconGiven()
              ? const BoxConstraints(
                  minWidth: 22,
                  minHeight: 20,
                  maxWidth: 50,
                  maxHeight: 20,
                )
              : null,
          labelText: widget.labelText,
          label: widget.label,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: _focusNode.hasFocus
                ? AppLightColorConstants.primaryColor
                : AppLightColorConstants.contentTeritaryColor,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              widget.removePadding ? null : context.onlyTopPaddingNormal,
          border: widget.outlineBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(context.normalRadius),
                  borderSide: BorderSide.none,
                )
              : const UnderlineInputBorder(),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showVisibilityToggle)
                GestureDetector(
                  onTap: _toggleObsecureText,
                  child: Icon(
                    _obsecureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              if (widget.isValid != null &&
                  widget.isValid!(widget.controller.text))
                const Icon(
                  Icons.check_circle,
                  color: AppLightColorConstants.primaryColor,
                ),
              widget.icon ?? const Icon(null),
            ],
          ),
          enabledBorder: widget.outlineBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(context.normalRadius),
                  borderSide: BorderSide.none)
              : const UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: AppLightColorConstants.contentDisabled,
                  ),
                ),
          errorBorder: widget.outlineBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(context.normalRadius),
                  borderSide: BorderSide.none)
              : const UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: AppLightColorConstants.bgError,
                  ),
                ),
          focusedErrorBorder: widget.outlineBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(context.normalRadius),
                  borderSide: BorderSide.none)
              : const UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: AppLightColorConstants.bgError,
                  ),
                ),
          focusedBorder: widget.outlineBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(context.normalRadius),
                  borderSide: BorderSide.none)
              : const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppLightColorConstants.primaryColor,
                  ),
                ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: widget.hintFontSize,
            color:
                widget.hintTextColor ?? AppLightColorConstants.contentDisabled,
          ),
          errorStyle: const TextStyle(
            fontSize: 12,
            height: 0.1,
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}
