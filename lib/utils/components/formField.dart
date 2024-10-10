import 'package:flutter/material.dart';
import 'package:snel_project/utils/constate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget formField(context, hint,
    {isEnabled = true,
      isDummy = false,
      controller,
      inputFormatters,
      isPasswordVisible = false,
      isPassword = false,
      keyboardType = TextInputType.text,
      FormFieldValidator<String>? validator,
      onSaved,
      readOnly = false,
      textInputAction = TextInputAction.next,
      FocusNode? focusNode,
      FocusNode? nextFocus,
      IconData? suffixIcon,
      IconData? prefixIcon,
      maxLine = 1,
      suffixIconSelector}) {
  return TextFormField(
    controller: controller,
    inputFormatters: inputFormatters,
    obscureText: isPassword ? isPasswordVisible : false,
    cursorColor: KcolorPrimary,
    maxLines: maxLine,
    readOnly: readOnly,
    keyboardType: keyboardType,
    validator: validator,
    onSaved: onSaved,
    textInputAction: textInputAction,
    focusNode: focusNode,
    onFieldSubmitted: (arg) {
      if (nextFocus != null) {
        FocusScope.of(context).requestFocus(nextFocus);
      }
    },
    decoration: InputDecoration(
      focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(spacing_standard), borderSide: BorderSide(color: Colors.transparent)),
      enabledBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(spacing_standard), borderSide: BorderSide(color: Colors.transparent)),
      filled: true,
      fillColor: t12_edittext_background,
      hintText: hint,
      hintStyle: TextStyle(fontSize: textSizeMedium, color: t12_text_secondary),
      prefixIcon: Icon(
        prefixIcon,
        color: t12_text_secondary,
        size: 20,
      ),
      suffixIcon: isPassword
          ? GestureDetector(
        onTap: suffixIconSelector,
        child: new Icon(
          suffixIcon,
          color: t12_text_secondary,
          size: 20,
        ),
      )
          : Icon(
        suffixIcon,
        color: t12_text_secondary,
        size: 20,
      ),
    ),
    style: TextStyle(fontSize: textSizeNormal, color: isDummy ? Colors.transparent : t12_text_color_primary),
  );
}