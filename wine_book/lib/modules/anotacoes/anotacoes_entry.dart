import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wine_book/modules/anotacoes/anotacoes_db.dart';
import 'package:wine_book/modules/anotacoes/anotacoes_model.dart';

class AnotacoesEntry extends StatelessWidget {
  // Controles dos TextFields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  // Key Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AnotacoesEntry() {
    print("## AnotacoesEntry.constructor");

    _titleController.addListener(() {
      anotacoesModel.entityBeingEdited.title = _titleController.text;
    });

    _contentController.addListener(() {
      anotacoesModel.entityBeingEdited.content = _contentController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("## AnotacoesEntry.build()");

    // Define os valores dos controladores.
    if (anotacoesModel.entityBeingEdited != null) {
      _titleController.text = anotacoesModel.entityBeingEdited.title;
      _contentController.text = anotacoesModel.entityBeingEdited.content;
    }

    return ScopedModel<AnotacoesModel>(
      model: anotacoesModel,
      child: ScopedModelDescendant<AnotacoesModel>(
        builder: (
          BuildContext context,
          Widget child,
          AnotacoesModel model,
        ) {
          return Scaffold(
            appBar: _appBar(context, anotacoesModel),
            body: _form(context, anotacoesModel),
          );
        },
      ),
    );
  }

  Widget _appBar(BuildContext context, AnotacoesModel model) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.save_alt,
          size: 32,
          color: Colors.black,
        ),
        onPressed: () {
          _save(context, model);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.clear,
            size: 32,
            color: Colors.red.shade900,
          ),
          onPressed: () {
            // Oculta o teclado virtual.
            FocusScope.of(context).requestFocus(FocusNode());
            model.setStackIndex(0);
          },
        )
      ],
      title: Text(
        'Criar Anotação',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Formulário de Cadastro ou Edição da Anotação
  Widget _form(BuildContext context, AnotacoesModel model) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.only(top: 20.0),
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.title,
              color: Colors.black,
            ),
            title: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
              maxLength: 40,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                hintText: 'Título',
                errorStyle: TextStyle(
                  color: Colors.red.shade900,
                ),
                focusColor: Colors.black,
              ),
              controller: _titleController,
              validator: (String value) {
                if (value.length == 0) {
                  return "Por favor coloque um título";
                }
                return null;
              },
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.content_paste,
              color: Colors.black,
            ),
            title: TextFormField(
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: Colors.black,
              maxLength: 300,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                hintText: 'Descrição',
                errorStyle: TextStyle(
                  color: Colors.red.shade900,
                ),
                focusColor: Colors.black,
              ),
              controller: _contentController,
              validator: (String value) {
                if (value.length == 0) {
                  return "Por favor coloque uma descrição";
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20.0),
          ListTile(
            leading: Icon(
              Icons.color_lens,
              color: Colors.black,
            ),
            title: Row(
              children: <Widget>[
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Container(
                      color: Colors.red,
                      width: model.color == 'red' ? 46 : 40,
                      height: model.color == 'red' ? 46 : 40,
                      child: model.color == 'red'
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 28,
                            )
                          : Container(),
                    ),
                  ),
                  onTap: () {
                    model.entityBeingEdited.color = "red";
                    model.setColor("red");
                  },
                ),
                Spacer(),
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Container(
                      color: Colors.green,
                      width: model.color == 'green' ? 46 : 40,
                      height: model.color == 'green' ? 46 : 40,
                      child: model.color == 'green'
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 28,
                            )
                          : Container(),
                    ),
                  ),
                  onTap: () {
                    model.entityBeingEdited.color = "green";
                    model.setColor("green");
                  },
                ),
                Spacer(),
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Container(
                      color: Colors.blue,
                      width: model.color == 'blue' ? 46 : 40,
                      height: model.color == 'blue' ? 46 : 40,
                      child: model.color == 'blue'
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 28,
                            )
                          : Container(),
                    ),
                  ),
                  onTap: () {
                    model.entityBeingEdited.color = "blue";
                    model.setColor("blue");
                  },
                ),
                Spacer(),
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Container(
                      color: Colors.grey,
                      width: model.color == 'grey' ? 46 : 40,
                      height: model.color == 'grey' ? 46 : 40,
                      child: model.color == 'grey'
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 28,
                            )
                          : Container(),
                    ),
                  ),
                  onTap: () {
                    model.entityBeingEdited.color = "grey";
                    model.setColor("grey");
                  },
                ),
                Spacer(),
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Container(
                      color: Colors.purple,
                      width: model.color == 'purple' ? 46 : 40,
                      height: model.color == 'purple' ? 46 : 40,
                      child: model.color == 'purple'
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 28,
                            )
                          : Container(),
                    ),
                  ),
                  onTap: () {
                    model.entityBeingEdited.color = "purple";
                    model.setColor("purple");
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Salvando uma anotação na base de dados
  void _save(BuildContext context, AnotacoesModel model) async {
    print("## AnotacoesEntry._save()");

    // Aborta se o formulário não for válido
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Criando uma nova anotação
    if (model.entityBeingEdited.id == null) {
      print(
          "## AnotacoesEntry._save(): Creating: ${anotacoesModel.entityBeingEdited}");
      await AnotacoesDB.db.create(anotacoesModel.entityBeingEdited);
    } else {
      // Atualizando uma anotação
      print(
          "## AnotacoesEntry._save(): Updating: ${anotacoesModel.entityBeingEdited}");
      await AnotacoesDB.db.update(anotacoesModel.entityBeingEdited);
    }

    // Recarregando a database para atualizar a listagem
    anotacoesModel.loadData('anotacoes', AnotacoesDB.db);

    // Voltando para o modo de listagem
    model.setStackIndex(0);

    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade900,
        duration: Duration(seconds: 2),
        content: Text(
          'Anotação salva!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
