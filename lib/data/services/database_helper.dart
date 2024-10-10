import 'package:snel_project/data/models/client.dart';
import 'package:snel_project/data/models/compte_snel.dart';
import 'package:snel_project/data/models/payement_card.dart';
import 'package:snel_project/data/models/payement_mobile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'snel_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE clients(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)',
        );
        await db.execute(
          'CREATE TABLE accounts(id INTEGER PRIMARY KEY AUTOINCREMENT, label TEXT, idClient INTEGER)',
        );
        await db.execute(
          'CREATE TABLE mobile_payments(id INTEGER PRIMARY KEY AUTOINCREMENT, numero TEXT, devise TEXT, idClient INTEGER, FOREIGN KEY (idClient) REFERENCES clients (id))',
        );
        await db.execute(
          'CREATE TABLE card_payments(id INTEGER PRIMARY KEY AUTOINCREMENT, numero TEXT,cvv TEXT, date TEXT, nom TEXT, idClient INTEGER, FOREIGN KEY (idClient) REFERENCES clients (id))',
        );
      },
    );
  }

  // Méthodes pour insérer et récupérer les paiements mobiles et par carte
  Future<void> insertMobilePayment(PaymentMobile payment) async {
    final db = await database;
    await db.insert(
      'mobile_payments',
      payment.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertCardPayment(PaymentCard payment) async {
    final db = await database;
    await db.insert(
      'card_payments',
      payment.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PaymentMobile>> getMobilePayments(int idClient) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'mobile_payments',
      where: 'idClient = ?',
      whereArgs: [idClient],
    );

    return List.generate(maps.length, (i) {
      return PaymentMobile(
        id: maps[i]['id'],
        numero: maps[i]['numero'],
        devise: maps[i]['devise'],
        idClient: maps[i]['idClient'],
      );
    });
  }

  Future<List<PaymentCard>> getCardPayments(int idClient) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'card_payments',
      where: 'idClient = ?',
      whereArgs: [idClient],
    );

    return List.generate(maps.length, (i) {
      return PaymentCard(
        id: maps[i]['id'],
        numero: maps[i]['numero'],
        nom: maps[i]['nom'],
        cvv: maps[i]['cvv'],
        date: maps[i]['date'],
        idClient: maps[i]['idClient'],
      );
    });
  }


  Future<void> insertClient(Client client) async {
    final db = await database;
    await db.insert(
      'clients',
      client.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Client>> getClients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('clients');

    return List.generate(maps.length, (i) {
      return Client(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
      );
    });
  }

  Future<void> insertAccount(CompteSnel account) async {
    final db = await database;
    await db.insert(
      'accounts',
      account.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CompteSnel>> getAccounts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('accounts');

    return List.generate(maps.length, (i) {
      return CompteSnel(
        id: maps[i]['id'],
        label: maps[i]['label'],
        idClient: maps[i]['idClient'],
      );
    });
  }
}