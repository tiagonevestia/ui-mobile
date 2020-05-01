import 'package:scoped_model/scoped_model.dart';

/// ****************************************************************************
/// Classe base que é modelo para todas as entidades estende.
/// ****************************************************************************

class BaseModel extends Model {
  /// Qual é a página stack está sendo exibida
  int stackIndex = 0;

  /// Lista de entidades
  List entityList = [];
  List tarefasListAmanha = [];

  /// Entidade que está sendo editada
  var entityBeingEdited;

  /// A data escolhida pelo usuário.
  /// Precisava ser capaz de exibir o que o usuário seleciona na tela de entrada
  String chosenDate;

  /// Para exibição da data escolhida pelo usuário.
  ///
  /// @param inDate A data no formato MM/DD/YYYY.
  void setChosenDate(String inDate) {
    print("## BaseModel.setChosenDate ():inDate = $inDate");
    chosenDate = inDate;
    notifyListeners();
  }

  /// Carrega os dados do banco de dados.
  ///
  /// @param inEntityType O tipo de entidade que está sendo carregada
  /// ("compromissos", "contatos", "anotações" ou "tarefas").
  /// @param inDatabase A instância DBProvider.db da entidade.
  void loadData(String inEntityType, dynamic inDatabase) async {
    print("## ${inEntityType}Model.loadData()");

    // Carregando as entidades para database.
    entityList = await inDatabase.getAll();

    // Notificar os ouvintes sobre os dados que estão disponíveis
    notifyListeners();
  }

  void loadDataTarefas(String inEntityType, dynamic inDatabase) async {
    print("## ${inEntityType}Model.loadData()");

    // Carregando as entidades para database.
    entityList = await inDatabase.getAll();
    tarefasListAmanha = await inDatabase.getAllAmanha();

    // Notificar os ouvintes sobre os dados que estão disponíveis
    notifyListeners();
  }

  /// Para navegar entre as visualizações de entrada e de lista.
  ///
  /// @param inStackIndex O índice da stack para atualizar.
  void setStackIndex(int inStackIndex) {
    print("## BaseModel.setStackIndex(): inStackIndex = $inStackIndex");

    stackIndex = inStackIndex;
    notifyListeners();
  }
}
