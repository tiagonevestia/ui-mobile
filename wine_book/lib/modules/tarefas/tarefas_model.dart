import 'package:wine_book/models/baseModel.dart';

class Tarefa {
  /// Tipos
  int id;
  String description;
  String dueDate;
  String completed = "false";

  /// Para debug
  String toString() {
    return "{ id=$id, description=$description, dueDate=$dueDate, completed=$completed }";
  }
}

class TarefasModel extends BaseModel {}

// A primeira e a única instância deste modelo.
TarefasModel tarefasModel = TarefasModel();
