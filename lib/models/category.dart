import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habito/models/habit.dart';
import 'package:habito/models/universalValues.dart';
import 'package:habito/widgets/category/categorySpinnerTile.dart';
import 'package:habito/widgets/category/categoryTile.dart';

class MyCategory {
  String _name;
  List<MyHabit> _myHabits;
  int _color;
  IconData _icon;
  Timestamp _createdAt;
  String _documentId;
  String _userId;
  bool _deleted;

  MyCategory() {
    this._myHabits = [];
    this._color = 0;
    this._icon = Icons.label_outline;
    this._name = "";
    this._documentId = "";
    this._userId = "";
    this._createdAt = Timestamp.now();
    this._deleted = false;
  }

  MyCategory.fromFirebase(
      {@required Map<String, dynamic> data,
      @required String userId,
      @required String documentId}) {
    this._myHabits = [];
    this._color = data["color"];
    this._icon = IconData(data["icon"], fontFamily: "MaterialIcons");
    this._name = data["name"];
    this._documentId = documentId;
    this._userId = userId;
    this._createdAt = data["createdAt"];
    this._deleted = false;
  }

  MyCategory.fromCategory(MyCategory myCategory){
    this._name = myCategory.categoryName;
    this._myHabits = myCategory.habitsList;
    this._color = myCategory.categoryColorIndex;
    this._icon = myCategory.categoryIcon;
    this._createdAt = myCategory.createdAt;
    this._documentId = myCategory.documentId;
    this._userId = myCategory.userId;
    this._deleted = myCategory.isDeleted;
  }

  set categoryName(String name) {
    this._name = name;
  }

  set categoryColor(int color) {
    this._color = color;
  }

  set categoryIcon(IconData icon) {
    this._icon = icon;
  }

  set createdAt(Timestamp createdAt) {
    this._createdAt = createdAt;
  }

  set categoryIconFromCodePoint(int codePoint) {
    this._icon = IconData(codePoint, fontFamily: "MaterialIcons");
  }

  set documentId(String id) {
    this._documentId = id;
  }

  set userId(String id) {
    this._userId = id;
  }

  set deleted(bool deleted) {
    this._deleted = deleted;
  }

  set habitsList(List<MyHabit> habits) {
    this._myHabits = habits;
  }

  get isDeleted {
    return _deleted;
  }

  get createdAt {
    return _createdAt;
  }

  get habitsList {
    return this._myHabits;
  }

  get numberOfHabits {
    return _myHabits.length;
  }

  get userId {
    return _userId;
  }

  get documentId {
    return _documentId;
  }

  get categoryName {
    return _name;
  }

  get categoryHabits {
    return _myHabits;
  }

  get categoryColorIndex {
    return _color;
  }

  get categoryColor {
    return MyColors.standardColorsList[_color];
  }

  get categoryIcon {
    return _icon;
  }

  void addHabitToList(MyHabit myHabit) {
    _myHabits.insert(0, myHabit);
  }

  Widget widget({bool showNumberOfHabits, bool overridePadding}) {
    return CategoryTile(
      showNumberOfHabits == null ? false : true,
      _myHabits.length,
      _icon,
      _color,
      _name,
      overridePadding == null ? false : overridePadding,
    );
  }

  Widget spinnerTile() {
    return CategorySpinnerTile(_icon, _name);
  }

  Map<String, dynamic> toJson() => {
        "name": _name,
        "color": _color,
        "uid": _userId,
        "icon": _icon.codePoint,
        "deleted": _deleted,
        "createdAt": _createdAt
      };
}
