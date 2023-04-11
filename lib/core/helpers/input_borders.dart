import 'package:app/core/palettes/palettes.dart';
import 'package:flutter/material.dart';

final OutlineInputBorder kDefaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
        color: Color(0xFF545A60), style: BorderStyle.solid, width: 1));

final OutlineInputBorder kDisabledInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
        color: Colors.grey.shade400, style: BorderStyle.solid, width: 1));

final OutlineInputBorder kEnabledInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
        color: Color(0xFF545A60), style: BorderStyle.solid, width: 1));

final OutlineInputBorder kFocusedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
        color: AppPalette.primaryColorLight,
        style: BorderStyle.solid,
        width: 2));

final OutlineInputBorder kErrorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
        color: Colors.red, style: BorderStyle.solid, width: 1));

final OutlineInputBorder kFocusedErrorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
        color: Colors.red, style: BorderStyle.solid, width: 2));
