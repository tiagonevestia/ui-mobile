import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wine_book/modules/anotacoes/anotacoes_db.dart';
import 'package:wine_book/modules/anotacoes/anotacoes_model.dart';

class AnotacoesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("## AnotacoesList.build()");

    return ScopedModel<AnotacoesModel>(
      model: anotacoesModel,
      child: ScopedModelDescendant<AnotacoesModel>(
        builder: (
          BuildContext context,
          Widget child,
          AnotacoesModel model,
        ) {
          return Scaffold(
            appBar: _appBar(),
            body: model.entityList.length == 0
                ? _semAnotacoes(context)
                : _listarAnotacoes(anotacoesModel),
            floatingActionButton: _adicionarAnotacao(anotacoesModel),
          );
        },
      ),
    );
  }

  Widget _semAnotacoes(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/sem_anotacoes.png',
        height: MediaQuery.of(context).size.height * .3,
      ),
    );
  }

  /// Componente AppBar
  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        'Minhas Anotações',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.filter_list,
            color: Colors.red.shade900,
            size: 30,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  /// Adicionar uma nova anotação
  Widget _adicionarAnotacao(AnotacoesModel model) {
    return FloatingActionButton(
      onPressed: () {
        model.entityBeingEdited = Anotacao();
        model.setColor(null);
        model.setStackIndex(1);
      },
      backgroundColor: Colors.red.shade900,
      child: Icon(
        Icons.add,
        size: 30,
      ),
    );
  }

  /// Listando as anotações
  Widget _listarAnotacoes(AnotacoesModel model) {
    print("## AnotacoesList._listarAnotacoes()");

    return AnimationLimiter(
      child: ListView.builder(
        itemCount: model.entityList.length,
        itemBuilder: (BuildContext context, int index) {
          Anotacao anotacao = model.entityList[index];
          Color color = _setColor(anotacao.color);

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: ScaleAnimation(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: .25,
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Excluir',
                          color: Colors.red.shade900,
                          icon: Icons.delete,
                          onTap: () async {
                            await _excluindoAnotacao(context, anotacao);
                          },
                        )
                      ],
                      child: Card(
                          elevation: 8.0,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        topLeft: Radius.circular(5),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.only(left: 30),
                                        width: double.infinity,
                                        height: 10,
                                        color: color,
                                      ),
                                    )),
                                ListTile(
                                  title: Text(
                                    '${anotacao.title}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  subtitle: Text('${anotacao.content}'),
                                  onTap: () async {
                                    anotacoesModel.entityBeingEdited =
                                        await AnotacoesDB.db.get(anotacao.id);
                                    anotacoesModel.setColor(anotacao.color);
                                    anotacoesModel.setStackIndex(1);
                                  },
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future _excluindoAnotacao(BuildContext context, Anotacao anotacao) {
    print("## AnotacoesList._deleteNote(): inNote = $anotacao");

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext alertContext) {
          return AlertDialog(
            title: Text(
              'Excluir Anotação',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: Text(
              'Tem certeza de que deseja excluir ${anotacao.title}',
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(alertContext).pop();
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.red.shade900),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  await AnotacoesDB.db.delete(anotacao.id);
                  Navigator.of(alertContext).pop();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red.shade900,
                      duration: Duration(seconds: 2),
                      content: Text(
                        "Anotação deletada!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  );

                  anotacoesModel.loadData('anotacoes', AnotacoesDB.db);
                },
                child: Text(
                  'Excluir',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        });
  }

  /// Setando uma cor para o Card
  Color _setColor(String value) {
    Color color = Colors.white;
    switch (value) {
      case "red":
        color = Colors.red;
        break;
      case "green":
        color = Colors.green;
        break;
      case "blue":
        color = Colors.blue;
        break;
      case "yellow":
        color = Colors.yellow;
        break;
      case "grey":
        color = Colors.grey;
        break;
      case "purple":
        color = Colors.purple;
        break;
    }
    return color;
  }
}
