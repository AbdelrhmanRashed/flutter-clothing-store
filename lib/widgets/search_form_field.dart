import 'package:easy_debounce/easy_debounce.dart';
import 'package:Store/core/resources/app_colors.dart';
import 'package:Store/core/resources/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchFormField extends StatefulWidget {
  const SearchFormField({
    super.key,
    this.onChanged,
    this.initialValue,
    required this.autofocus,
  });
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final bool autofocus;

  @override
  State<SearchFormField> createState() => _SearchFormFieldState();
}

class _SearchFormFieldState extends State<SearchFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      autofocus: widget.autofocus,

      onChanged: (value) {
        setState(() {});
        EasyDebounce.debounce(
          'search-debouncer',
          const Duration(milliseconds: 600),
          () => widget.onChanged?.call(value),
        );
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF8F7F7),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SvgPicture.asset(AppIcons.search, width: 8),
        ),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: SvgPicture.asset(AppIcons.clear),
                onPressed: () {
                  _controller.clear();
                  setState(() {});
                  widget.onChanged?.call('');
                },
              )
            : null,
        hintText: "Search Here",
        hintStyle: TextStyle(color: AppColors.hintColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.mainColor, width: 2),
        ),
      ),
    );
  }
}
