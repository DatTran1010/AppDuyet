// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/logic/models/drop_down_nuq.dart';

// ignore: camel_case_types
class FilterDropdown_NUQ extends StatefulWidget {
  FilterDropdown_NUQ(this.list,
      {Key? key,
      this.title,
      this.onChange,
      this.resetValue = false,
      this.initValue})
      : super(key: key);
  final List<DropDownNUQModel> list;
  String? title;
  void Function(DropDownNUQModel? value)? onChange;
  bool resetValue;
  DropDownNUQModel? initValue;
  @override
  State<FilterDropdown_NUQ> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown_NUQ> {
  void Function(DropDownNUQModel? value)? get _call => widget.onChange;
  DropDownNUQModel? _displayValue;
  bool get reset => widget.resetValue;
  @override
  void initState() {
    _displayValue = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: VietSoftColor.loginTextColor),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: DropdownButton<DropDownNUQModel>(
        isExpanded: true,
        value: _displayValue,
        hint: Text(
          widget.title ?? widget.list[0].name,
        ),
        elevation: 0,
        onTap: () {
          setState(() {
            _displayValue = null;
          });
        },
        onChanged: (value) {
          _call!(value);
          setState(() {
            _displayValue = value;
          });
        },
        underline: const SizedBox(width: 1),
        items: widget.list.map<DropdownMenuItem<DropDownNUQModel>>((element) {
          return DropdownMenuItem<DropDownNUQModel>(
            value: element,
            child: Text(
              element.name ?? '',
              style: const TextStyle(color: VietSoftColor.loginTextColor),
            ),
          );
        }).toList(),
      ),
    );
  }
}
