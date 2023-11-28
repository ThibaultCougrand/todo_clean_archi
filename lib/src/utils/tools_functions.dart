import 'package:flutter/material.dart';

/// Méthode pour retirer le curseur d'un champ de text lors d'une action
void unfocusKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}