import 'package:flutter/foundation.dart';
import 'package:ladyteen_system/JsonModels/cuttings_model.dart';
import 'package:ladyteen_system/JsonModels/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../JsonModels/account_category.dart';
import '../JsonModels/accounts_model.dart';
import '../JsonModels/user_model.dart';

class DatabaseHelper{
  final databaseName = "ladyteen6.db";

      String files = ''' create table files (
      fId INTEGER PRIMARY KEY AUTOINCREMENT, 
      fileName TEXT, 
      holder INTEGER,
      FOREIGN KEY (holder) REFERENCES accName (accId) 
      ) ''';

      String accountCategory = ''' create table accountCategory (
      acId INTEGER PRIMARY KEY AUTOINCREMENT, 
      categoryName TEXT NOT NULL
      )''';

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


      String textTile = ''' create table textTile (
      txtId INTEGER PRIMARY KEY AUTOINCREMENT,
      txtName TEXT, txtMadeIn TEXT 
      ) ''';

       String models = ''' create table models (
       mId INTEGER PRIMARY KEY AUTOINCREMENT,
       modelName TEXT NOT NULL, 
       modelCode INTEGER UNIQUE,
       modelTextTile INTEGER,
       madeIn TEXT,
       modelImages INTEGER,
       rasta_line REAL,
       zigzal_line REAL,
       meyan_line REAL, 
       createdAt TEXT DEFAULT CURRENT_TIMESTAMP, 
       FOREIGN KEY (modelImages) REFERENCES files (fId),
       FOREIGN KEY (modelTextTile) REFERENCES textTile (txtId)  
       )''';

      String modelPrices = '''  
      create table rates (
      priceId INTEGER PRIMARY KEY AUTOINCREMENT, 
      priceName TEXT UNIQUE, 
      priceAmount REAL,
      model INTEGER,
      FOREIGN KEY (model) REFERENCES models (mId)
      )''';

      String transactionType = '''
      create table transactionType (
      typeId INTEGER PRIMARY KEY AUTOINCREMENT,
      typeName TEXT UNIQUE,
      )
      ''';

      String transactions = ''' 
      create table transactions (
      trnId INTEGER PRIMARY KEY AUTOINCREMENT,
      trnPerson INTEGER,
      trnType INTEGER,
      trnDescription TEXT,
      trnAmount REAL,
      trnDate TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (trnType) REFERENCES accounts (typeId),
      FOREIGN KEY (trnPerson) REFERENCES accounts (accId)
      )
      ''';

      String cuttings = ''' create table cuttings (
      cutId INTEGER PRIMARY KEY AUTOINCREMENT, 
      model INTEGER,      
      qad_masrafi REAL,
      qty REAL,
      text_tile INTEGER,
      cuttingDate TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (text_tile) REFERENCES textTile (txtId) ,
      FOREIGN KEY (model) REFERENCES models (mId) 
      ) ''';

      String cuttingDetails = ''' create table cuttingDetails (
      cdId INTEGER PRIMARY KEY AUTOINCREMENT, 
      color TEXT, 
      measure REAL , 
      cutting INTEGER , 
      rasta INTEGER , 
      zigzal INTEGER ,
      meyan INTEGER ,
      submittedDate TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (cutting) REFERENCES cuttings (cutId), 
      FOREIGN KEY (rasta) REFERENCES accounts (accId),
      FOREIGN KEY (zigzal) REFERENCES accounts (accId),
      FOREIGN KEY (meyan) REFERENCES accounts (accId)    
      ) ''';

      String users = ''' create table users ( 
      usrId INTEGER PRIMARY KEY AUTOINCREMENT, 
      usrName TEXT UNIQUE,
      usrPassword TEXT
      ) ''';


      String userData = ''' insert into users 
       (usrId, usrName, usrPassword) 
       values(1,'admin','123456') ''';

      String accountType = ''' insert into accountCategory (acId, categoryName) values 
      (1,'tailor'),
      (2,'labour'), 
      (3,'bank'),
      (4,'customer'),
      (5,'personnel')
       ''';

      String textTileTypes = ''' insert into textTile (txtId, txtName) values 
      (1,'abrobadi'),
      (2,'katan'), 
      (3,'bakhmal'),
      (4,'nachral'),
      (5,'satan')
       ''';

      String transactionTypeData = ''' insert into transactionType (typeId, typeName) values 
       (1,'credit'),
       (2.'debit'),
      '''
      ;

    Future<Database> initDB()async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path,version: 1, onCreate: (db,version)async{
     await db.execute(accountCategory);
     await db.execute(accounts);
     await db.execute(files);
     await db.execute(textTile);
     await db.execute(cuttings);
     await db.execute(cuttingDetails);
     await db.execute(users);
     await db.execute(transactionType);
     await db.execute(transactions);
     await db.execute(models);
     await db.execute(modelPrices);

     //Default Data Section
     await db.rawQuery(accountType);
     await db.rawQuery(userData);
     await db.rawQuery(textTileTypes);
     await db.rawQuery(transactionTypeData);
    });
  }

  //Models ----------------------------------------------------------------------------
  //Get Models
  Future<List<ModelsJson>> getAllModels() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryResult =
    await db.rawQuery('select mId, modelName, modelCode,madeIn, rasta_line,zigzal_line, meyan_line, fileName, txtName,createdAt from models as model INNER JOIN textTile as txt ON model.modelTextTile = txt.txtId INNER JOIN files as image ON model.modelImages = image.fId');
    return queryResult.map((e) => ModelsJson.fromMap(e)).toList();
  }
  //Search models
  Future<List<ModelsJson>> searchModels(String keyword) async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryResult =
    await db.rawQuery('select mId, modelName, modelCode,madeIn, rasta_line,zigzal_line, meyan_line, fileName, txtName,createdAt from models as model INNER JOIN textTile as txt ON model.modelTextTile = txt.txtId INNER JOIN files as image ON model.modelImages = image.fId where modelName LIKE ?',["%$keyword%"]);
    return queryResult.map((e) => ModelsJson.fromMap(e)).toList();
  }

  //Create Model
  Future<int> createModel(modelName, modelCode, textTile, madeIn, images, rasta,zigzal,meyan,createdAt) async {
    final Database db = await initDB();
    return db.rawInsert("insert into models (modelName, modelCode, modelTextTile, madeIn, modelImages, rasta_line, zigzal_line,meyan_line, createdAt) values (?,?,?,?,?,?,?,?,?) ",
        [modelName, modelCode, textTile,madeIn,images,rasta,zigzal,meyan, createdAt]);
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
  Future<void> deleteAccount(String id,context) async {
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




  //Authentications
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

  //Change password
  Future<int> changePassword(String newPassword, String oldPassword) async {
    final Database db = await initDB();
    var result = await db.rawUpdate(
        "update users set usrPassword = ? where usrPassword = ? ",
        [newPassword, oldPassword]);
    return result;
  }

 }