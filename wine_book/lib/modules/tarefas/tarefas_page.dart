import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wine_book/animation/animatedIndexedStack.dart';
import 'package:wine_book/modules/tarefas/tarefas_db.dart';
import 'package:wine_book/modules/tarefas/tarefas_entry.dart';
import 'package:wine_book/modules/tarefas/tarefas_list.dart';
import 'package:wine_book/modules/tarefas/tarefas_model.dart';

class TarefasPage extends StatelessWidget {
  TarefasPage() {
    print("## Tarefas.constructor");

    /// Carregamento inicial dos dados.
    tarefasModel.loadDataTarefas("tarefas", TarefasDB.db);
  }
  @override
  Widget build(BuildContext context) {
    print("## Tarefas.build()");

    return ScopedModel<TarefasModel>(
      model: tarefasModel,
      child: ScopedModelDescendant<TarefasModel>(
        builder: (context, child, model) {
          return AnimatedIndexedStack(
            index: model.stackIndex,
            children: <Widget>[
              model.stackIndex == 0 ? TarefasList() : Container(),
              model.stackIndex == 1 ? TarefasEntry() : Container(),
            ],
          );
        },
      ),
    );
  }
}
