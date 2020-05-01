import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wine_book/animation/animatedIndexedStack.dart';
import 'package:wine_book/modules/anotacoes/anotacoes_db.dart';
import 'package:wine_book/modules/anotacoes/anotacoes_entry.dart';
import 'package:wine_book/modules/anotacoes/anotacoes_list.dart';
import 'package:wine_book/modules/anotacoes/anotacoes_model.dart';

class AnotacoesPage extends StatelessWidget {
  AnotacoesPage() {
    print("## Anotações.constructor");

    /// Carregamento inicial dos dados.
    anotacoesModel.loadData("anotacoes", AnotacoesDB.db);
  }
  @override
  Widget build(BuildContext context) {
    print("## Anotações.build()");

    return ScopedModel<AnotacoesModel>(
      model: anotacoesModel,
      child: ScopedModelDescendant<AnotacoesModel>(
        builder: (context, child, model) {
          return AnimatedIndexedStack(
            index: model.stackIndex,
            children: <Widget>[
              model.stackIndex == 0 ? AnotacoesList() : Container(),
              model.stackIndex == 1 ? AnotacoesEntry() : Container(),
            ],
          );
        },
      ),
    );
  }
}
