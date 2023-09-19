import 'package:flutter/foundation.dart';
import 'package:ladyteen_system/JsonModels/cuttings_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../JsonModels/account_category.dart';
import '../JsonModels/accounts_model.dart';
import '../JsonModels/user_model.dart';

class DatabaseHelper{
  final databaseName = "ladyteen4.db";

  String userData = "insert into users (usrId, usrName, usrPassword) values(1,'admin','123456')";

  String accountCategory = ''' create table accountCategory (
      acId INTEGER PRIMARY KEY AUTOINCREMENT, 
      categoryName TEXT NOT NULL
      )''';

  String accountType = "insert into accountCategory values (1,'tailor')";
  String accounts = ''' create table accounts (
      accId INTEGER PRIMARY KEY AUTOINCREMENT, 
      accName TEXT, 
      jobTitle TEXT, 
      cardNumber TEXT, 
      cardName TEXT, 
      pImage TEXT,
      pPhone TEXT,
      accountType INTEGER,
      createdAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, 
      updatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (accountType) REFERENCES accountCategory (acId) 
      ) ''';



  String user = ''' create table users (
      usrId integer primary key autoincrement, 
      usrName Text UNIQUE, 
      usrPassword Text, 
      userInfo INTEGER, 
      FOREIGN KEY (userInfo) REFERENCES accounts (accId) ON DELETE CASCADE
      )''';


  String textTile = ''' create table textTile (
      txtId INTEGER PRIMARY KEY AUTOINCREMENT,
      txtName TEXT, madeIn TEXT 
      ) ''';

  String rates = '''  
      create table rates (
      rateId INTEGER PRIMARY KEY AUTOINCREMENT, 
      rateType TEXT, 
      rateAmount REAL
      
      )
  ''';

  String cuttings = ''' create table cuttings (
      cutId INTEGER PRIMARY KEY AUTOINCREMENT, 
      modelName TEXT, 
      modelCode INTEGER, 
      modelImage TEXT,
      txtName INTEGER,
      qad_masrafi REAL,
      qty REAL,
      rasta_line REAL,
      zigzal_line REAL,
      meyan_line REAL, 
      cuttingDate TEXT DEFAULT CURRENT_TIMESTAMP ,
      FOREIGN KEY (txtName) REFERENCES textTile (txtId) 
      ) ''';

  String cuttingDetails = ''' create table cuttingDetails (
      cdId INTEGER PRIMARY KEY AUTOINCREMENT, 
      color TEXT, weight_metre REAL , 
      metre_height REAL , 
      cutting INTEGER , 
      rasta INTEGER , 
      zigzal INTEGER ,
      meyan INTEGER ,      
      FOREIGN KEY (cutting) REFERENCES cuttings (cutId), 
      FOREIGN KEY (rasta) REFERENCES accounts (accId),
      FOREIGN KEY (zigzal) REFERENCES accounts (accId),
      FOREIGN KEY (meyan) REFERENCES accounts (accId)    
      ) ''';

  Future<Database> initDB()async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path,version: 1, onCreate: (db,version)async{
     await db.execute(accountCategory);
     await db.execute(accounts);
     await db.execute(textTile);
     await db.execute(cuttings);
     await db.execute(cuttingDetails);


     //Default Data Section
     await db.rawQuery(accountType);

    });
  }


  //Cutting Section ---------------------------------------------------

  Future<List<CuttingsModel>> getAllCuttings() async {
    final Database db = await initDB();
    List<Map<String, Object?>> queryResult =
    await db.query('cuttings', orderBy: 'cutId');
    return queryResult.map((e) => CuttingsModel.fromMap(e)).toList();
  }

 //Cutting Details Section -------------------------------------------

 //Accounts -----------------------------------------------
  //Get Accounts Category
  Future<List<AccountCategoryModel>> getAccountCategory() async {
    final Database db = await initDB();
    List<Map<String, Object?>> queryResult =
    await db.query('accountCategory', orderBy: 'acId');
    return queryResult.map((e) => AccountCategoryModel.fromMap(e)).toList();
  }

  //Create a new person account
  Future<int> createAccount(name, duty, phone, accType, cardNumber, cardName,createdAt) async {
    final Database db = await initDB();
    return db.rawInsert("insert into accounts (accName, jobTitle, pPhone, accountType, cardNumber, cardName, createdAt) values (?,?,?,?,?,?,?) ",
        [name, duty, phone,accType,cardNumber,cardName,createdAt]);
  }


  //Search Accounts
  Future<List<AccountsModel>> searchAccountByName(keyword) async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryResult =
    await db.rawQuery('select accId, accName, jobTitle, pPhone,cardName, cardNumber, categoryName, pImage, createdAt, updatedAt from accounts as a INNER JOIN accountCategory as b ON a.accountType = b.acId where accName LIKE ?',["%$keyword%"]);
    return queryResult.map((e) => AccountsModel.fromMap(e)).toList();
  }

  //Show accounts
  Future<List<AccountsModel>> getAllAccounts() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryResult =
    await db.rawQuery('select accId, accName, jobTitle, pPhone,cardName, cardNumber, categoryName, pImage, createdAt, updatedAt from accounts as a INNER JOIN accountCategory as b ON a.accountType = b.acId');
    return queryResult.map((e) => AccountsModel.fromMap(e)).toList();
  }


  //Update profile image
  Future<int> updateProfileImage(String image, pId) async {
    final Database db = await initDB();
    var result = await db.rawUpdate(
        "update accounts set pImage = ? where accId  = ? ", [image, pId]);
    return result;
  }

  //Update person Details
  Future<int> updateProfileDetails(accName, jobTitle, cardNumber, accountName, pPhone, accId) async {
    final Database db = await initDB();
    var result = await db.rawUpdate(
        "update accounts set accName = ?, jobTitle = ?, cardNumber = ?, accountName = ?, pPhone = ?, updatedAt = ? where accId  = ? ",
        [accName, jobTitle, cardNumber, accountName, pPhone,DateTime.now().toIso8601String(), accId]);
    return result;
  }

  // Delete
  Future<void> deletePerson(String id,context) async {
    final db = await initDB();
    try {
      await db.delete("accounts", where: "accId = ?", whereArgs: [id]);
    } catch (err) {
      if (kDebugMode) {
        print("deleting failed: $err");
      }
    }
  }

 //Reports -------------------------------------------------


  //Login Screen
  Future<bool> authenticateUser(UsersModel user) async {
    final Database db = await initDB();
    var response = await db.rawQuery(
        "select * from users where usrName='${user.usrName}' and usrPassword='${user.usrPassword}'");
    if (response.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Update note
  Future<int> changePassword(String newPassword, String oldPassword) async {
    final Database db = await initDB();
    var result = await db.rawUpdate(
        "update users set usrPassword = ? where usrPassword = ? ",
        [newPassword, oldPassword]);
    return result;
  }

 }