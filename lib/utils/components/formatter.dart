import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Supprimer les barres obliques
    String text = newValue.text.replaceAll('/', '');

    // Limiter à 4 chiffres
    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    final StringBuffer newText = StringBuffer();

    // Ajouter les deux premiers chiffres
    if (text.isNotEmpty) {
      newText.write(text.substring(0, math.min(2, text.length))); // MM
      if (text.length > 2) {
        newText.write('/'); // Ajouter la barre oblique si plus de deux chiffres
        newText.write(text.substring(2, text.length)); // AA
      }
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Supprimer les espaces
    String text = newValue.text.replaceAll(' ', '');

    // Limiter à 16 chiffres
    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    final StringBuffer newText = StringBuffer();

    // Formater le texte par groupes de 4 chiffres
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        newText.write(' '); // Ajouter un espace après chaque groupe de 4 chiffres
      }
      newText.write(text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class CVVInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Limiter le CVV à 4 chiffres
    String text = newValue.text;

    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
