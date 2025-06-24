import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:visita/utils/colors.dart";
import "package:visita/utils/text.dart";

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool? obsecureText;
  final bool? enable;
  final String hintText;
  final String label;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? outterPadding;
  final Iterable<String>? autofillHints;
  final int? maxLines;
  final int? maxLength;
  final double? width;
  final int? height;
  final Widget? prefix;
  final Widget? suffix;
  final Color? hintShade;
  final TextCapitalization? textCapitalization;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;

  const CustomTextInput({
    super.key, 
    required this.controller, 
    required this.validator, 
    required this.textInputType, 
    required this.hintText, 
    this.obsecureText,
    this.enable,
    this.contentPadding,
    this.autofillHints, 
    this.maxLines,
    this.maxLength,
    this.width,
    this.height,
    this.suffix,
    this.prefix,
    required this.label,
    this.textCapitalization,
    this.outterPadding,
    this.hintShade,
    this.onEditingComplete,
    this.focusNode, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outterPadding ?? EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: label, 
            fontSize: 14, 
            textColor: CustomColors.blak,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .0075,
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: textInputType,
            maxLines: maxLines,
            enabled: enable,
            focusNode: focusNode,
            onEditingComplete: onEditingComplete,
            textCapitalization: textCapitalization ?? TextCapitalization.sentences,
            obscureText: obsecureText ?? false,
            autofillHints: autofillHints,
            onChanged: onChanged,
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLength)
            ],
            decoration: InputDecoration(
              prefixIcon: prefix,
              fillColor: CustomColors.secondary,
              filled: true,
              hintText: hintText,
              contentPadding: contentPadding ?? const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              hintStyle: TextStyle(
                color: hintShade ?? Colors.grey.shade600,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.blak
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.blak
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.blak
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: suffix,
            ),
          ),
        ],
      ),
    );
  }
}