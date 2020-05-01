import 'package:jiffy/jiffy.dart';
import "package:path/path.dart";
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wine_book/modules/tarefas/tarefas_model.dart';
import 'package:wine_book/utils/diretorio.dart' as utils;

/// Classe do provedor de banco de dados para tarefas.
class TarefasDB extends Model {
  /// Instância estática e construtor privado, pois esse é um singleton.
  TarefasDB._();

  static final TarefasDB db = TarefasDB._();

  /// A única instância do banco de dados.
  Database _db;

  /// Obter instância singleton, crie se ainda não estiver disponível.
  ///
  /// @return A única instância do banco de dados.
  Future get database async {
    if (_db == null) {
      _db = await init();
    }

    print("## Tarefas TarefasDB.get-database(): _db = $_db");

    return _db;
  }

  /// Iniciando a database.
  ///
  /// @return Instancia da Database.
  Future<Database> init() async {
    print("Tarefas TarefasDB.init()");

    String path = join(utils.docsDir.path, "tarefas.db");
    print("## Tarefas TarefasDB.init(): path = $path");
    Database db = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database inDB, int inVersion) async {
        await inDB.execute(
          "CREATE TABLE IF NOT EXISTS tarefas ("
          "id INTEGER PRIMARY KEY,"
          "description TEXT,"
          "dueDate TEXT,"
          "completed TEXT"
          ")",
        );
      },
    );
    return db;
  }

  /// Criar uma tarefa apartir de um Map.
  Tarefa tarefaFromMap(Map inMap) {
    print("## Tarefas TarefasDB.tarefaFromMap(): inMap = $inMap");

    Tarefa tarefa = Tarefa();
    tarefa.id = inMap["id"];
    tarefa.description = inMap["description"];
    tarefa.dueDate = inMap["dueDate"];
    tarefa.completed = inMap["completed"];

    print("## Tarefas TarefasDB.tarefaFromMap(): tarefa = $tarefa");

    return tarefa;
  }

  /// Crie um mapa a partir de uma tarefa.
  Map<String, dynamic> tarefaToMap(Tarefa tarefa) {
    print("## Tarefas TarefasDB.tarefaToMap(): tarefa = $tarefa");

    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = tarefa.id;
    map["description"] = tarefa.description;
    map["dueDate"] = tarefa.dueDate;
    map["completed"] = tarefa.completed;

    print("## Tarefas TarefasDB.tarefaToMap(): map = $map");

    return map;
  }

  /// Criando uma tarefa.
  ///
  /// @param tarefa O objeto Tarefa a ser criado.
  /// @return Future.
  Future create(Tarefa tarefa) async {
    print("## Tarefas TarefasDB.create(): tarefa = $tarefa");

    Database db = await database;

    // Obtenha o maior ID atual da tabela, mais um, para ser o novo ID.
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM tarefas");
    int id = val.first["id"];
    if (id == null) {
      id = 1;
    }

    // Insert into table.
    return await db.rawInsert(
      "INSERT INTO tarefas (id, description, dueDate, completed) VALUES (?, ?, ?, ?)",
      [id, tarefa.description, tarefa.dueDate, tarefa.completed],
    );
  }

  /// Obtenha uma tarefa específica.
  ///
  /// @param id O ID da tarefa a ser obtida.
  /// @return O objeto tarefas correspondente.
  Future<Tarefa> get(int id) async {
    print("## Tarefas TarefasDB.get(): id = $id");

    Database db = await database;
    var rec = await db.query("tarefas", where: "id = ?", whereArgs: [id]);

    print("## Tarefas TarefasDB.get(): rec.first = $rec.first");

    return tarefaFromMap(rec.first);
  }

  /// Obter todas as Tarefas.
  ///
  /// @return Uma lista de objetos de tarefa.
  Future<List> getAll() async {
    print("## Tarefas TarefasDB.getAll()");

    var hoje = Jiffy();

    Database db = await database;
    var recs = await db.rawQuery(
        "SELECT * FROM tarefas WHERE strftime('%Y-%m-%d', dueDate) = ('${hoje.format("yyyy-MM-dd")}')");
    var list =
        recs.isNotEmpty ? recs.map((m) => tarefaFromMap(m)).toList() : [];

    print("## Tarefas TarefasDB.getAll(): list = $list");

    return list;
  }

  /// Obter todas as Tarefas.
  ///
  /// @return Uma lista de objetos de tarefa.
  Future<List> getAllAmanha() async {
    print("## Tarefas TarefasDB.getAllTeste()");

    var amanha = Jiffy()..add(days: 1);

    Database db = await database;
    var recs = await db.rawQuery(
        "SELECT * FROM tarefas WHERE strftime('%Y-%m-%d', dueDate) = ('${amanha.format("yyyy-MM-dd")}')");
    var list =
        recs.isNotEmpty ? recs.map((m) => tarefaFromMap(m)).toList() : [];

    print("## Tarefas TarefasDB.getAllTeste(): list = $list");

    return list;
  }

  /// Atualize uma tarefa.
  ///
  /// @param tarefa A tarefa para atualizar.
  /// @return Future.
  Future update(Tarefa tarefa) async {
    print("## Tarefas TarefasDB.update(): tarefa = $tarefa");

    Database db = await database;
    return await db.update(
      "tarefas",
      tarefaToMap(tarefa),
      where: "id = ?",
      whereArgs: [tarefa.id],
    );
  }

  /// Exclua uma tarefa.
  ///
  /// @param id O id da tarefa para excluir.
  /// @return Future.
  Future delete(int id) async {
    print("## Tarefas TarefasDB.delete(): id = $id");

    Database db = await database;
    return await db.delete("tarefas", where: "id = ?", whereArgs: [id]);
  }
}
