import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wine_book/modules/tarefas/tarefas_db.dart';
import 'package:wine_book/modules/tarefas/tarefas_model.dart';
import 'package:wine_book/utils/date.dart';

class TarefasEntry extends StatelessWidget {
  final TextEditingController _descriptionEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TarefasEntry() {
    print("## TarefasEntry.constructor");

    _descriptionEditingController.addListener(() {
      tarefasModel.entityBeingEdited.description =
          _descriptionEditingController.text;
    });
  }

  Widget build(BuildContext inContext) {
    print("## TarefasEntry.build()");

    // Set value of controllers.
    if (tarefasModel.entityBeingEdited != null) {
      _descriptionEditingController.text =
          tarefasModel.entityBeingEdited.description;
    }

    // Return widget.
    return ScopedModel(
      model: tarefasModel,
      child: ScopedModelDescendant<TarefasModel>(
        builder:
            (BuildContext inContext, Widget inChild, TarefasModel inModel) {
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Row(
                children: [
                  FlatButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        // Hide soft keyboard.
                        FocusScope.of(inContext).requestFocus(FocusNode());
                        // Go back to the list view.
                        inModel.setStackIndex(0);
                      }),
                  Spacer(),
                  FlatButton(
                      child: Text("Save"),
                      onPressed: () {
                        _save(inContext, tarefasModel);
                      })
                ],
              ),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // Description.
                  ListTile(
                    leading: Icon(Icons.description),
                    title: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: InputDecoration(hintText: "Description"),
                      controller: _descriptionEditingController,
                      validator: (String inValue) {
                        if (inValue.length == 0) {
                          return "Please enter a description";
                        }
                        return null;
                      },
                    ),
                  ),
                  // Due date.
                  ListTile(
                    leading: Icon(Icons.today),
                    title: Text("Due Date"),
                    subtitle: Text(
                      tarefasModel.chosenDate == null
                          ? ""
                          : Jiffy(tarefasModel.chosenDate)
                              .format('MMMM do yyyy'),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () async {
                        // Request a date from the user.  If one is returned, store it.
                        String chosenDate = await selectDate(
                          inContext,
                          tarefasModel,
                          tarefasModel.entityBeingEdited.dueDate,
                        );
                        if (chosenDate != null) {
                          tarefasModel.entityBeingEdited.dueDate = chosenDate;
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Save this contact to the database.
  ///
  /// @param inContext The BuildContext of the parent widget.
  /// @param inModel   The TasksModel.
  void _save(BuildContext inContext, TarefasModel inModel) async {
    print("## TarefasEntry._save()");

    // Abort if form isn't valid.
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Creating a new task.
    if (inModel.entityBeingEdited.id == null) {
      print("## TarefasEntry._save(): Creating: ${inModel.entityBeingEdited}");
      await TarefasDB.db.create(tarefasModel.entityBeingEdited);

      // Updating an existing task.
    } else {
      print("## TarefasEntry._save(): Updating: ${inModel.entityBeingEdited}");
      await TarefasDB.db.update(tarefasModel.entityBeingEdited);
    }

    // Reload data from database to update list.
    tarefasModel.loadDataTarefas("tarefas", TarefasDB.db);

    // Go back to the list view.
    inModel.setStackIndex(0);

    // Show SnackBar.
    Scaffold.of(inContext).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text("Task saved"),
      ),
    );
  }
}
