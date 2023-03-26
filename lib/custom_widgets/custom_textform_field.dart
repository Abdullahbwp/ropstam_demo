import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? labelText;
  final Widget? prefixIcon;
  final String? hintText;
  final void Function(String)? onChanged;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String)? onFieldSubmitted;
  const CustomFormField(
      {super.key,
      this.controller,
      this.keyboardType,
      this.validator,
      this.labelText,
      this.prefixIcon,
      this.hintText,
      this.suffixIcon,
      this.obscureText = false,
      this.onFieldSubmitted,
      this.onChanged});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.next,
      validator: widget.validator,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        labelText: widget.labelText,
        filled: true,
        fillColor: const Color(0xffF3F3F3),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelStyle: TextStyle(color: Theme.of(context).hintColor),
        floatingLabelStyle:
            TextStyle(color: Theme.of(context).colorScheme.secondary),
        contentPadding: const EdgeInsets.all(14),
        hintText: widget.hintText,
        hintStyle:
            TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.sp),
          borderSide: const BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.sp),
          borderSide: const BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: const BorderSide(
              width: 0,
              color: Colors.transparent,
            )),
      ),
    );
  }
}
