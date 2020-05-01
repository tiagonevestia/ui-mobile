import 'package:flutter/material.dart';

import 'package:wine_book/models/baseModel.dart';

/// Função para obter uma data selecionada pelo usuário.
///
/// @param inContext O BuildContext do widget pai.
/// @return Future.
Future selectDate(
  BuildContext inContext,
  BaseModel inModel,
  String inDateString,
) async {
  print("## globals.selectDate()");

  // Padrão para a data de hoje, supondo que estamos adicionando.
  DateTime initialDate = DateTime.now();

  // Agora solicite a data.
  DateTime picked = await showDatePicker(
    context: inContext,
    initialDate: initialDate,
    firstDate: initialDate,
    lastDate: DateTime(2100),
  );

  // Se eles não cancelaram, atualize-o no modelo para que apareça na tela e
  // retorne o formulário de sequência.
  if (picked != null) {
    inModel.setChosenDate(picked.toLocal().toString());
    return picked.toLocal().toString();
  }
}
