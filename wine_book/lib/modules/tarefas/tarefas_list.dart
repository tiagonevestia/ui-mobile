import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jiffy/jiffy.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:wine_book/modules/tarefas/tarefas_db.dart';

import 'package:wine_book/modules/tarefas/tarefas_model.dart';

class TarefasList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("## TarefasList.build()");

    return ScopedModel<TarefasModel>(
      model: tarefasModel,
      child: ScopedModelDescendant<TarefasModel>(
        builder: (
          BuildContext context,
          Widget child,
          TarefasModel model,
        ) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: _appBar(context, tarefasModel),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _listarTarefas(tarefasModel),
                  Center(child: Text("Page 2")),
                ],
              ),
              // body:
            ),
          );
        },
      ),
    );
  }

  Widget _listarTarefas(TarefasModel model) {
    var hoje = Jiffy();
    var amanha = Jiffy()..add(days: 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'HOJE ${hoje.yMMMMd.toUpperCase()}',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                '0/${model.entityList.length}',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            itemCount: model.entityList.length,
            itemBuilder: (context, index) {
              Tarefa tarefa = model.entityList[index];

              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: .25,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2.0,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      activeColor: Colors.red.shade900,
                      value: tarefa.completed == "true" ? true : false,
                      onChanged: (inValue) async {
                        tarefa.completed = inValue.toString();
                        await TarefasDB.db.update(tarefa);
                        tarefasModel.loadDataTarefas(
                          "tarefas",
                          TarefasDB.db,
                        );
                      },
                    ),
                    title: Text(
                      "${tarefa.description}",
                      style: tarefa.completed == "true"
                          ? TextStyle(
                              color: Theme.of(context).disabledColor,
                              decoration: TextDecoration.lineThrough,
                            )
                          : TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                    ),
                    subtitle: tarefa.dueDate == null
                        ? null
                        : Text(
                            Jiffy(tarefa.dueDate).format('yMMMMd'),
                            style: tarefa.completed == "true"
                                ? TextStyle(
                                    color: Theme.of(context).disabledColor,
                                    decoration: TextDecoration.lineThrough,
                                  )
                                : TextStyle(
                                    color:
                                        Theme.of(context).textTheme.title.color,
                                  ),
                          ),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        color: Colors.red.shade900,
                        width: 6,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'AMANHÃ ${amanha.yMMMMd.toUpperCase()}',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                '0/${model.tarefasListAmanha.length}',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            itemCount: model.tarefasListAmanha.length,
            itemBuilder: (context, index) {
              Tarefa tarefa = model.tarefasListAmanha[index];

              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: .25,
                child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2.0,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: tarefa.completed == "true" ? true : false,
                        onChanged: (inValue) async {
                          tarefa.completed = inValue.toString();
                          await TarefasDB.db.update(tarefa);
                          tarefasModel.loadDataTarefas(
                            "tarefas",
                            TarefasDB.db,
                          );
                        },
                      ),
                      title: Text(
                        "${tarefa.description}",
                        style: tarefa.completed == "true"
                            ? TextStyle(
                                color: Theme.of(context).disabledColor,
                                decoration: TextDecoration.lineThrough,
                              )
                            : TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                      ),
                      subtitle: tarefa.dueDate == null
                          ? null
                          : Text(
                              Jiffy(tarefa.dueDate).format('yMMMMd'),
                              style: tarefa.completed == "true"
                                  ? TextStyle(
                                      color: Theme.of(context).disabledColor,
                                      decoration: TextDecoration.lineThrough,
                                    )
                                  : TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .title
                                          .color,
                                    ),
                            ),
                      trailing: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          color: Colors.green.shade900,
                          width: 6,
                          height: double.infinity,
                        ),
                      ),
                    )),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Widget sem tarefas
  Widget _semTarefas(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/sem_tarefas.png',
        height: MediaQuery.of(context).size.height * .3,
      ),
    );
  }

  /// Widget AppBar
  Widget _appBar(BuildContext context, TarefasModel model) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      bottom: TabBar(
        isScrollable: true,
        indicatorColor: Colors.red.shade900,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(
            child: Text(
              'Hoje',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Semana',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      leading: IconButton(
        icon: Icon(
          Icons.add_box,
          color: Colors.red.shade900,
          size: 30,
        ),
        onPressed: () {
          model.entityBeingEdited = Tarefa();
          model.setChosenDate(null);
          model.setStackIndex(1);
        },
      ),
      title: Text(
        'Tarefas',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.tune,
            color: Colors.black87,
            size: 30,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
