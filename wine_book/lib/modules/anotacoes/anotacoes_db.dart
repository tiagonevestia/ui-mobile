import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:wine_book/modules/anotacoes/anotacoes_model.dart';
import 'package:wine_book/utils/diretorio.dart' as utils;

/// Classe do provedor de banco de dados para anotações.
class AnotacoesDB {
  /// Instância estática e construtor privado, pois esse é um singleton.
  AnotacoesDB._();

  static final AnotacoesDB db = AnotacoesDB._();

  /// A única instância do banco de dados.
  Database _db;

  /// Obter instância singleton, crie se ainda não estiver disponível.
  ///
  /// @return A única instância do banco de dados.
  Future get database async {
    if (_db == null) {
      _db = await init();
    }

    print("## Anotações AnotacoesDB.get-database(): _db = $_db");

    return _db;
  }

  /// Iniciando a database.
  ///
  /// @return Instancia da Database.
  Future<Database> init() async {
    print("Anotações AnotacoesDB.init()");

    String path = join(utils.docsDir.path, "anotacoes.db");
    print("## Anotações AnotacoesDB.init(): path = $path");
    Database db = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database inDB, int inVersion) async {
        await inDB.execute(
          "CREATE TABLE IF NOT EXISTS anotacoes ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "content TEXT,"
          "color TEXT"
          ")",
        );
      },
    );
    return db;
  }

  /// Criar uma anotação apartir de um Map.
  Anotacao anotacaoFromMap(Map inMap) {
    print("## Anotações AnotacoesDB.anotacaoFromMap(): inMap = $inMap");

    Anotacao anotacao = Anotacao();
    anotacao.id = inMap["id"];
    anotacao.title = inMap["title"];
    anotacao.content = inMap["content"];
    anotacao.color = inMap["color"];

    print("## Anotações AnotacoesDB.anotacaoFromMap(): anotacao = $anotacao");

    return anotacao;
  }

  /// Crie um mapa a partir de uma anotação.
  Map<String, dynamic> anotacaoToMap(Anotacao anotacao) {
    print("## Anotações AnotacoesDB.anotacaoToMap(): anotacao = $anotacao");

    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = anotacao.id;
    map["title"] = anotacao.title;
    map["content"] = anotacao.content;
    map["color"] = anotacao.color;

    print("## Anotações AnotacoesDB.anotacaoToMap(): map = $map");

    return map;
  }

  /// Criando uma anotação.
  ///
  /// @param anotacao O objeto Anotacao a ser criado.
  /// @return Future.
  Future create(Anotacao anotacao) async {
    print("## Anotações AnotacoesDB.create(): anotacao = $anotacao");

    Database db = await database;

    // Obtenha o maior ID atual da tabela, mais um, para ser o novo ID.
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM anotacoes");
    int id = val.first["id"];
    if (id == null) {
      id = 1;
    }

    // Insert into table.
    return await db.rawInsert(
      "INSERT INTO anotacoes (id, title, content, color) VALUES (?, ?, ?, ?)",
      [id, anotacao.title, anotacao.content, anotacao.color],
    );
  }

  /// Obtenha uma anotação específica.
  ///
  /// @param id O ID da anotacão a ser obtida.
  /// @return O objeto Anotacação correspondente.
  Future<Anotacao> get(int id) async {
    print("## Anotações AnotacoesDB.get(): id = $id");

    Database db = await database;
    var rec = await db.query("anotacoes", where: "id = ?", whereArgs: [id]);

    print("## Anotações AnotacoesDB.get(): rec.first = $rec.first");

    return anotacaoFromMap(rec.first);
  }

  /// Obter todas as anotações.
  ///
  /// @return Uma lista de objetos de anotação.
  Future<List> getAll() async {
    print("## Anotações AnotacoesDB.getAll()");

    Database db = await database;
    var recs = await db.rawQuery("SELECT * FROM anotacoes ORDER BY id DESC");
    var list =
        recs.isNotEmpty ? recs.map((m) => anotacaoFromMap(m)).toList() : [];

    print("## Anotações AnotacoesDB.getAll(): list = $list");

    return list;
  }

  /// Atualize uma anotação.
  ///
  /// @param anotacao A anotação para atualizar.
  /// @return Future.
  Future update(Anotacao anotacao) async {
    print("## Anotações AnotacoesDB.update(): anotacao = $anotacao");

    Database db = await database;
    return await db.update(
      "anotacoes",
      anotacaoToMap(anotacao),
      where: "id = ?",
      whereArgs: [anotacao.id],
    );
  }

  /// Exclua uma anotação.
  ///
  /// @param id O id da anotação para excluir.
  /// @return Future.
  Future delete(int id) async {
    print("## Anotações AnotacoesDB.delete(): id = $id");

    Database db = await database;
    return await db.delete("anotacoes", where: "id = ?", whereArgs: [id]);
  }
}
