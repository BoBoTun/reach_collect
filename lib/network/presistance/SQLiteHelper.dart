import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:reach_collect/data/model/consultation_model.dart';
import 'package:reach_collect/data/model/distribution_model.dart';
import 'package:reach_collect/data/model/he_model.dart';
import 'package:reach_collect/data/model/muac_model.dart';
import 'package:reach_collect/screens/consultation/epi_register.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

import '../../data/model/anc_model.dart';
import '../../data/model/delivery_model.dart';
import '../../data/model/epi_model.dart';
import '../../data/model/pnu_model.dart';
import '../../data/model/referal_model.dart';
import '../../data/model/srh_model.dart';
import 'database_table.dart';

class SQLiteHelper {
  static const int DATABASE_VERSION = 1;
  static const String DATABASE_NAME = "data";
  static const String TEXT_TYPE = " TEXT";
  static const String INTEGER_TYPE = " INTEGER";
  static const String BOOL_TYPE = 'INTEGER';
  static const String DOUBLE_TYPE = " REAL";
  static const String INTEGER_AUTO_INCREMENT =
      " INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL";

  static const String SQL_CREATE_ACN_TABLE =
      "CREATE TABLE ${AncRegisterTable.TABLE_NAME} (${AncRegisterTable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
      "${AncRegisterTable.COLUMM_TABLE}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMM_ORG_NAME}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMM_STATE_NAME}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMM_CLINIC}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMM_CHANNEL}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMM_REPORTING_PERIOD}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Name}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Age}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Date}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Disability}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_IDP}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Gestational}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Gravida}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Parity}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Td}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Findings}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Treatment}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_ANC4}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Attended}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Outcome}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_NAME_Remark}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_CREATE_DATE}$TEXT_TYPE,"
      "${AncRegisterTable.COLUMN_UPDATE_DATE}$TEXT_TYPE)";

  static const String SQL_CREATE_DELIVERY_TABLE =
      "CREATE TABLE ${DeliveryTable.TABLE_NAME} (${DeliveryTable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
      "${DeliveryTable.COLUMM_TABLE}$TEXT_TYPE,"
      "${DeliveryTable.COLUMM_ORG_NAME}$TEXT_TYPE,"
      "${DeliveryTable.COLUMM_STATE_NAME}$TEXT_TYPE,"
      "${DeliveryTable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
      "${DeliveryTable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
      "${DeliveryTable.COLUMM_CLINIC}$TEXT_TYPE,"
      "${DeliveryTable.COLUMM_CHANNEL}$TEXT_TYPE,"
      "${DeliveryTable.COLUMM_REPORTING_PERIOD}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_Date}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_Name}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_Age}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_Disability}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_IDP}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_Gestational}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_Gravida}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_TD_COMPLETE}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_BIRTH_TYPE}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_BIRTH_WEIGHT}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_NEONATAL}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_BREASTFEEDING}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_Treatment}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_Attended}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_Outcome}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_NAME_Remark}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_CREATE_DATE}$TEXT_TYPE,"
      "${DeliveryTable.COLUMN_UPDATE_DATE}$TEXT_TYPE)";

  static const String SQL_CREATE_SRH_TABLE =
      "CREATE TABLE ${SRHTable.TABLE_NAME} (${SRHTable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
      "${SRHTable.COLUMM_TABLE}$TEXT_TYPE,"
      "${SRHTable.COLUMM_ORG_NAME}$TEXT_TYPE,"
      "${SRHTable.COLUMM_STATE_NAME}$TEXT_TYPE,"
      "${SRHTable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
      "${SRHTable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
      "${SRHTable.COLUMM_CLINIC}$TEXT_TYPE,"
      "${SRHTable.COLUMM_CHANNEL}$TEXT_TYPE,"
      "${SRHTable.COLUMM_REPORTING_PERIOD}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Date}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Name}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Age}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_SEX}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Disability}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_IDP}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_SERVICE_TYPE}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_FIRST_REACH}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_FP_COMMODITY}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_QUANTITY}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_FANDP_DIAGNOSIS}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Treatment}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Attended}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Outcome}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Remark}$TEXT_TYPE,"
      "${SRHTable.COLUMN_CREATE_DATE}$TEXT_TYPE,"
      "${SRHTable.COLUMN_UPDATE_DATE}$TEXT_TYPE)";

  static const String SQL_CREATE_EPI_TABLE =
      "CREATE TABLE ${EPITable.TABLE_NAME} (${EPITable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
      "${EPITable.COLUMM_TABLE}$TEXT_TYPE,"
      "${EPITable.COLUMM_ORG_NAME}$TEXT_TYPE,"
      "${EPITable.COLUMM_STATE_NAME}$TEXT_TYPE,"
      "${EPITable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
      "${EPITable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
      "${EPITable.COLUMM_CLINIC}$TEXT_TYPE,"
      "${EPITable.COLUMM_CHANNEL}$TEXT_TYPE,"
      "${EPITable.COLUMM_REPORTING_PERIOD}$TEXT_TYPE,"
      "${EPITable.COLUMN_CHILD_NAME}$TEXT_TYPE,"
      "${EPITable.COLUMN_NAME_SEX}$TEXT_TYPE,"
      "${EPITable.COLUMN_NAME_Disabled}$TEXT_TYPE,"
      "${EPITable.COLUMN_NAME_Relocation}$TEXT_TYPE,"
      "${EPITable.COLUMN_NAME_Address}$TEXT_TYPE,"
      "${EPITable.COLUMN_NAME_DOB}$TEXT_TYPE,"
      "${EPITable.COLUMN_NAME_BCG}$TEXT_TYPE,"
      "${EPITable.COLUMN_NAME_Vaccined}$TEXT_TYPE,"
      "${EPITable.COLUMN_NAME_Refer}$TEXT_TYPE,"
      "${EPITable.COLUMN_NAME_ReferPlace}$TEXT_TYPE,"
      "${EPITable.COLUMN_NAME_Remark}$TEXT_TYPE,"
      "${EPITable.COLUMN_CREATE_DATE}$TEXT_TYPE,"
      "${EPITable.COLUMN_UPDATE_DATE}$TEXT_TYPE)";

  static const String SQL_CREATE_MUAC_TABLE =
      "CREATE TABLE ${MUACTable.TABLE_NAME} (${MUACTable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
      "${MUACTable.COLUMM_TABLE}$TEXT_TYPE,"
      "${MUACTable.COLUMM_ORG_NAME}$TEXT_TYPE,"
      "${MUACTable.COLUMM_STATE_NAME}$TEXT_TYPE,"
      "${MUACTable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
      "${MUACTable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
      "${MUACTable.COLUMM_CLINIC}$TEXT_TYPE,"
      "${MUACTable.COLUMM_VILLAGE_NAME}$TEXT_TYPE,"
      "${MUACTable.COLUMM_VOLUNTEER_NAME}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_Date}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAMEE}$TEXT_TYPE,"
      "${MUACTable.COLUMN_AGE}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_SEX}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_Disabled}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_Relocation}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_Phone}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_Armsize}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_Weight}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_Swelling}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_Refer}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_ReferPlace}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_ReferGo}$TEXT_TYPE,"
      "${MUACTable.COLUMN_NAME_Remark}$TEXT_TYPE,"
      "${MUACTable.COLUMN_CREATE_DATE}$TEXT_TYPE,"
      "${MUACTable.COLUMN_UPDATE_DATE}$TEXT_TYPE)";

  static const String SQL_CREATE_PNU_TABLE =
      "CREATE TABLE ${PNUTable.TABLE_NAME} (${PNUTable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
      "${PNUTable.COLUMM_TABLE}$TEXT_TYPE,"
      "${PNUTable.COLUMM_ORG_NAME}$TEXT_TYPE,"
      "${PNUTable.COLUMM_STATE_NAME}$TEXT_TYPE,"
      "${PNUTable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
      "${PNUTable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
      "${PNUTable.COLUMM_CLINIC}$TEXT_TYPE,"
      "${PNUTable.COLUMM_VILLAGE_NAME}$TEXT_TYPE,"
      "${PNUTable.COLUMM_VOLUNTEER_NAME}$TEXT_TYPE,"
      "${PNUTable.COLUMM_REPORTING_PERIOD}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_Date}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME}$TEXT_TYPE,"
      "${PNUTable.COLUMN_AGE}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_SEX}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_Disabled}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_Relocation}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_KOFPatient}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_SymptomsList}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_DiseaseList}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_Treatment}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_TreatmentPeriod}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_Refer}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_ReferPlace}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_ReferGo}$TEXT_TYPE,"
      "${PNUTable.COLUMN_NAME_Remark}$TEXT_TYPE,"
      "${PNUTable.COLUMN_CREATE_DATE}$TEXT_TYPE,"
      "${PNUTable.COLUMN_UPDATE_DATE}$TEXT_TYPE)";

  static const String SQL_CREATE_Consultation_TABLE =
      "CREATE TABLE ${ConsultationTable.TABLE_NAME} (${ConsultationTable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
      "${ConsultationTable.COLUMM_TABLE}$TEXT_TYPE,"
      "${ConsultationTable.COLUMM_ORG_NAME}$TEXT_TYPE,"
      "${ConsultationTable.COLUMM_STATE_NAME}$TEXT_TYPE,"
      "${ConsultationTable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
      "${ConsultationTable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
      "${ConsultationTable.COLUMM_CLINIC}$TEXT_TYPE,"
      "${ConsultationTable.COLUMM_CHANNEL}$TEXT_TYPE,"
      "${ConsultationTable.COLUMM_REPORTING_PERIOD}$TEXT_TYPE,"
      "${ConsultationTable.COLUMN_NAME_Date}$TEXT_TYPE,"
      "${ConsultationTable.COLUMN_NAME_Trauma}$TEXT_TYPE,"
      "${ConsultationTable.COLUMN_NAME_Other_Consultations}$TEXT_TYPE,"
      "${ConsultationTable.COLUMN_NAME_U5_Pneumonia}$TEXT_TYPE,"
      "${ConsultationTable.COLUMN_NAME_U5_Diarrhoea}$TEXT_TYPE,"
      "${ConsultationTable.COLUMN_NAME_IDP}$TEXT_TYPE,"
      "${ConsultationTable.COLUMN_NAME_Disability}$TEXT_TYPE,"
      "${ConsultationTable.COLUMN_NAME_Remark}$TEXT_TYPE,"
      "${ConsultationTable.COLUMN_CREATE_DATE}$TEXT_TYPE,"
      "${ConsultationTable.COLUMN_UPDATE_DATE}$TEXT_TYPE)";

  static const String SQL_CREATE_Distribution_TABLE =
      "CREATE TABLE ${DistributionTable.TABLE_NAME} (${DistributionTable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
      "${DistributionTable.COLUMM_TABLE}$TEXT_TYPE,"
      "${DistributionTable.COLUMM_ORG_NAME}$TEXT_TYPE,"
      "${DistributionTable.COLUMM_STATE_NAME}$TEXT_TYPE,"
      "${DistributionTable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
      "${DistributionTable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
      "${DistributionTable.COLUMM_CLINIC}$TEXT_TYPE,"
      "${DistributionTable.COLUMM_REPORTING_PERIOD}$TEXT_TYPE,"
      "${DistributionTable.COLUMN_NAME_Date}$TEXT_TYPE,"
      "${DistributionTable.COLUMN_NAME_Distribution_Type}$TEXT_TYPE,"
  "${DistributionTable.COLUMN_NAME_Beneficiary_Type}$TEXT_TYPE,"
  "${DistributionTable.COLUMN_NAME_Item1}$TEXT_TYPE,"
  "${DistributionTable.COLUMN_NAME_Item2}$TEXT_TYPE,"
  "${DistributionTable.COLUMN_NAME_Item3}$TEXT_TYPE,"
  "${DistributionTable.COLUMN_NAME_Household}$TEXT_TYPE,"
  "${DistributionTable.COLUMN_NAME_Under18}$TEXT_TYPE,"
  "${DistributionTable.COLUMN_NAME_Over18}$TEXT_TYPE,"
  "${DistributionTable.COLUMN_NAME_IDP}$TEXT_TYPE,"
  "${DistributionTable.COLUMN_NAME_Disability}$TEXT_TYPE,"
      "${DistributionTable.COLUMN_NAME_Remark}$TEXT_TYPE,"
      "${DistributionTable.COLUMN_CREATE_DATE}$TEXT_TYPE,"
      "${DistributionTable.COLUMN_UPDATE_DATE}$TEXT_TYPE)";

  static const String SQL_CREATE_HE_TABLE =
      "CREATE TABLE ${HETable.TABLE_NAME} (${HETable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
      "${HETable.COLUMM_TABLE}$TEXT_TYPE,"
      "${HETable.COLUMM_ORG_NAME}$TEXT_TYPE,"
      "${HETable.COLUMM_STATE_NAME}$TEXT_TYPE,"
      "${HETable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
      "${HETable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
      "${HETable.COLUMM_Village_Name}$TEXT_TYPE,"
  "${HETable.COLUMM_NAME_Topic}$TEXT_TYPE,"
  "${HETable.COLUMN_NAME_Date}$TEXT_TYPE,"
  "${HETable.COLUMN_NAME_Presenter_Name}$TEXT_TYPE,"
  "${HETable.COLUMN_NAME_Position}$TEXT_TYPE,"
  "${HETable.COLUMN_NAME_Attended_Name}$TEXT_TYPE,"
  "${HETable.COLUMN_NAME_Age}$TEXT_TYPE,"
  "${HETable.COLUMN_NAME_Gender}$TEXT_TYPE,"
  "${HETable.COLUMN_NAME_Disability}$TEXT_TYPE,"
  "${HETable.COLUMN_NAME_Relocation}$TEXT_TYPE,"
      "${HETable.COLUMN_NAME_IS_New}$TEXT_TYPE,"
      "${DistributionTable.COLUMN_NAME_Remark}$TEXT_TYPE,"
      "${DistributionTable.COLUMN_CREATE_DATE}$TEXT_TYPE,"
      "${DistributionTable.COLUMN_UPDATE_DATE}$TEXT_TYPE)";

  static const String SQL_CREATE_Referral_TABLE =
      "CREATE TABLE ${ReferralTable.TABLE_NAME} (${ReferralTable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
      "${ReferralTable.COLUMM_TABLE}$TEXT_TYPE,"
      "${ReferralTable.COLUMM_ORG_NAME}$TEXT_TYPE,"
      "${ReferralTable.COLUMM_STATE_NAME}$TEXT_TYPE,"
      "${ReferralTable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
      "${ReferralTable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
      "${ReferralTable.COLUMM_CLINIC}$TEXT_TYPE,"
      "${ReferralTable.COLUMM_Village_Name}$TEXT_TYPE,"
      "${ReferralTable.COLUMN_NAME_Date}$TEXT_TYPE,"
      "${ReferralTable.COLUMN_NAME_Name}$TEXT_TYPE,"
  "${ReferralTable.COLUMN_NAME_Age}$TEXT_TYPE,"
  "${ReferralTable.COLUMN_NAME_Gender}$TEXT_TYPE,"
  "${ReferralTable.COLUMN_NAME_Disability}$TEXT_TYPE,"
  "${ReferralTable.COLUMN_NAME_Relocation}$TEXT_TYPE,"
  "${ReferralTable.COLUMN_NAME_Referral_Type}$TEXT_TYPE,"
  "${ReferralTable.COLUMN_NAME_Referral_Case}$TEXT_TYPE,"
  "${ReferralTable.COLUMN_NAME_Referral_Place}$TEXT_TYPE,"
  "${ReferralTable.COLUMN_NAME_Referral_Cost}$TEXT_TYPE,"
  "${ReferralTable.COLUMN_NAME_Referral_Staff_Name}$TEXT_TYPE,"
      "${DistributionTable.COLUMN_NAME_Remark}$TEXT_TYPE,"
      "${DistributionTable.COLUMN_CREATE_DATE}$TEXT_TYPE,"
      "${DistributionTable.COLUMN_UPDATE_DATE}$TEXT_TYPE)";

  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

// Platform Specific
  Future<Database> initDB() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      final databaseFactory = databaseFactoryFfi;
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentsDir.path, "rcv1", "rcb.db");
      //databaseFactory.deleteDatabase(dbPath);
      final winLinuxDB = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
          version: DATABASE_VERSION,
          onCreate: _onCreate,
        ),
      );
      return winLinuxDB;
    } else if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, "data.db");
      //databaseFactory.deleteDatabase(path);
      final iOSAndroidDB = await openDatabase(
        path,
        version: DATABASE_VERSION,
        onCreate: _onCreate,
      );
      return iOSAndroidDB;
    }
    throw Exception("Unsupported platform");
  }

  Future<void> _onCreate(Database database, int version) async {
    final db = database;
    await db.execute(SQL_CREATE_ACN_TABLE);
    await db.execute(SQL_CREATE_DELIVERY_TABLE);
    await db.execute(SQL_CREATE_SRH_TABLE);
    await db.execute(SQL_CREATE_EPI_TABLE);
    await db.execute(SQL_CREATE_MUAC_TABLE);
    await db.execute(SQL_CREATE_PNU_TABLE);
    await db.execute(SQL_CREATE_Consultation_TABLE);
    await db.execute(SQL_CREATE_Distribution_TABLE);
    await db.execute(SQL_CREATE_HE_TABLE);
    await db.execute(SQL_CREATE_Referral_TABLE);

  }

  //RMNCH FORM
  //INSERT
  Future insertACNDataToDB(ANCVo acnVo, bool isImport) async {
    final db = await database;
    Batch batch = db.batch();

    var data = <String, dynamic>{
      AncRegisterTable.COLUMM_TABLE: acnVo.tableName,
      AncRegisterTable.COLUMM_ORG_NAME: acnVo.orgName,
      AncRegisterTable.COLUMM_STATE_NAME: acnVo.stateName,
      AncRegisterTable.COLUMM_TOWNSHIP_NAME: acnVo.townshipName,
      AncRegisterTable.COLUMM_TOWNSHIP_LOCAL_NAME: acnVo.townshipLocalName,
      AncRegisterTable.COLUMM_CLINIC: acnVo.clinic,
      AncRegisterTable.COLUMM_CHANNEL: acnVo.channel,
      AncRegisterTable.COLUMM_REPORTING_PERIOD: acnVo.reportingPeroid,
      AncRegisterTable.COLUMN_NAME_Name: acnVo.name,
      AncRegisterTable.COLUMN_NAME_Age: acnVo.age,
      AncRegisterTable.COLUMN_NAME_Date: acnVo.date,
      AncRegisterTable.COLUMN_NAME_Disability: acnVo.disability,
      AncRegisterTable.COLUMN_NAME_IDP: acnVo.idp,
      AncRegisterTable.COLUMN_NAME_Gestational: acnVo.gestational,
      AncRegisterTable.COLUMN_NAME_Gravida: acnVo.gravida,
      AncRegisterTable.COLUMN_NAME_Parity: acnVo.parity,
      AncRegisterTable.COLUMN_NAME_Findings: acnVo.findings,
      AncRegisterTable.COLUMN_NAME_Td: acnVo.td,
      AncRegisterTable.COLUMN_NAME_Treatment: acnVo.treatment,
      AncRegisterTable.COLUMN_NAME_ANC4: acnVo.ancfour,
      AncRegisterTable.COLUMN_NAME_Attended: acnVo.attended,
      AncRegisterTable.COLUMN_NAME_Outcome: acnVo.outcome,
      AncRegisterTable.COLUMN_NAME_Remark: acnVo.remark,
      AncRegisterTable.COLUMN_CREATE_DATE: acnVo.createDate,
      AncRegisterTable.COLUMN_UPDATE_DATE: acnVo.updateDate
    };

    //db.rawQuery("SELECT * FROM '${DeliveryTable.TABLE_NAME}';", null);
    if (isImport){
      var exitCount =
      await db.rawQuery("SELECT COUNT(*) AS count FROM ${AncRegisterTable.TABLE_NAME} WHERE ${AncRegisterTable.COLUMN_CREATE_DATE} = '${acnVo.createDate}' AND ${AncRegisterTable.COLUMN_UPDATE_DATE} = '${acnVo.updateDate}'");
      //inset village
      print("Exit Value :::: $exit");
      int count = exitCount.first['count'] as int;
      if (count == 0){
        batch.insert(AncRegisterTable.TABLE_NAME, data,
            conflictAlgorithm: ConflictAlgorithm.replace);

        batch.commit();
      }
    }else{
      batch.insert(AncRegisterTable.TABLE_NAME, data,
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.commit();
    }


    return;
  }

  Future insertDeliveryDataToDB(DeliveryVo acnVo, bool isImport) async {
    final db = await database;
    Batch batch = db.batch();

    var data = <String, dynamic>{
      DeliveryTable.COLUMM_TABLE: acnVo.tableName,
      DeliveryTable.COLUMM_ORG_NAME: acnVo.orgName,
      DeliveryTable.COLUMM_STATE_NAME: acnVo.stateName,
      DeliveryTable.COLUMM_TOWNSHIP_NAME: acnVo.townshipName,
      DeliveryTable.COLUMM_TOWNSHIP_LOCAL_NAME: acnVo.townshipLocalName,
      DeliveryTable.COLUMM_CLINIC: acnVo.clinic,
      DeliveryTable.COLUMM_CHANNEL: acnVo.channel,
      DeliveryTable.COLUMM_REPORTING_PERIOD: acnVo.reportingPeroid,
      DeliveryTable.COLUMN_NAME_Name: acnVo.name,
      DeliveryTable.COLUMN_NAME_Date: acnVo.date,
      DeliveryTable.COLUMN_NAME_Age: acnVo.age,
      DeliveryTable.COLUMN_NAME_Disability: acnVo.disability,
      DeliveryTable.COLUMN_NAME_IDP: acnVo.iDP,
      DeliveryTable.COLUMN_NAME_Gestational: acnVo.gestational,
      DeliveryTable.COLUMN_NAME_Gravida: acnVo.gravida,
      DeliveryTable.COLUMN_NAME_TD_COMPLETE: acnVo.tDComplete,
      DeliveryTable.COLUMN_NAME_BIRTH_TYPE: acnVo.birthType,
      DeliveryTable.COLUMN_NAME_BIRTH_WEIGHT: acnVo.birthWeight,
      DeliveryTable.COLUMN_NAME_NEONATAL: acnVo.neonatal,
      DeliveryTable.COLUMN_NAME_BREASTFEEDING: acnVo.breastfeeding,
      DeliveryTable.COLUMN_NAME_Treatment: acnVo.treatment,
      DeliveryTable.COLUMN_NAME_Attended: acnVo.attended,
      DeliveryTable.COLUMN_NAME_Outcome: acnVo.outcome,
      DeliveryTable.COLUMN_NAME_Remark: acnVo.remark,
      DeliveryTable.COLUMN_CREATE_DATE: acnVo.createDate,
      DeliveryTable.COLUMN_UPDATE_DATE: acnVo.updateDate,
    };
    //inset village

    if (isImport){
      var exitCount =
      await db.rawQuery("SELECT COUNT(*) AS count FROM ${DeliveryTable.TABLE_NAME} WHERE ${DeliveryTable.COLUMN_CREATE_DATE} = '${acnVo.createDate}' AND ${DeliveryTable.COLUMN_UPDATE_DATE} = '${acnVo.updateDate}'");
      //inset village
      print("Exit Value :::: $exit");
      int count = exitCount.first['count'] as int;
      if (count == 0){
        batch.insert(DeliveryTable.TABLE_NAME, data,
            conflictAlgorithm: ConflictAlgorithm.abort);

        batch.commit();
      }
    }else{
      batch.insert(DeliveryTable.TABLE_NAME, data,
          conflictAlgorithm: ConflictAlgorithm.abort);

      batch.commit();
    }

    return;
  }

  Future insertSRHDataToDB(SRHVo acnVo, bool isImport) async {
    final db = await database;
    Batch batch = db.batch();

    var data = <String, dynamic>{
      SRHTable.COLUMM_TABLE: acnVo.tableName,
      SRHTable.COLUMM_ORG_NAME: acnVo.orgName,
      SRHTable.COLUMM_STATE_NAME: acnVo.stateName,
      SRHTable.COLUMM_TOWNSHIP_NAME: acnVo.townshipName,
      SRHTable.COLUMM_TOWNSHIP_LOCAL_NAME: acnVo.townshipLocalName,
      SRHTable.COLUMM_CLINIC: acnVo.clinic,
      SRHTable.COLUMM_CHANNEL: acnVo.channel,
      SRHTable.COLUMM_REPORTING_PERIOD: acnVo.reportingPeroid,
      SRHTable.COLUMN_NAME_Name: acnVo.name,
      SRHTable.COLUMN_NAME_Date: acnVo.date,
      SRHTable.COLUMN_NAME_Age: acnVo.age,
      SRHTable.COLUMN_NAME_SEX: acnVo.sex,
      SRHTable.COLUMN_NAME_Disability: acnVo.disability,
      SRHTable.COLUMN_NAME_IDP: acnVo.iDP,
      SRHTable.COLUMN_NAME_SERVICE_TYPE: acnVo.serviceType,
      SRHTable.COLUMN_NAME_FIRST_REACH: acnVo.firstReach,
      SRHTable.COLUMN_NAME_FP_COMMODITY: acnVo.fpCommodity,
      SRHTable.COLUMN_NAME_QUANTITY: acnVo.quantity,
      SRHTable.COLUMN_NAME_FANDP_DIAGNOSIS: acnVo.fnpDiagnosis,
      SRHTable.COLUMN_NAME_Treatment: acnVo.treatment,
      SRHTable.COLUMN_NAME_Attended: acnVo.attended,
      SRHTable.COLUMN_NAME_Outcome: acnVo.outcome,
      SRHTable.COLUMN_NAME_Remark: acnVo.remark,
      SRHTable.COLUMN_CREATE_DATE: acnVo.createDate,
      SRHTable.COLUMN_UPDATE_DATE: acnVo.updateDate,
    };

    if (isImport){
      var exitCount =
      await db.rawQuery("SELECT COUNT(*) AS count FROM ${SRHTable.TABLE_NAME} WHERE ${SRHTable.COLUMN_CREATE_DATE} = '${acnVo.createDate}' AND ${SRHTable.COLUMN_UPDATE_DATE} = '${acnVo.updateDate}'");
      //inset village
      print("Exit Value :::: $exit");
      int count = exitCount.first['count'] as int;
      if (count == 0){
        batch.insert(SRHTable.TABLE_NAME, data,
            conflictAlgorithm: ConflictAlgorithm.abort);

        batch.commit();
      }
    }else{
      batch.insert(SRHTable.TABLE_NAME, data,
          conflictAlgorithm: ConflictAlgorithm.abort);

      batch.commit();
    }
    //inset village

    return;
  }


  //SELECT
  Future<List<ANCVo>> getAllAncDataFromDB() async {
    final db = await database;
    List<ANCVo> reachCollectData = [];
    dynamic reachCollectValue = await db.rawQuery(
        "SELECT * FROM '${AncRegisterTable.TABLE_NAME}';", null);

    for (var reachCollect in reachCollectValue) {
      ANCVo ancVo = ANCVo();
      ancVo.id = reachCollect[AncRegisterTable.COLUMM_Id];
      ancVo.orgName = reachCollect[AncRegisterTable.COLUMM_ORG_NAME];
      ancVo.stateName = reachCollect[AncRegisterTable.COLUMM_STATE_NAME];
      ancVo.townshipName = reachCollect[AncRegisterTable.COLUMM_TOWNSHIP_NAME];
      ancVo.townshipLocalName =
          reachCollect[AncRegisterTable.COLUMM_TOWNSHIP_LOCAL_NAME];
      ancVo.clinic = reachCollect[AncRegisterTable.COLUMM_CLINIC];
      ancVo.channel = reachCollect[AncRegisterTable.COLUMM_CHANNEL];
      ancVo.reportingPeroid =
          reachCollect[AncRegisterTable.COLUMM_REPORTING_PERIOD];
      ancVo.age = reachCollect[AncRegisterTable.COLUMN_NAME_Age];
      ancVo.name = reachCollect[AncRegisterTable.COLUMN_NAME_Name];
      ancVo.date = reachCollect[AncRegisterTable.COLUMN_NAME_Date];
      ancVo.disability = reachCollect[AncRegisterTable.COLUMN_NAME_Disability];
      ancVo.idp = reachCollect[AncRegisterTable.COLUMN_NAME_IDP];
      ancVo.gestational =
          reachCollect[AncRegisterTable.COLUMN_NAME_Gestational];
      ancVo.gravida = reachCollect[AncRegisterTable.COLUMN_NAME_Gravida];
      ancVo.parity = reachCollect[AncRegisterTable.COLUMN_NAME_Parity];
      ancVo.td = reachCollect[AncRegisterTable.COLUMN_NAME_Td];
      ancVo.findings = reachCollect[AncRegisterTable.COLUMN_NAME_Findings];
      ancVo.treatment = reachCollect[AncRegisterTable.COLUMN_NAME_Treatment];
      ancVo.ancfour = reachCollect[AncRegisterTable.COLUMN_NAME_ANC4];
      ancVo.attended = reachCollect[AncRegisterTable.COLUMN_NAME_Attended];
      ancVo.outcome = reachCollect[AncRegisterTable.COLUMN_NAME_Outcome];
      ancVo.remark = reachCollect[AncRegisterTable.COLUMN_NAME_Remark];
      ancVo.createDate = reachCollect[AncRegisterTable.COLUMN_CREATE_DATE];
      ancVo.updateDate = reachCollect[AncRegisterTable.COLUMN_UPDATE_DATE];
      reachCollectData.add(ancVo);
    }
    return reachCollectData;
  }

  Future<List<DeliveryVo>> getAllDeliveryDataFromDB() async {
    final db = await database;
    List<DeliveryVo> reachCollectData = [];
    dynamic reachCollectValue =
        await db.rawQuery("SELECT * FROM '${DeliveryTable.TABLE_NAME}';", null);

    for (var reachCollect in reachCollectValue) {
      DeliveryVo deliveryVo = DeliveryVo();
      deliveryVo.id = reachCollect[DeliveryTable.COLUMM_Id];
      deliveryVo.orgName = reachCollect[DeliveryTable.COLUMM_ORG_NAME];
      deliveryVo.stateName = reachCollect[DeliveryTable.COLUMM_STATE_NAME];
      deliveryVo.townshipName =
          reachCollect[DeliveryTable.COLUMM_TOWNSHIP_NAME];
      deliveryVo.townshipLocalName =
          reachCollect[DeliveryTable.COLUMM_TOWNSHIP_LOCAL_NAME];
      deliveryVo.clinic = reachCollect[DeliveryTable.COLUMM_CLINIC];
      deliveryVo.channel = reachCollect[DeliveryTable.COLUMM_CHANNEL];
      deliveryVo.reportingPeroid =
          reachCollect[DeliveryTable.COLUMM_REPORTING_PERIOD];
      deliveryVo.date = reachCollect[DeliveryTable.COLUMN_NAME_Date];
      deliveryVo.age = reachCollect[DeliveryTable.COLUMN_NAME_Age];
      deliveryVo.name = reachCollect[DeliveryTable.COLUMN_NAME_Name];
      deliveryVo.disability =
          reachCollect[DeliveryTable.COLUMN_NAME_Disability];
      deliveryVo.iDP = reachCollect[DeliveryTable.COLUMN_NAME_IDP];
      deliveryVo.gestational =
          reachCollect[DeliveryTable.COLUMN_NAME_Gestational];
      deliveryVo.gravida = reachCollect[DeliveryTable.COLUMN_NAME_Gravida];
      deliveryVo.tDComplete =
          reachCollect[DeliveryTable.COLUMN_NAME_TD_COMPLETE];
      deliveryVo.birthType = reachCollect[DeliveryTable.COLUMN_NAME_BIRTH_TYPE];
      deliveryVo.birthWeight =
          reachCollect[DeliveryTable.COLUMN_NAME_BIRTH_WEIGHT];
      deliveryVo.neonatal = reachCollect[DeliveryTable.COLUMN_NAME_NEONATAL];
      deliveryVo.breastfeeding =
          reachCollect[DeliveryTable.COLUMN_NAME_BREASTFEEDING];
      deliveryVo.treatment = reachCollect[DeliveryTable.COLUMN_NAME_Treatment];
      deliveryVo.attended = reachCollect[DeliveryTable.COLUMN_NAME_Attended];
      deliveryVo.outcome = reachCollect[DeliveryTable.COLUMN_NAME_Outcome];
      deliveryVo.remark = reachCollect[DeliveryTable.COLUMN_NAME_Remark];
      deliveryVo.createDate = reachCollect[DeliveryTable.COLUMN_CREATE_DATE];
      deliveryVo.updateDate = reachCollect[DeliveryTable.COLUMN_UPDATE_DATE];
      reachCollectData.add(deliveryVo);
    }
    return reachCollectData;
  }

  Future<List<SRHVo>> getAllSRHDataFromDB() async {
    final db = await database;
    List<SRHVo> reachCollectData = [];
    dynamic reachCollectValue =
        await db.rawQuery("SELECT * FROM '${SRHTable.TABLE_NAME}';", null);

    for (var reachCollect in reachCollectValue) {
      SRHVo srhVo = SRHVo();
      srhVo.id = reachCollect[SRHTable.COLUMM_Id];
      srhVo.orgName = reachCollect[SRHTable.COLUMM_ORG_NAME];
      srhVo.stateName = reachCollect[SRHTable.COLUMM_STATE_NAME];
      srhVo.townshipName = reachCollect[SRHTable.COLUMM_TOWNSHIP_NAME];
      srhVo.townshipLocalName =
          reachCollect[SRHTable.COLUMM_TOWNSHIP_LOCAL_NAME];
      srhVo.clinic = reachCollect[SRHTable.COLUMM_CLINIC];
      srhVo.channel = reachCollect[SRHTable.COLUMM_CHANNEL];
      srhVo.reportingPeroid = reachCollect[SRHTable.COLUMM_REPORTING_PERIOD];
      srhVo.date = reachCollect[SRHTable.COLUMN_NAME_Date];
      srhVo.age = reachCollect[SRHTable.COLUMN_NAME_Age];
      srhVo.name = reachCollect[SRHTable.COLUMN_NAME_Name];
      srhVo.sex = reachCollect[SRHTable.COLUMN_NAME_SEX];
      srhVo.disability = reachCollect[SRHTable.COLUMN_NAME_Disability];
      srhVo.iDP = reachCollect[SRHTable.COLUMN_NAME_IDP];
      srhVo.serviceType = reachCollect[SRHTable.COLUMN_NAME_SERVICE_TYPE];
      srhVo.firstReach = reachCollect[SRHTable.COLUMN_NAME_FIRST_REACH];
      srhVo.fpCommodity = reachCollect[SRHTable.COLUMN_NAME_FP_COMMODITY];
      srhVo.quantity = reachCollect[SRHTable.COLUMN_NAME_QUANTITY];
      srhVo.fnpDiagnosis = reachCollect[SRHTable.COLUMN_NAME_FANDP_DIAGNOSIS];
      srhVo.treatment = reachCollect[SRHTable.COLUMN_NAME_Treatment];
      srhVo.attended = reachCollect[SRHTable.COLUMN_NAME_Attended];
      srhVo.outcome = reachCollect[SRHTable.COLUMN_NAME_Outcome];
      srhVo.remark = reachCollect[SRHTable.COLUMN_NAME_Remark];
      srhVo.createDate = reachCollect[SRHTable.COLUMN_CREATE_DATE];
      srhVo.updateDate = reachCollect[SRHTable.COLUMN_UPDATE_DATE];
      reachCollectData.add(srhVo);
    }
    return reachCollectData;
  }

  Future<List<List<String>>> getAllANCForExport() async {
    final db = await database;
    List<String> headerList = [
      "TableName",
      "Sr",
      "Organization",
      "State/Region",
      "Township (MIMU)",
      "Township (Local)",
      "Clinic",
      "Channel",
      "Reporting Period",
      (AncRegisterTable.COLUMN_NAME_Date),
      (AncRegisterTable.COLUMN_NAME_Name),
      (AncRegisterTable.COLUMN_NAME_Age),
      (AncRegisterTable.COLUMN_NAME_Disability),
      (AncRegisterTable.COLUMN_NAME_IDP),
      (AncRegisterTable.COLUMN_NAME_Gestational),
      (AncRegisterTable.COLUMN_NAME_Gravida),
      (AncRegisterTable.COLUMN_NAME_Parity),
      (AncRegisterTable.COLUMN_NAME_Td),
      (AncRegisterTable.COLUMN_NAME_Findings),
      (AncRegisterTable.COLUMN_NAME_Treatment),
      (AncRegisterTable.COLUMN_NAME_ANC4),
      (AncRegisterTable.COLUMN_NAME_Attended),
      (AncRegisterTable.COLUMN_NAME_Outcome),
      (AncRegisterTable.COLUMN_NAME_Remark),
      (AncRegisterTable.COLUMN_CREATE_DATE),
      (AncRegisterTable.COLUMN_UPDATE_DATE)
    ];
    List<List<String>> ancList = [headerList];
    dynamic reachCollectValue = await db.rawQuery(
        "SELECT * FROM '${AncRegisterTable.TABLE_NAME}';", null);

    for (var item in reachCollectValue) {
      List<String> itemList = [
        "${item[AncRegisterTable.COLUMM_TABLE]}",
        "${item[AncRegisterTable.COLUMM_Id]}",
        "${item[AncRegisterTable.COLUMM_ORG_NAME]}",
        "${item[AncRegisterTable.COLUMM_STATE_NAME]}",
        "${item[AncRegisterTable.COLUMM_TOWNSHIP_NAME]}",
        "${item[AncRegisterTable.COLUMM_TOWNSHIP_LOCAL_NAME]}",
        "${item[AncRegisterTable.COLUMM_CLINIC]}",
        "${item[AncRegisterTable.COLUMM_CHANNEL]}",
        "${item[AncRegisterTable.COLUMM_REPORTING_PERIOD]}",
        "${item[AncRegisterTable.COLUMN_NAME_Date]}",
        "${item[AncRegisterTable.COLUMN_NAME_Name]}",
        "${item[AncRegisterTable.COLUMN_NAME_Age]}",
        "${item[AncRegisterTable.COLUMN_NAME_Disability]}",
        "${item[AncRegisterTable.COLUMN_NAME_IDP]}",
        "${item[AncRegisterTable.COLUMN_NAME_Gestational]}",
        "${item[AncRegisterTable.COLUMN_NAME_Gravida]}",
        "${item[AncRegisterTable.COLUMN_NAME_Parity]}",
        "${item[AncRegisterTable.COLUMN_NAME_Td]}",
        "${item[AncRegisterTable.COLUMN_NAME_Findings]}",
        "${item[AncRegisterTable.COLUMN_NAME_Treatment]}",
        "${item[AncRegisterTable.COLUMN_NAME_ANC4]}",
        "${item[AncRegisterTable.COLUMN_NAME_Attended]}",
        "${item[AncRegisterTable.COLUMN_NAME_Outcome]}",
        "${item[AncRegisterTable.COLUMN_NAME_Remark]}",
        "${item[AncRegisterTable.COLUMN_CREATE_DATE]}",
        "${item[AncRegisterTable.COLUMN_UPDATE_DATE]}"
      ];
      ancList.add(itemList);
    }

    return ancList;
  }

  Future<List<List<String>>> getAllDeliveryForExport() async {
    final db = await database;
    List<String> headerList = [
      "TableName",
      "Sr",
      "Organization",
      "State/Region",
      "Township (MIMU)",
      "Township (Local)",
      "Clinic",
      "Channel",
      "Reporting Period",
      (DeliveryTable.COLUMN_NAME_Date),
      (DeliveryTable.COLUMN_NAME_Name),
      (DeliveryTable.COLUMN_NAME_Age),
      (DeliveryTable.COLUMN_NAME_Disability),
      (DeliveryTable.COLUMN_NAME_IDP),
      (DeliveryTable.COLUMN_NAME_Gestational),
      (DeliveryTable.COLUMN_NAME_Gravida),
      (DeliveryTable.COLUMN_NAME_TD_COMPLETE),
      (DeliveryTable.COLUMN_NAME_BIRTH_TYPE),
      (DeliveryTable.COLUMN_NAME_BIRTH_WEIGHT),
      (DeliveryTable.COLUMN_NAME_NEONATAL),
      (DeliveryTable.COLUMN_NAME_BREASTFEEDING),
      (DeliveryTable.COLUMN_NAME_Treatment),
      (DeliveryTable.COLUMN_NAME_Attended),
      (DeliveryTable.COLUMN_NAME_Outcome),
      (DeliveryTable.COLUMN_NAME_Remark),
      (DeliveryTable.COLUMN_CREATE_DATE),
      (DeliveryTable.COLUMN_UPDATE_DATE)
    ];
    List<List<String>> ancList = [headerList];
    dynamic reachCollectValue =
        await db.rawQuery("SELECT * FROM '${DeliveryTable.TABLE_NAME}';", null);

    for (var item in reachCollectValue) {
      List<String> itemList = [
        "${item[DeliveryTable.COLUMM_TABLE]}",
        "${item[DeliveryTable.COLUMM_Id]}",
        "${item[DeliveryTable.COLUMM_ORG_NAME]}",
        "${item[DeliveryTable.COLUMM_STATE_NAME]}",
        "${item[DeliveryTable.COLUMM_TOWNSHIP_NAME]}",
        "${item[DeliveryTable.COLUMM_TOWNSHIP_LOCAL_NAME]}",
        "${item[DeliveryTable.COLUMM_CLINIC]}",
        "${item[DeliveryTable.COLUMM_CHANNEL]}",
        "${item[DeliveryTable.COLUMM_REPORTING_PERIOD]}",
        "${item[DeliveryTable.COLUMN_NAME_Date]}",
        "${item[DeliveryTable.COLUMN_NAME_Name]}",
        "${item[DeliveryTable.COLUMN_NAME_Age]}",
        "${item[DeliveryTable.COLUMN_NAME_Disability]}",
        "${item[DeliveryTable.COLUMN_NAME_IDP]}",
        "${item[DeliveryTable.COLUMN_NAME_Gestational]}",
        "${item[DeliveryTable.COLUMN_NAME_Gravida]}",
        "${item[DeliveryTable.COLUMN_NAME_TD_COMPLETE]}",
        "${item[DeliveryTable.COLUMN_NAME_BIRTH_TYPE]}",
        "${item[DeliveryTable.COLUMN_NAME_BIRTH_WEIGHT]}",
        "${item[DeliveryTable.COLUMN_NAME_NEONATAL]}",
        "${item[DeliveryTable.COLUMN_NAME_BREASTFEEDING]}",
        "${item[DeliveryTable.COLUMN_NAME_Treatment]}",
        "${item[DeliveryTable.COLUMN_NAME_Attended]}",
        "${item[DeliveryTable.COLUMN_NAME_Outcome]}",
        "${item[DeliveryTable.COLUMN_NAME_Remark]}",
        "${item[DeliveryTable.COLUMN_CREATE_DATE]}",
        "${item[DeliveryTable.COLUMN_UPDATE_DATE]}"

      ];
      ancList.add(itemList);
    }

    return ancList;
  }

  Future<List<List<String>>> getAllSRHForExport() async {
    final db = await database;
    List<String> headerList = [
      "TableName",
      "Sr",
      "Organization",
      "State/Region",
      "Township (MIMU)",
      "Township (Local)",
      "Clinic",
      "Channel",
      "Reporting Period",
      (SRHTable.COLUMN_NAME_Date),
      (SRHTable.COLUMN_NAME_Name),
      (SRHTable.COLUMN_NAME_Age),
      (SRHTable.COLUMN_NAME_SEX),
      (SRHTable.COLUMN_NAME_Disability),
      (SRHTable.COLUMN_NAME_IDP),
      (SRHTable.COLUMN_NAME_SERVICE_TYPE),
      (SRHTable.COLUMN_NAME_FIRST_REACH),
      (SRHTable.COLUMN_NAME_FP_COMMODITY),
      (SRHTable.COLUMN_NAME_QUANTITY),
      (SRHTable.COLUMN_NAME_FANDP_DIAGNOSIS),
      (SRHTable.COLUMN_NAME_Treatment),
      (SRHTable.COLUMN_NAME_Attended),
      (SRHTable.COLUMN_NAME_Outcome),
      (SRHTable.COLUMN_NAME_Remark),
      (SRHTable.COLUMN_CREATE_DATE),
      (SRHTable.COLUMN_UPDATE_DATE)
    ];
    List<List<String>> ancList = [headerList];
    dynamic reachCollectValue =
        await db.rawQuery("SELECT * FROM '${SRHTable.TABLE_NAME}';", null);

    for (var item in reachCollectValue) {
      List<String> itemList = [
        "${item[SRHTable.COLUMM_TABLE]}",
        "${item[SRHTable.COLUMM_Id]}",
        "${item[SRHTable.COLUMM_ORG_NAME]}",
        "${item[SRHTable.COLUMM_STATE_NAME]}",
        "${item[SRHTable.COLUMM_TOWNSHIP_NAME]}",
        "${item[SRHTable.COLUMM_TOWNSHIP_LOCAL_NAME]}",
        "${item[SRHTable.COLUMM_CLINIC]}",
        "${item[SRHTable.COLUMM_CHANNEL]}",
        "${item[SRHTable.COLUMM_REPORTING_PERIOD]}",
        "${item[SRHTable.COLUMN_NAME_Date]}",
        "${item[SRHTable.COLUMN_NAME_Name]}",
        "${item[SRHTable.COLUMN_NAME_Age]}",
        "${item[SRHTable.COLUMN_NAME_SEX]}",
        "${item[SRHTable.COLUMN_NAME_Disability]}",
        "${item[SRHTable.COLUMN_NAME_IDP]}",
        "${item[SRHTable.COLUMN_NAME_SERVICE_TYPE]}",
        "${item[SRHTable.COLUMN_NAME_FIRST_REACH]}",
        "${item[SRHTable.COLUMN_NAME_FP_COMMODITY]}",
        "${item[SRHTable.COLUMN_NAME_QUANTITY]}",
        "${item[SRHTable.COLUMN_NAME_FANDP_DIAGNOSIS]}",
        "${item[SRHTable.COLUMN_NAME_Treatment]}",
        "${item[SRHTable.COLUMN_NAME_Attended]}",
        "${item[SRHTable.COLUMN_NAME_Outcome]}",
        "${item[SRHTable.COLUMN_NAME_Remark]}",
        "${item[SRHTable.COLUMN_CREATE_DATE]}",
        "${item[SRHTable.COLUMN_UPDATE_DATE]}"
      ];
      ancList.add(itemList);
    }

    return ancList;
  }

  //DELETE
  Future deleteANCFromDB(int id) async {
    final db = await database;
    Batch batch = db.batch();
    batch.delete(AncRegisterTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    batch.commit();
    return;
  }

  Future deleteDeliveryFromDB(int id) async {
    final db = await database;
    Batch batch = db.batch();
    batch.delete(DeliveryTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    batch.commit();
    return;
  }

  Future deleteSRHFromDB(int id) async {
    final db = await database;
    Batch batch = db.batch();
    batch.delete(SRHTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    batch.commit();
    return;
  }

  //UPDATE
  Future updateANCInto(ANCVo reachVo) async {
    final db = await database;
    Batch batch = db.batch();
    batch.update(
      AncRegisterTable.TABLE_NAME,
      reachVo.toMap(),
      where: 'id = ?',
      whereArgs: [reachVo.id],
    );
    await batch.commit();
    return;
  }

  Future updateDeliveryInto(DeliveryVo reachVo) async {
    final db = await database;
    Batch batch = db.batch();
    batch.update(
      DeliveryTable.TABLE_NAME,
      reachVo.toMap(),
      where: 'id = ?',
      whereArgs: [reachVo.id],
    );
    await batch.commit();
    return;
  }

  Future updateSRHInto(SRHVo reachVo) async {
    final db = await database;
    Batch batch = db.batch();
    batch.update(
      SRHTable.TABLE_NAME,
      reachVo.toMap(),
      where: 'id = ?',
      whereArgs: [reachVo.id],
    );
    await batch.commit();
    return;
  }
  //END RMNCH FORM


//Under5 FORM
  //INSERT
  Future insertEPIDataToDB(EPIVo epiVo, bool isImport) async {
    final db = await database;
    Batch batch = db.batch();

    var data = <String, dynamic>{
      EPITable.COLUMM_TABLE: epiVo.tableName,
      EPITable.COLUMM_ORG_NAME: epiVo.orgName,
      EPITable.COLUMM_STATE_NAME: epiVo.stateName,
      EPITable.COLUMM_TOWNSHIP_NAME: epiVo.townshipName,
      EPITable.COLUMM_TOWNSHIP_LOCAL_NAME: epiVo.townshipLocalName,
      EPITable.COLUMM_CLINIC: epiVo.clinic,
      EPITable.COLUMM_CHANNEL: epiVo.channel,
      EPITable.COLUMM_REPORTING_PERIOD: epiVo.reportingPeroid,
      EPITable.COLUMN_CHILD_NAME: epiVo.childName,
      EPITable.COLUMN_NAME_SEX: epiVo.sex,
      EPITable.COLUMN_NAME_Disabled: epiVo.disabled,
      EPITable.COLUMN_NAME_Relocation: epiVo.relocation,
      EPITable.COLUMN_NAME_Address: epiVo.address,
      EPITable.COLUMN_NAME_DOB: epiVo.dob,
      EPITable.COLUMN_NAME_BCG: epiVo.bcg,
      EPITable.COLUMN_NAME_Vaccined: epiVo.vaccined,
      EPITable.COLUMN_NAME_Refer: epiVo.refer,
      EPITable.COLUMN_NAME_ReferPlace: epiVo.referPlace,
      EPITable.COLUMN_NAME_Remark: epiVo.remark,
      EPITable.COLUMN_CREATE_DATE: epiVo.createDate,
      EPITable.COLUMN_UPDATE_DATE: epiVo.updateDate
    };

    //db.rawQuery("SELECT * FROM '${DeliveryTable.TABLE_NAME}';", null);
    if (isImport){
      var exitCount =
      await db.rawQuery("SELECT COUNT(*) AS count FROM ${EPITable.TABLE_NAME} WHERE ${EPITable.COLUMN_CREATE_DATE} = '${epiVo.createDate}' AND ${EPITable.COLUMN_UPDATE_DATE} = '${epiVo.updateDate}'");
      //inset village
      print("Exit Value :::: $exit");
      int count = exitCount.first['count'] as int;
      if (count == 0){
        batch.insert(EPITable.TABLE_NAME, data,
            conflictAlgorithm: ConflictAlgorithm.replace);

        batch.commit();
      }
    }else{
      batch.insert(EPITable.TABLE_NAME, data,
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.commit();
    }


    return;
  }

  Future insertMUACDataToDB(MUACVo muacVo, bool isImport) async {
    final db = await database;
    Batch batch = db.batch();

    var data = <String, dynamic>{
      MUACTable.COLUMM_TABLE: muacVo.tableName,
      MUACTable.COLUMM_ORG_NAME: muacVo.orgName,
      MUACTable.COLUMM_STATE_NAME: muacVo.stateName,
      MUACTable.COLUMM_TOWNSHIP_NAME: muacVo.townshipName,
      MUACTable.COLUMM_TOWNSHIP_LOCAL_NAME: muacVo.townshipLocalName,
      MUACTable.COLUMM_CLINIC: muacVo.clinic,
      MUACTable.COLUMM_VILLAGE_NAME: muacVo.villageName,
      MUACTable.COLUMM_VOLUNTEER_NAME: muacVo.volunteerName,
      MUACTable.COLUMN_NAME_Date: muacVo.date,
      MUACTable.COLUMN_NAMEE: muacVo.name,
      MUACTable.COLUMN_AGE: muacVo.age,
      MUACTable.COLUMN_NAME_SEX: muacVo.sex,
      MUACTable.COLUMN_NAME_Disabled: muacVo.disabled,
      MUACTable.COLUMN_NAME_Relocation: muacVo.relocation,
      MUACTable.COLUMN_NAME_Phone: muacVo.phone,
      MUACTable.COLUMN_NAME_Armsize: muacVo.armSize,
      MUACTable.COLUMN_NAME_Weight: muacVo.weight,
      MUACTable.COLUMN_NAME_Swelling: muacVo.swelling,
      MUACTable.COLUMN_NAME_Refer: muacVo.refer,
      MUACTable.COLUMN_NAME_ReferPlace: muacVo.referPlace,
      MUACTable.COLUMN_NAME_ReferGo: muacVo.referGo,
      MUACTable.COLUMN_NAME_Remark: muacVo.remark,
      MUACTable.COLUMN_CREATE_DATE: muacVo.createDate,
      MUACTable.COLUMN_UPDATE_DATE: muacVo.updateDate
    };
    //inset village

    if (isImport){
      var exitCount =
      await db.rawQuery("SELECT COUNT(*) AS count FROM ${MUACTable.TABLE_NAME} WHERE ${MUACTable.COLUMN_CREATE_DATE} = '${muacVo.createDate}' AND ${MUACTable.COLUMN_UPDATE_DATE} = '${muacVo.updateDate}'");
      //inset village
      print("Exit Value :::: $exit");
      int count = exitCount.first['count'] as int;
      if (count == 0){
        batch.insert(MUACTable.TABLE_NAME, data,
            conflictAlgorithm: ConflictAlgorithm.abort);

        batch.commit();
      }
    }else{
      batch.insert(MUACTable.TABLE_NAME, data,
          conflictAlgorithm: ConflictAlgorithm.abort);

      batch.commit();
    }

    return;
  }

  Future insertPNUDataToDB(PNUVo pnuVo, bool isImport) async {
    final db = await database;
    Batch batch = db.batch();

    var data = <String, dynamic>{
      PNUTable.COLUMM_TABLE: pnuVo.tableName,
      PNUTable.COLUMM_ORG_NAME: pnuVo.orgName,
      PNUTable.COLUMM_STATE_NAME: pnuVo.stateName,
      PNUTable.COLUMM_TOWNSHIP_NAME: pnuVo.townshipName,
      PNUTable.COLUMM_TOWNSHIP_LOCAL_NAME: pnuVo.townshipLocalName,
      PNUTable.COLUMM_CLINIC: pnuVo.clinic,
      PNUTable.COLUMM_VILLAGE_NAME: pnuVo.villageName,
      PNUTable.COLUMM_VOLUNTEER_NAME: pnuVo.volunteerName,
      PNUTable.COLUMM_REPORTING_PERIOD: pnuVo.reportingPeroid,
      PNUTable.COLUMN_NAME_Date: pnuVo.date,
      PNUTable.COLUMN_NAME: pnuVo.name,
      PNUTable.COLUMN_AGE: pnuVo.age,
      PNUTable.COLUMN_NAME_SEX: pnuVo.sex,
      PNUTable.COLUMN_NAME_Disabled: pnuVo.disabled,
      PNUTable.COLUMN_NAME_Relocation: pnuVo.relocation,
      PNUTable.COLUMN_NAME_KOFPatient: pnuVo.kofPatient,
      PNUTable.COLUMN_NAME_SymptomsList: pnuVo.symptomsList,
      PNUTable.COLUMN_NAME_DiseaseList: pnuVo.diseaseList,
      PNUTable.COLUMN_NAME_Treatment: pnuVo.treatment,
      PNUTable.COLUMN_NAME_TreatmentPeriod: pnuVo.treatmentPeriod,
      PNUTable.COLUMN_NAME_Refer: pnuVo.refer,
      PNUTable.COLUMN_NAME_ReferPlace: pnuVo.referPlace,
      PNUTable.COLUMN_NAME_ReferGo: pnuVo.referGo,
      PNUTable.COLUMN_NAME_Remark: pnuVo.remark,
      PNUTable.COLUMN_CREATE_DATE: pnuVo.createDate,
      PNUTable.COLUMN_UPDATE_DATE: pnuVo.updateDate
    };

    if (isImport){
      var exitCount =
      await db.rawQuery("SELECT COUNT(*) AS count FROM ${PNUTable.TABLE_NAME} WHERE ${PNUTable.COLUMN_CREATE_DATE} = '${pnuVo.createDate}' AND ${PNUTable.COLUMN_UPDATE_DATE} = '${pnuVo.updateDate}'");
      //inset village
      print("Exit Value :::: $exit");
      int count = exitCount.first['count'] as int;
      if (count == 0){
        batch.insert(PNUTable.TABLE_NAME, data,
            conflictAlgorithm: ConflictAlgorithm.abort);

        batch.commit();
      }
    }else{
      batch.insert(PNUTable.TABLE_NAME, data,
          conflictAlgorithm: ConflictAlgorithm.abort);

      batch.commit();
    }
    //inset village

    return;
  }


  //SELECT
  Future<List<EPIVo>> getAllEPIDataFromDB() async {
    final db = await database;
    List<EPIVo> epiData = [];
    dynamic epiValue = await db.rawQuery(
        "SELECT * FROM '${EPITable.TABLE_NAME}';", null);

    for (var epi in epiValue) {
      EPIVo epiVo = EPIVo();
      epiVo.id = epi[EPITable.COLUMM_Id];
      epiVo.orgName = epi[EPITable.COLUMM_ORG_NAME];
      epiVo.stateName = epi[EPITable.COLUMM_STATE_NAME];
      epiVo.townshipName = epi[EPITable.COLUMM_TOWNSHIP_NAME];
      epiVo.townshipLocalName = epi[EPITable.COLUMM_TOWNSHIP_LOCAL_NAME];
      epiVo.clinic = epi[EPITable.COLUMM_CLINIC];
      epiVo.channel = epi[EPITable.COLUMM_CHANNEL];
      epiVo.reportingPeroid = epi[EPITable.COLUMM_REPORTING_PERIOD];
      epiVo.childName = epi[EPITable.COLUMN_CHILD_NAME];
      epiVo.sex = epi[EPITable.COLUMN_NAME_SEX];
      epiVo.disabled = epi[EPITable.COLUMN_NAME_Disabled];
      epiVo.relocation = epi[EPITable.COLUMN_NAME_Relocation];
      epiVo.address = epi[EPITable.COLUMN_NAME_Address];
      epiVo.dob = epi[EPITable.COLUMN_NAME_DOB];
      epiVo.bcg = epi[EPITable.COLUMN_NAME_BCG];
      epiVo.vaccined = epi[EPITable.COLUMN_NAME_Vaccined];
      epiVo.refer = epi[EPITable.COLUMN_NAME_Refer];
      epiVo.referPlace = epi[EPITable.COLUMN_NAME_ReferPlace];
      epiVo.remark = epi[EPITable.COLUMN_NAME_Remark];
      epiVo.createDate = epi[EPITable.COLUMN_CREATE_DATE];
      epiVo.updateDate = epi[EPITable.COLUMN_UPDATE_DATE];
      epiData.add(epiVo);
    }
    return epiData;
  }

  Future<List<MUACVo>> getAllMUACDataFromDB() async {
    final db = await database;
    List<MUACVo> muacData = [];
    dynamic muacValue =
    await db.rawQuery("SELECT * FROM '${MUACTable.TABLE_NAME}';", null);

    for (var muac in muacValue) {
      MUACVo muacVo = MUACVo();
      muacVo.id = muac[MUACTable.COLUMM_Id];
      muacVo.orgName = muac[MUACTable.COLUMM_ORG_NAME];
      muacVo.stateName = muac[MUACTable.COLUMM_STATE_NAME];
      muacVo.townshipName = muac[MUACTable.COLUMM_TOWNSHIP_NAME];
      muacVo.townshipLocalName = muac[MUACTable.COLUMM_TOWNSHIP_LOCAL_NAME];
      muacVo.clinic = muac[MUACTable.COLUMM_CLINIC];
      muacVo.villageName = muac[MUACTable.COLUMM_VILLAGE_NAME];
      muacVo.volunteerName = muac[MUACTable.COLUMM_VOLUNTEER_NAME];
      muacVo.date = muac[MUACTable.COLUMN_NAME_Date];
      muacVo.name = muac[MUACTable.COLUMN_NAMEE];
      muacVo.age = muac[MUACTable.COLUMN_AGE];
      muacVo.sex = muac[MUACTable.COLUMN_NAME_SEX];
      muacVo.disabled = muac[MUACTable.COLUMN_NAME_Disabled];
      muacVo.relocation = muac[MUACTable.COLUMN_NAME_Relocation];
      muacVo.phone = muac[MUACTable.COLUMN_NAME_Phone];
      muacVo.armSize = muac[MUACTable.COLUMN_NAME_Armsize];
      muacVo.weight = muac[MUACTable.COLUMN_NAME_Weight];
      muacVo.swelling = muac[MUACTable.COLUMN_NAME_Swelling];
      muacVo.refer = muac[MUACTable.COLUMN_NAME_Refer];
      muacVo.referPlace = muac[MUACTable.COLUMN_NAME_ReferPlace];
      muacVo.referGo = muac[MUACTable.COLUMN_NAME_ReferGo];
      muacVo.remark = muac[MUACTable.COLUMN_NAME_Remark];
      muacVo.createDate = muac[MUACTable.COLUMN_CREATE_DATE];
      muacVo.updateDate = muac[MUACTable.COLUMN_UPDATE_DATE];
      muacData.add(muacVo);
    }
    return muacData;
  }

  Future<List<PNUVo>> getAllPNUDataFromDB() async {
    final db = await database;
    List<PNUVo> pnuData = [];
    dynamic pnuValue =
    await db.rawQuery("SELECT * FROM '${PNUTable.TABLE_NAME}';", null);

    for (var muac in pnuValue) {
      PNUVo muacVo = PNUVo();
      muacVo.id = muac[PNUTable.COLUMM_Id];
      muacVo.orgName = muac[PNUTable.COLUMM_ORG_NAME];
      muacVo.stateName = muac[PNUTable.COLUMM_STATE_NAME];
      muacVo.townshipName = muac[PNUTable.COLUMM_TOWNSHIP_NAME];
      muacVo.townshipLocalName = muac[PNUTable.COLUMM_TOWNSHIP_LOCAL_NAME];
      muacVo.clinic = muac[PNUTable.COLUMM_CLINIC];
      muacVo.villageName = muac[PNUTable.COLUMM_VILLAGE_NAME];
      muacVo.volunteerName = muac[PNUTable.COLUMM_VOLUNTEER_NAME];
      muacVo.reportingPeroid = muac[PNUTable.COLUMM_REPORTING_PERIOD];
      muacVo.date = muac[PNUTable.COLUMN_NAME_Date];
      muacVo.name = muac[PNUTable.COLUMN_NAME];
      muacVo.age = muac[PNUTable.COLUMN_AGE];
      muacVo.sex = muac[PNUTable.COLUMN_NAME_SEX];
      muacVo.disabled = muac[PNUTable.COLUMN_NAME_Disabled];
      muacVo.relocation = muac[PNUTable.COLUMN_NAME_Relocation];
      muacVo.kofPatient = muac[PNUTable.COLUMN_NAME_KOFPatient];
      muacVo.symptomsList = muac[PNUTable.COLUMN_NAME_SymptomsList];
      muacVo.diseaseList = muac[PNUTable.COLUMN_NAME_DiseaseList];
      muacVo.treatment = muac[PNUTable.COLUMN_NAME_Treatment];
      muacVo.treatmentPeriod = muac[PNUTable.COLUMN_NAME_TreatmentPeriod];
      muacVo.refer = muac[PNUTable.COLUMN_NAME_Refer];
      muacVo.referPlace = muac[PNUTable.COLUMN_NAME_ReferPlace];
      muacVo.referGo = muac[PNUTable.COLUMN_NAME_ReferGo];
      muacVo.remark = muac[PNUTable.COLUMN_NAME_Remark];
      muacVo.createDate = muac[PNUTable.COLUMN_CREATE_DATE];
      muacVo.updateDate = muac[PNUTable.COLUMN_UPDATE_DATE];
      pnuData.add(muacVo);
    }
    return pnuData;
  }

  Future<List<List<String>>> getAllEPIForExport() async {
    final db = await database;
    List<String> headerList = [
      "TableName",
      "Sr",
      "Organization",
      "State/Region",
      "Township (MIMU)",
      "Township (Local)",
      "Clinic",
      "Channel",
      "Reporting Period",
      (EPITable.COLUMN_CHILD_NAME),
      (EPITable.COLUMN_NAME_SEX),
      (EPITable.COLUMN_NAME_Disabled),
      (EPITable.COLUMN_NAME_Relocation),
      (EPITable.COLUMN_NAME_Address),
      (EPITable.COLUMN_NAME_DOB),
      (EPITable.COLUMN_NAME_BCG),
      (EPITable.COLUMN_NAME_Vaccined),
      (EPITable.COLUMN_NAME_Refer),
      (EPITable.COLUMN_NAME_ReferPlace),
      (EPITable.COLUMN_NAME_Remark),
      (EPITable.COLUMN_CREATE_DATE),
      (EPITable.COLUMN_UPDATE_DATE)
    ];
    List<List<String>> ancList = [headerList];
    dynamic reachCollectValue = await db.rawQuery(
        "SELECT * FROM '${EPITable.TABLE_NAME}';", null);

    for (var item in reachCollectValue) {
      List<String> itemList = [
        "${item[EPITable.COLUMM_TABLE]}",
        "${item[EPITable.COLUMM_Id]}",
        "${item[EPITable.COLUMM_ORG_NAME]}",
        "${item[EPITable.COLUMM_STATE_NAME]}",
        "${item[EPITable.COLUMM_TOWNSHIP_NAME]}",
        "${item[EPITable.COLUMM_TOWNSHIP_LOCAL_NAME]}",
        "${item[EPITable.COLUMM_CLINIC]}",
        "${item[EPITable.COLUMM_CHANNEL]}",
        "${item[EPITable.COLUMM_REPORTING_PERIOD]}",
        "${item[EPITable.COLUMN_CHILD_NAME]}",
        "${item[EPITable.COLUMN_NAME_SEX]}",
        "${item[EPITable.COLUMN_NAME_Disabled]}",
        "${item[EPITable.COLUMN_NAME_Relocation]}",
        "${item[EPITable.COLUMN_NAME_Address]}",
        "${item[EPITable.COLUMN_NAME_DOB]}",
        "${item[EPITable.COLUMN_NAME_BCG]}",
        "${item[EPITable.COLUMN_NAME_Vaccined]}",
        "${item[EPITable.COLUMN_NAME_Refer]}",
        "${item[EPITable.COLUMN_NAME_ReferPlace]}",
        "${item[EPITable.COLUMN_NAME_Remark]}",
        "${item[EPITable.COLUMN_CREATE_DATE]}",
        "${item[EPITable.COLUMN_UPDATE_DATE]}"
      ];
      ancList.add(itemList);
    }

    return ancList;
  }

  Future<List<List<String>>> getAllMUACyForExport() async {
    final db = await database;
    List<String> headerList = [
      "TableName",
      "Sr",
      "Organization",
      "State/Region",
      "Township (MIMU)",
      "Township (Local)",
      "Clinic",
      (MUACTable.COLUMM_VILLAGE_NAME),
      (MUACTable.COLUMM_VOLUNTEER_NAME),
      (MUACTable.COLUMN_NAME_Date),
      (MUACTable.COLUMN_NAMEE),
      (MUACTable.COLUMN_AGE),
      (MUACTable.COLUMN_NAME_SEX),
      (MUACTable.COLUMN_NAME_Disabled),
      (MUACTable.COLUMN_NAME_Relocation),
      (MUACTable.COLUMN_NAME_Phone),
      (MUACTable.COLUMN_NAME_Armsize),
      (MUACTable.COLUMN_NAME_Weight),
      (MUACTable.COLUMN_NAME_Swelling),
      (MUACTable.COLUMN_NAME_Refer),
      (MUACTable.COLUMN_NAME_ReferPlace),
      (MUACTable.COLUMN_NAME_ReferGo),
      (MUACTable.COLUMN_NAME_Remark),
      (MUACTable.COLUMN_CREATE_DATE),
      (MUACTable.COLUMN_UPDATE_DATE)
    ];
    List<List<String>> ancList = [headerList];
    dynamic reachCollectValue =
    await db.rawQuery("SELECT * FROM '${MUACTable.TABLE_NAME}';", null);

    for (var item in reachCollectValue) {
      List<String> itemList = [
        "${item[MUACTable.COLUMM_TABLE]}",
        "${item[MUACTable.COLUMM_Id]}",
        "${item[MUACTable.COLUMM_ORG_NAME]}",
        "${item[MUACTable.COLUMM_STATE_NAME]}",
        "${item[MUACTable.COLUMM_TOWNSHIP_NAME]}",
        "${item[MUACTable.COLUMM_TOWNSHIP_LOCAL_NAME]}",
        "${item[MUACTable.COLUMM_CLINIC]}",
        "${item[MUACTable.COLUMM_VILLAGE_NAME]}",
        "${item[MUACTable.COLUMM_VOLUNTEER_NAME]}",
        "${item[MUACTable.COLUMN_NAME_Date]}",
        "${item[MUACTable.COLUMN_NAMEE]}",
        "${item[MUACTable.COLUMN_AGE]}",
        "${item[MUACTable.COLUMN_NAME_SEX]}",
        "${item[MUACTable.COLUMN_NAME_Disabled]}",
        "${item[MUACTable.COLUMN_NAME_Relocation]}",
        "${item[MUACTable.COLUMN_NAME_Phone]}",
        "${item[MUACTable.COLUMN_NAME_Armsize]}",
        "${item[MUACTable.COLUMN_NAME_Weight]}",
        "${item[MUACTable.COLUMN_NAME_Swelling]}",
        "${item[MUACTable.COLUMN_NAME_Refer]}",
        "${item[MUACTable.COLUMN_NAME_ReferPlace]}",
        "${item[MUACTable.COLUMN_NAME_ReferGo]}",
        "${item[MUACTable.COLUMN_NAME_Remark]}",
        "${item[MUACTable.COLUMN_CREATE_DATE]}",
        "${item[MUACTable.COLUMN_UPDATE_DATE]}"

      ];
      ancList.add(itemList);
    }

    return ancList;
  }

  Future<List<List<String>>> getAllPNUForExport() async {
    final db = await database;
    List<String> headerList = [
      "TableName",
      "Sr",
      "Organization",
      "State/Region",
      "Township (MIMU)",
      "Township (Local)",
      "Clinic",
      (PNUTable.COLUMM_VILLAGE_NAME),
      (PNUTable.COLUMM_VOLUNTEER_NAME),
      (PNUTable.COLUMM_REPORTING_PERIOD),
      (PNUTable.COLUMN_NAME_Date),
      (PNUTable.COLUMN_NAME),
      (PNUTable.COLUMN_AGE),
      (PNUTable.COLUMN_NAME_SEX),
      (PNUTable.COLUMN_NAME_Disabled),
      (PNUTable.COLUMN_NAME_Relocation),
      (PNUTable.COLUMN_NAME_KOFPatient),
      (PNUTable.COLUMN_NAME_SymptomsList),
      (PNUTable.COLUMN_NAME_DiseaseList),
      (PNUTable.COLUMN_NAME_Treatment),
      (PNUTable.COLUMN_NAME_TreatmentPeriod),
      (PNUTable.COLUMN_NAME_Refer),
      (PNUTable.COLUMN_NAME_ReferPlace),
      (PNUTable.COLUMN_NAME_ReferGo),
      (PNUTable.COLUMN_NAME_Remark),
      (PNUTable.COLUMN_CREATE_DATE),
      (PNUTable.COLUMN_UPDATE_DATE)
    ];
    List<List<String>> ancList = [headerList];
    dynamic reachCollectValue =
    await db.rawQuery("SELECT * FROM '${PNUTable.TABLE_NAME}';", null);

    for (var item in reachCollectValue) {
      List<String> itemList = [
        "${item[PNUTable.COLUMM_TABLE]}",
        "${item[PNUTable.COLUMM_Id]}",
        "${item[PNUTable.COLUMM_ORG_NAME]}",
        "${item[PNUTable.COLUMM_STATE_NAME]}",
        "${item[PNUTable.COLUMM_TOWNSHIP_NAME]}",
        "${item[PNUTable.COLUMM_TOWNSHIP_LOCAL_NAME]}",
        "${item[PNUTable.COLUMM_CLINIC]}",
        "${item[PNUTable.COLUMM_VILLAGE_NAME]}",
        "${item[PNUTable.COLUMM_VOLUNTEER_NAME]}",
        "${item[PNUTable.COLUMM_REPORTING_PERIOD]}",
        "${item[PNUTable.COLUMN_NAME_Date]}",
        "${item[PNUTable.COLUMN_NAME]}",
        "${item[PNUTable.COLUMN_AGE]}",
        "${item[PNUTable.COLUMN_NAME_SEX]}",
        "${item[PNUTable.COLUMN_NAME_Disabled]}",
        "${item[PNUTable.COLUMN_NAME_Relocation]}",
        "${item[PNUTable.COLUMN_NAME_KOFPatient]}",
        "${item[PNUTable.COLUMN_NAME_SymptomsList]}",
        "${item[PNUTable.COLUMN_NAME_DiseaseList]}",
        "${item[PNUTable.COLUMN_NAME_Treatment]}",
        "${item[PNUTable.COLUMN_NAME_TreatmentPeriod]}",
        "${item[PNUTable.COLUMN_NAME_Refer]}",
        "${item[PNUTable.COLUMN_NAME_ReferPlace]}",
        "${item[PNUTable.COLUMN_NAME_ReferGo]}",
        "${item[PNUTable.COLUMN_NAME_Remark]}",
        "${item[PNUTable.COLUMN_CREATE_DATE]}",
        "${item[PNUTable.COLUMN_UPDATE_DATE]}"

      ];
      ancList.add(itemList);
    }

    return ancList;
  }

  //DELETE
  Future deleteEPIFromDB(int id) async {
    final db = await database;
    Batch batch = db.batch();
    batch.delete(EPITable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    batch.commit();
    return;
  }

  Future deleteMUACFromDB(int id) async {
    final db = await database;
    Batch batch = db.batch();
    batch.delete(MUACTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    batch.commit();
    return;
  }

  Future deletePNUFromDB(int id) async {
    final db = await database;
    Batch batch = db.batch();
    batch.delete(PNUTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    batch.commit();
    return;
  }

  //UPDATE
  Future updateEPIInto(EPIVo reachVo) async {
    final db = await database;
    Batch batch = db.batch();
    batch.update(
      EPITable.TABLE_NAME,
      reachVo.toMap(),
      where: 'id = ?',
      whereArgs: [reachVo.id],
    );
    await batch.commit();
    return;
  }

  Future updateMUACInto(MUACVo reachVo) async {
    final db = await database;
    Batch batch = db.batch();
    batch.update(
      MUACTable.TABLE_NAME,
      reachVo.toMap(),
      where: 'id = ?',
      whereArgs: [reachVo.id],
    );
    await batch.commit();
    return;
  }

  Future updatePNUInto(PNUVo reachVo) async {
    final db = await database;
    Batch batch = db.batch();
    batch.update(
      PNUTable.TABLE_NAME,
      reachVo.toMap(),
      where: 'id = ?',
      whereArgs: [reachVo.id],
    );
    await batch.commit();
    return;
  }
//END RMNCH FORM

//SUMMARY FORM
  //INSERT
  Future insertConsultationDataToDB(ConsultationVo consultationVo, bool isImport) async {
    final db = await database;
    Batch batch = db.batch();

    var data = <String, dynamic>{
      ConsultationTable.COLUMM_TABLE: consultationVo.tableName,
      ConsultationTable.COLUMM_ORG_NAME: consultationVo.orgName,
      ConsultationTable.COLUMM_STATE_NAME: consultationVo.stateName,
      ConsultationTable.COLUMM_TOWNSHIP_NAME: consultationVo.townshipName,
      ConsultationTable.COLUMM_TOWNSHIP_LOCAL_NAME: consultationVo.townshipLocalName,
      ConsultationTable.COLUMM_CLINIC: consultationVo.clinic,
      ConsultationTable.COLUMM_CHANNEL: consultationVo.channel,
      ConsultationTable.COLUMM_REPORTING_PERIOD: consultationVo.reportingPeroid,
      ConsultationTable.COLUMN_NAME_Date: consultationVo.date,
      ConsultationTable.COLUMN_NAME_Trauma: consultationVo.trauma,
      ConsultationTable.COLUMN_NAME_Other_Consultations: consultationVo.consultations,
      ConsultationTable.COLUMN_NAME_U5_Pneumonia: consultationVo.pneumonia,
      ConsultationTable.COLUMN_NAME_U5_Diarrhoea: consultationVo.diarrhoea,
      ConsultationTable.COLUMN_NAME_IDP: consultationVo.iDP,
      ConsultationTable.COLUMN_NAME_Disability: consultationVo.disability,
      ConsultationTable.COLUMN_NAME_Remark: consultationVo.remark,
      ConsultationTable.COLUMN_CREATE_DATE: consultationVo.createDate,
      ConsultationTable.COLUMN_UPDATE_DATE: consultationVo.updateDate,
    };

    //db.rawQuery("SELECT * FROM '${DeliveryTable.TABLE_NAME}';", null);
    if (isImport){
      var exitCount =
      await db.rawQuery("SELECT COUNT(*) AS count FROM ${ConsultationTable.TABLE_NAME} WHERE ${ConsultationTable.COLUMN_CREATE_DATE} = '${consultationVo.createDate}' AND ${ConsultationTable.COLUMN_UPDATE_DATE} = '${consultationVo.updateDate}'");
      //inset village
      print("Exit Value :::: $exit");
      int count = exitCount.first['count'] as int;
      if (count == 0){
        batch.insert(ConsultationTable.TABLE_NAME, data,
            conflictAlgorithm: ConflictAlgorithm.replace);

        batch.commit();
      }
    }else{
      batch.insert(ConsultationTable.TABLE_NAME, data,
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.commit();
    }


    return;
  }

  Future insertDistributionDataToDB(DistributionVo distributionVo, bool isImport) async {
    final db = await database;
    Batch batch = db.batch();

    var data = <String, dynamic>{
      DistributionTable.COLUMM_TABLE: distributionVo.tableName,
      DistributionTable.COLUMM_ORG_NAME: distributionVo.orgName,
      DistributionTable.COLUMM_STATE_NAME: distributionVo.stateName,
      DistributionTable.COLUMM_TOWNSHIP_NAME: distributionVo.townshipName,
      DistributionTable.COLUMM_TOWNSHIP_LOCAL_NAME: distributionVo.townshipLocalName,
      DistributionTable.COLUMM_CLINIC: distributionVo.clinic,
      DistributionTable.COLUMM_REPORTING_PERIOD: distributionVo.reportingPeroid,
      DistributionTable.COLUMN_NAME_Date: distributionVo.date,
      DistributionTable.COLUMN_NAME_Distribution_Type: distributionVo.distribution,
      DistributionTable.COLUMN_NAME_Beneficiary_Type: distributionVo.beneficiary,
      DistributionTable.COLUMN_NAME_Item1: distributionVo.item1,
      DistributionTable.COLUMN_NAME_Item2: distributionVo.item2,
      DistributionTable.COLUMN_NAME_Item3: distributionVo.item3,
      DistributionTable.COLUMN_NAME_Household: distributionVo.household,
      DistributionTable.COLUMN_NAME_Under18: distributionVo.under18,
      DistributionTable.COLUMN_NAME_Over18: distributionVo.over18,
      DistributionTable.COLUMN_NAME_IDP: distributionVo.iDP,
      DistributionTable.COLUMN_NAME_Disability: distributionVo.disability,
      DistributionTable.COLUMN_NAME_Remark: distributionVo.remark,
      DistributionTable.COLUMN_CREATE_DATE: distributionVo.createDate,
      DistributionTable.COLUMN_UPDATE_DATE: distributionVo.updateDate,
    };
    //inset village

    if (isImport){
      var exitCount =
      await db.rawQuery("SELECT COUNT(*) AS count FROM ${DistributionTable.TABLE_NAME} WHERE ${DistributionTable.COLUMN_CREATE_DATE} = '${distributionVo.createDate}' AND ${DistributionTable.COLUMN_UPDATE_DATE} = '${distributionVo.updateDate}'");
      //inset village
      print("Exit Value :::: $exit");
      int count = exitCount.first['count'] as int;
      if (count == 0){
        batch.insert(DistributionTable.TABLE_NAME, data,
            conflictAlgorithm: ConflictAlgorithm.abort);

        batch.commit();
      }
    }else{
      batch.insert(DistributionTable.TABLE_NAME, data,
          conflictAlgorithm: ConflictAlgorithm.abort);

      batch.commit();
    }

    return;
  }

  Future insertHEDataToDB(HEVo heVo, bool isImport) async {
    final db = await database;
    Batch batch = db.batch();
    var data = <String, dynamic>{
      HETable.COLUMM_TABLE: heVo.tableName,
      HETable.COLUMM_ORG_NAME: heVo.orgName,
      HETable.COLUMM_STATE_NAME: heVo.stateName,
      HETable.COLUMM_TOWNSHIP_NAME: heVo.townshipName,
      HETable.COLUMM_TOWNSHIP_LOCAL_NAME: heVo.townshipLocalName,
      HETable.COLUMM_Village_Name: heVo.villageName,
      HETable.COLUMM_NAME_Topic: heVo.topic,
      HETable.COLUMN_NAME_Date: heVo.date,
      HETable.COLUMN_NAME_Presenter_Name: heVo.presenterName,
      HETable.COLUMN_NAME_Position: heVo.position,
      HETable.COLUMN_NAME_Attended_Name: heVo.attendedName,
      HETable.COLUMN_NAME_Age: heVo.age,
      HETable.COLUMN_NAME_Gender: heVo.gender,
      HETable.COLUMN_NAME_Disability: heVo.disability,
      HETable.COLUMN_NAME_Relocation: heVo.relocation,
      HETable.COLUMN_NAME_IS_New: heVo.isNew,
      HETable.COLUMN_NAME_Remark: heVo.remark,
      HETable.COLUMN_CREATE_DATE: heVo.createDate,
      HETable.COLUMN_UPDATE_DATE: heVo.updateDate,
    };

    if (isImport){
      var exitCount =
      await db.rawQuery("SELECT COUNT(*) AS count FROM ${HETable.TABLE_NAME} WHERE ${HETable.COLUMN_CREATE_DATE} = '${heVo.createDate}' AND ${HETable.COLUMN_UPDATE_DATE} = '${heVo.updateDate}'");
      //inset village
      print("Exit Value :::: $exit");
      int count = exitCount.first['count'] as int;
      if (count == 0){
        batch.insert(HETable.TABLE_NAME, data,
            conflictAlgorithm: ConflictAlgorithm.abort);

        batch.commit();
      }
    }else{
      batch.insert(HETable.TABLE_NAME, data,
          conflictAlgorithm: ConflictAlgorithm.abort);

      batch.commit();
    }
    //inset village

    return;
  }

  Future insertReferralDataToDB(ReferalVo referalVo, bool isImport) async {
    final db = await database;
    Batch batch = db.batch();

    var data = <String, dynamic>{
      ReferralTable.COLUMM_TABLE: referalVo.tableName,
      ReferralTable.COLUMM_ORG_NAME: referalVo.orgName,
      ReferralTable.COLUMM_STATE_NAME: referalVo.stateName,
      ReferralTable.COLUMM_TOWNSHIP_NAME: referalVo.townshipName,
      ReferralTable.COLUMM_TOWNSHIP_LOCAL_NAME: referalVo.townshipLocalName,
      ReferralTable.COLUMM_CLINIC: referalVo.clinic,
      ReferralTable.COLUMM_Village_Name: referalVo.villageName,
      ReferralTable.COLUMN_NAME_Date: referalVo.date,
      ReferralTable.COLUMN_NAME_Name: referalVo.name,
      ReferralTable.COLUMN_NAME_Age: referalVo.age,
      ReferralTable.COLUMN_NAME_Gender: referalVo.gender,
      ReferralTable.COLUMN_NAME_Disability: referalVo.disability,
      ReferralTable.COLUMN_NAME_Relocation: referalVo.relocation,
      ReferralTable.COLUMN_NAME_Referral_Type: referalVo.referralType,
      ReferralTable.COLUMN_NAME_Referral_Case: referalVo.referralCase,
      ReferralTable.COLUMN_NAME_Referral_Place: referalVo.referralPlace,
      ReferralTable.COLUMN_NAME_Referral_Cost: referalVo.referralCost,
      ReferralTable.COLUMN_NAME_Referral_Staff_Name: referalVo.referralStaffName,
      ReferralTable.COLUMN_NAME_Remark: referalVo.remark,
      ReferralTable.COLUMN_CREATE_DATE: referalVo.createDate,
      ReferralTable.COLUMN_UPDATE_DATE: referalVo.updateDate,
    };

    if (isImport){
      var exitCount =
      await db.rawQuery("SELECT COUNT(*) AS count FROM ${ReferralTable.TABLE_NAME} WHERE ${ReferralTable.COLUMN_CREATE_DATE} = '${referalVo.createDate}' AND ${ReferralTable.COLUMN_UPDATE_DATE} = '${referalVo.updateDate}'");
      //inset village
      print("Exit Value :::: $exit");
      int count = exitCount.first['count'] as int;
      if (count == 0){
        batch.insert(ReferralTable.TABLE_NAME, data,
            conflictAlgorithm: ConflictAlgorithm.abort);

        batch.commit();
      }
    }else{
      batch.insert(ReferralTable.TABLE_NAME, data,
          conflictAlgorithm: ConflictAlgorithm.abort);

      batch.commit();
    }
    //inset village

    return;
  }


  //SELECT
  Future<List<ConsultationVo>> getAllConsultationDataTFromDB() async {
    final db = await database;
    List<ConsultationVo> consultationData = [];
    dynamic epiValue = await db.rawQuery(
        "SELECT * FROM '${ConsultationTable.TABLE_NAME}';", null);

    for (var epi in epiValue) {
      ConsultationVo consultationVo = ConsultationVo();
      consultationVo.id = epi[ConsultationTable.COLUMM_Id];
      consultationVo.orgName = epi[ConsultationTable.COLUMM_ORG_NAME];
      consultationVo.stateName = epi[ConsultationTable.COLUMM_STATE_NAME];
      consultationVo.townshipName = epi[ConsultationTable.COLUMM_TOWNSHIP_NAME];
      consultationVo.townshipLocalName = epi[ConsultationTable.COLUMM_TOWNSHIP_LOCAL_NAME];
      consultationVo.clinic = epi[ConsultationTable.COLUMM_CLINIC];
      consultationVo.channel = epi[ConsultationTable.COLUMM_CHANNEL];
      consultationVo.reportingPeroid = epi[ConsultationTable.COLUMM_REPORTING_PERIOD];
      consultationVo.date = epi[ConsultationTable.COLUMN_NAME_Date];
      consultationVo.trauma = epi[ConsultationTable.COLUMN_NAME_Trauma];
      consultationVo.consultations = epi[ConsultationTable.COLUMN_NAME_Other_Consultations];
      consultationVo.pneumonia = epi[ConsultationTable.COLUMN_NAME_U5_Pneumonia];
      consultationVo.diarrhoea = epi[ConsultationTable.COLUMN_NAME_U5_Diarrhoea];
      consultationVo.iDP = epi[ConsultationTable.COLUMN_NAME_IDP];
      consultationVo.disability = epi[ConsultationTable.COLUMN_NAME_Disability];
      consultationVo.remark = epi[ConsultationTable.COLUMN_NAME_Remark];
      consultationVo.createDate = epi[ConsultationTable.COLUMN_CREATE_DATE];
      consultationVo.updateDate = epi[ConsultationTable.COLUMN_UPDATE_DATE];
      consultationData.add(consultationVo);
    }
    return consultationData;
  }

  Future<List<DistributionVo>> getAllDistributionDataFromDB() async {
    final db = await database;
    List<DistributionVo> muacData = [];
    dynamic muacValue =
    await db.rawQuery("SELECT * FROM '${DistributionTable.TABLE_NAME}';", null);

    for (var muac in muacValue) {
      DistributionVo distributionVo = DistributionVo();
      distributionVo.id = muac[DistributionTable.COLUMM_Id];
      distributionVo.orgName = muac[DistributionTable.COLUMM_ORG_NAME];
      distributionVo.stateName = muac[DistributionTable.COLUMM_STATE_NAME];
      distributionVo.townshipName = muac[DistributionTable.COLUMM_TOWNSHIP_NAME];
      distributionVo.townshipLocalName = muac[DistributionTable.COLUMM_TOWNSHIP_LOCAL_NAME];
      distributionVo.clinic = muac[DistributionTable.COLUMM_CLINIC];
      distributionVo.reportingPeroid = muac[DistributionTable.COLUMM_REPORTING_PERIOD];
      distributionVo.date = muac[DistributionTable.COLUMN_NAME_Date];
      distributionVo.distribution = muac[DistributionTable.COLUMN_NAME_Distribution_Type];
      distributionVo.beneficiary = muac[DistributionTable.COLUMN_NAME_Beneficiary_Type];
      distributionVo.item1 = muac[DistributionTable.COLUMN_NAME_Item1];
      distributionVo.item2 = muac[DistributionTable.COLUMN_NAME_Item2];
      distributionVo.item3 = muac[DistributionTable.COLUMN_NAME_Item3];
      distributionVo.household = muac[DistributionTable.COLUMN_NAME_Household];
      distributionVo.under18 = muac[DistributionTable.COLUMN_NAME_Under18];
      distributionVo.over18 = muac[DistributionTable.COLUMN_NAME_Over18];
      distributionVo.iDP = muac[DistributionTable.COLUMN_NAME_IDP];
      distributionVo.disability = muac[DistributionTable.COLUMN_NAME_Disability];
      distributionVo.remark = muac[DistributionTable.COLUMN_NAME_Remark];
      distributionVo.createDate = muac[DistributionTable.COLUMN_CREATE_DATE];
      distributionVo.updateDate = muac[DistributionTable.COLUMN_UPDATE_DATE];
      muacData.add(distributionVo);
    }
    return muacData;
  }

  Future<List<HEVo>> getAllHEDataFromDB() async {
    final db = await database;
    List<HEVo> pnuData = [];
    dynamic pnuValue =
    await db.rawQuery("SELECT * FROM '${HETable.TABLE_NAME}';", null);

    for (var muac in pnuValue) {
      HEVo muacVo = HEVo();
      muacVo.id = muac[HETable.COLUMM_Id];
      muacVo.orgName = muac[HETable.COLUMM_ORG_NAME];
      muacVo.stateName = muac[HETable.COLUMM_STATE_NAME];
      muacVo.townshipName = muac[HETable.COLUMM_TOWNSHIP_NAME];
      muacVo.townshipLocalName = muac[HETable.COLUMM_TOWNSHIP_LOCAL_NAME];
      muacVo.villageName = muac[HETable.COLUMM_Village_Name];
      muacVo.topic = muac[HETable.COLUMM_NAME_Topic];
      muacVo.date = muac[HETable.COLUMN_NAME_Date];
      muacVo.presenterName = muac[HETable.COLUMN_NAME_Presenter_Name];
      muacVo.position = muac[HETable.COLUMN_NAME_Position];
      muacVo.attendedName = muac[HETable.COLUMN_NAME_Attended_Name];
      muacVo.age = muac[HETable.COLUMN_NAME_Age];
      muacVo.gender = muac[HETable.COLUMN_NAME_Gender];
      muacVo.disability = muac[HETable.COLUMN_NAME_Disability];
      muacVo.relocation = muac[HETable.COLUMN_NAME_Relocation];
      muacVo.isNew = muac[HETable.COLUMN_NAME_IS_New];
      muacVo.remark = muac[HETable.COLUMN_NAME_Remark];
      muacVo.createDate = muac[HETable.COLUMN_CREATE_DATE];
      muacVo.updateDate = muac[HETable.COLUMN_UPDATE_DATE];
      pnuData.add(muacVo);
    }
    return pnuData;
  }

  Future<List<ReferalVo>> getAllReferralDataFromDB() async {
    final db = await database;
    List<ReferalVo> pnuData = [];
    dynamic pnuValue =
    await db.rawQuery("SELECT * FROM '${ReferralTable.TABLE_NAME}';", null);

    for (var muac in pnuValue) {
      ReferalVo muacVo = ReferalVo();
      muacVo.id = muac[ReferralTable.COLUMM_Id];
      muacVo.orgName = muac[ReferralTable.COLUMM_ORG_NAME];
      muacVo.stateName = muac[ReferralTable.COLUMM_STATE_NAME];
      muacVo.townshipName = muac[ReferralTable.COLUMM_TOWNSHIP_NAME];
      muacVo.townshipLocalName = muac[ReferralTable.COLUMM_TOWNSHIP_LOCAL_NAME];
      muacVo.clinic = muac[ReferralTable.COLUMM_CLINIC];
      muacVo.villageName = muac[ReferralTable.COLUMM_Village_Name];
      muacVo.date = muac[ReferralTable.COLUMN_NAME_Date];
      muacVo.name = muac[ReferralTable.COLUMN_NAME_Name];
      muacVo.age = muac[ReferralTable.COLUMN_NAME_Age];
      muacVo.gender = muac[ReferralTable.COLUMN_NAME_Gender];
      muacVo.disability = muac[ReferralTable.COLUMN_NAME_Disability];
      muacVo.relocation = muac[ReferralTable.COLUMN_NAME_Relocation];
      muacVo.referralType = muac[ReferralTable.COLUMN_NAME_Referral_Type];
      muacVo.referralCase = muac[ReferralTable.COLUMN_NAME_Referral_Case];
      muacVo.referralPlace = muac[ReferralTable.COLUMN_NAME_Referral_Place];
      muacVo.referralCost = muac[ReferralTable.COLUMN_NAME_Referral_Cost];
      muacVo.referralStaffName = muac[ReferralTable.COLUMN_NAME_Referral_Staff_Name];
      muacVo.remark = muac[ReferralTable.COLUMN_NAME_Remark];
      muacVo.createDate = muac[ReferralTable.COLUMN_CREATE_DATE];
      muacVo.updateDate = muac[ReferralTable.COLUMN_UPDATE_DATE];
      pnuData.add(muacVo);
    }
    return pnuData;
  }


  Future<List<List<String>>> getAllConsultationForExport() async {
    final db = await database;
    List<String> headerList = [
      "TableName",
      "Sr",
      "Organization",
      "State/Region",
      "Township (MIMU)",
      "Township (Local)",
      "Clinic",
      "Channel",
      "Reporting Period",
      (ConsultationTable.COLUMN_NAME_Date),
      (ConsultationTable.COLUMN_NAME_Trauma),
      (ConsultationTable.COLUMN_NAME_Other_Consultations),
      (ConsultationTable.COLUMN_NAME_U5_Pneumonia),
      (ConsultationTable.COLUMN_NAME_U5_Diarrhoea),
      (ConsultationTable.COLUMN_NAME_IDP),
      (ConsultationTable.COLUMN_NAME_Disability),
      (ConsultationTable.COLUMN_NAME_Remark),
      (ConsultationTable.COLUMN_CREATE_DATE),
      (ConsultationTable.COLUMN_UPDATE_DATE)
    ];
    List<List<String>> ancList = [headerList];
    dynamic reachCollectValue = await db.rawQuery(
        "SELECT * FROM '${ConsultationTable.TABLE_NAME}';", null);

    for (var item in reachCollectValue) {
      List<String> itemList = [
        "${item[ConsultationTable.COLUMM_TABLE]}",
        "${item[ConsultationTable.COLUMM_Id]}",
        "${item[ConsultationTable.COLUMM_ORG_NAME]}",
        "${item[ConsultationTable.COLUMM_STATE_NAME]}",
        "${item[ConsultationTable.COLUMM_TOWNSHIP_NAME]}",
        "${item[ConsultationTable.COLUMM_TOWNSHIP_LOCAL_NAME]}",
        "${item[ConsultationTable.COLUMM_CLINIC]}",
        "${item[ConsultationTable.COLUMM_CHANNEL]}",
        "${item[ConsultationTable.COLUMM_REPORTING_PERIOD]}",
        "${item[ConsultationTable.COLUMN_NAME_Date]}",
        "${item[ConsultationTable.COLUMN_NAME_Trauma]}",
        "${item[ConsultationTable.COLUMN_NAME_Other_Consultations]}",
        "${item[ConsultationTable.COLUMN_NAME_U5_Pneumonia]}",
        "${item[ConsultationTable.COLUMN_NAME_U5_Diarrhoea]}",
        "${item[ConsultationTable.COLUMN_NAME_IDP]}",
        "${item[ConsultationTable.COLUMN_NAME_Disability]}",
        "${item[ConsultationTable.COLUMN_NAME_Remark]}",
        "${item[ConsultationTable.COLUMN_CREATE_DATE]}",
        "${item[ConsultationTable.COLUMN_UPDATE_DATE]}"
      ];
      ancList.add(itemList);
    }

    return ancList;
  }

  Future<List<List<String>>> getAllDistributionForExport() async {
    final db = await database;
    List<String> headerList = [
      "TableName",
      "Sr",
      "Organization",
      "State/Region",
      "Township (MIMU)",
      "Township (Local)",
      "Clinic",
      (DistributionTable.COLUMM_REPORTING_PERIOD),
      (DistributionTable.COLUMN_NAME_Date),
      (DistributionTable.COLUMN_NAME_Distribution_Type),
      (DistributionTable.COLUMN_NAME_Beneficiary_Type),
      (DistributionTable.COLUMN_NAME_Item1),
      (DistributionTable.COLUMN_NAME_Item2),
      (DistributionTable.COLUMN_NAME_Item3),
      (DistributionTable.COLUMN_NAME_Household),
      (DistributionTable.COLUMN_NAME_Under18),
      (DistributionTable.COLUMN_NAME_Over18),
      (DistributionTable.COLUMN_NAME_IDP),
      (DistributionTable.COLUMN_NAME_Disability),
      (DistributionTable.COLUMN_NAME_Remark),
      (DistributionTable.COLUMN_CREATE_DATE),
      (DistributionTable.COLUMN_UPDATE_DATE),
    ];
    List<List<String>> ancList = [headerList];
    dynamic reachCollectValue =
    await db.rawQuery("SELECT * FROM '${DistributionTable.TABLE_NAME}';", null);

    for (var item in reachCollectValue) {
      List<String> itemList = [
        "${item[DistributionTable.COLUMM_TABLE]}",
        "${item[DistributionTable.COLUMM_Id]}",
        "${item[DistributionTable.COLUMM_ORG_NAME]}",
        "${item[DistributionTable.COLUMM_STATE_NAME]}",
        "${item[DistributionTable.COLUMM_TOWNSHIP_NAME]}",
        "${item[DistributionTable.COLUMM_TOWNSHIP_LOCAL_NAME]}",
        "${item[DistributionTable.COLUMM_CLINIC]}",
        "${item[DistributionTable.COLUMM_REPORTING_PERIOD]}",
        "${item[DistributionTable.COLUMN_NAME_Date]}",
        "${item[DistributionTable.COLUMN_NAME_Distribution_Type]}",
        "${item[DistributionTable.COLUMN_NAME_Beneficiary_Type]}",
        "${item[DistributionTable.COLUMN_NAME_Item1]}",
        "${item[DistributionTable.COLUMN_NAME_Item2]}",
        "${item[DistributionTable.COLUMN_NAME_Item3]}",
        "${item[DistributionTable.COLUMN_NAME_Household]}",
        "${item[DistributionTable.COLUMN_NAME_Under18]}",
        "${item[DistributionTable.COLUMN_NAME_Over18]}",
        "${item[DistributionTable.COLUMN_NAME_IDP]}",
        "${item[DistributionTable.COLUMN_NAME_Disability]}",
        "${item[DistributionTable.COLUMN_NAME_Remark]}",
        "${item[DistributionTable.COLUMN_CREATE_DATE]}",
        "${item[DistributionTable.COLUMN_UPDATE_DATE]}"

      ];
      ancList.add(itemList);
    }

    return ancList;
  }

  Future<List<List<String>>> getAllHEForExport() async {
    final db = await database;
    List<String> headerList = [
      "TableName",
      "Sr",
      "Organization",
      "State/Region",
      "Township (MIMU)",
      "Township (Local)",
      (HETable.COLUMM_Village_Name),
      (HETable.COLUMM_NAME_Topic),
      (HETable.COLUMN_NAME_Date),
      (HETable.COLUMN_NAME_Presenter_Name),
      (HETable.COLUMN_NAME_Position),
      (HETable.COLUMN_NAME_Attended_Name),
      (HETable.COLUMN_NAME_Age),
      (HETable.COLUMN_NAME_Gender),
      (HETable.COLUMN_NAME_Disability),
      (HETable.COLUMN_NAME_Relocation),
      (HETable.COLUMN_NAME_IS_New),
      (HETable.COLUMN_NAME_Remark),
      (HETable.COLUMN_CREATE_DATE),
      (HETable.COLUMN_UPDATE_DATE),
    ];
    List<List<String>> ancList = [headerList];
    dynamic reachCollectValue =
    await db.rawQuery("SELECT * FROM '${HETable.TABLE_NAME}';", null);

    for (var item in reachCollectValue) {
      List<String> itemList = [
        "${item[HETable.COLUMM_TABLE]}",
        "${item[HETable.COLUMM_Id]}",
        "${item[HETable.COLUMM_ORG_NAME]}",
        "${item[HETable.COLUMM_STATE_NAME]}",
        "${item[HETable.COLUMM_TOWNSHIP_NAME]}",
        "${item[HETable.COLUMM_TOWNSHIP_LOCAL_NAME]}",
        "${item[HETable.COLUMM_Village_Name]}",
        "${item[HETable.COLUMM_NAME_Topic]}",
        "${item[HETable.COLUMN_NAME_Date]}",
        "${item[HETable.COLUMN_NAME_Presenter_Name]}",
        "${item[HETable.COLUMN_NAME_Position]}",
        "${item[HETable.COLUMN_NAME_Attended_Name]}",
        "${item[HETable.COLUMN_NAME_Age]}",
        "${item[HETable.COLUMN_NAME_Gender]}",
        "${item[HETable.COLUMN_NAME_Disability]}",
        "${item[HETable.COLUMN_NAME_Relocation]}",
        "${item[HETable.COLUMN_NAME_IS_New]}",
        "${item[HETable.COLUMN_NAME_Remark]}",
        "${item[HETable.COLUMN_CREATE_DATE]}",
        "${item[HETable.COLUMN_UPDATE_DATE]}"

      ];
      ancList.add(itemList);
    }

    return ancList;
  }

  Future<List<List<String>>> getAllReferralForExport() async {
    final db = await database;
    List<String> headerList = [
      "TableName",
      "Sr",
      "Organization",
      "State/Region",
      "Township (MIMU)",
      "Township (Local)",
      "Clinic",
      (ReferralTable.COLUMM_Village_Name),
      (ReferralTable.COLUMN_NAME_Date),
      (ReferralTable.COLUMN_NAME_Name),
      (ReferralTable.COLUMN_NAME_Age),
      (ReferralTable.COLUMN_NAME_Gender),
      (ReferralTable.COLUMN_NAME_Disability),
      (ReferralTable.COLUMN_NAME_Relocation),
      (ReferralTable.COLUMN_NAME_Referral_Type),
      (ReferralTable.COLUMN_NAME_Referral_Case),
      (ReferralTable.COLUMN_NAME_Referral_Place),
      (ReferralTable.COLUMN_NAME_Referral_Cost),
      (ReferralTable.COLUMN_NAME_Referral_Staff_Name),
      (ReferralTable.COLUMN_NAME_Remark),
      (ReferralTable.COLUMN_CREATE_DATE),
      (ReferralTable.COLUMN_UPDATE_DATE),
    ];
    List<List<String>> ancList = [headerList];
    dynamic reachCollectValue =
    await db.rawQuery("SELECT * FROM '${ReferralTable.TABLE_NAME}';", null);

    for (var item in reachCollectValue) {
      List<String> itemList = [
        "${item[ReferralTable.COLUMM_TABLE]}",
        "${item[ReferralTable.COLUMM_Id]}",
        "${item[ReferralTable.COLUMM_ORG_NAME]}",
        "${item[ReferralTable.COLUMM_STATE_NAME]}",
        "${item[ReferralTable.COLUMM_TOWNSHIP_NAME]}",
        "${item[ReferralTable.COLUMM_TOWNSHIP_LOCAL_NAME]}",
        "${item[ReferralTable.COLUMM_CLINIC]}",
        "${item[ReferralTable.COLUMM_Village_Name]}",
        "${item[ReferralTable.COLUMN_NAME_Date]}",
        "${item[ReferralTable.COLUMN_NAME_Name]}",
        "${item[ReferralTable.COLUMN_NAME_Age]}",
        "${item[ReferralTable.COLUMN_NAME_Gender]}",
        "${item[ReferralTable.COLUMN_NAME_Disability]}",
        "${item[ReferralTable.COLUMN_NAME_Relocation]}",
        "${item[ReferralTable.COLUMN_NAME_Referral_Type]}",
        "${item[ReferralTable.COLUMN_NAME_Referral_Case]}",
        "${item[ReferralTable.COLUMN_NAME_Referral_Place]}",
        "${item[ReferralTable.COLUMN_NAME_Referral_Cost]}",
        "${item[ReferralTable.COLUMN_NAME_Referral_Staff_Name]}",
        "${item[ReferralTable.COLUMN_NAME_Remark]}",
        "${item[ReferralTable.COLUMN_CREATE_DATE]}",
        "${item[ReferralTable.COLUMN_UPDATE_DATE]}"

      ];
      ancList.add(itemList);
    }

    return ancList;
  }

  //DELETE
  Future deleteConsultationFromDB(int id) async {
    final db = await database;
    Batch batch = db.batch();
    batch.delete(ConsultationTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    batch.commit();
    return;
  }

  Future deleteDistributionFromDB(int id) async {
    final db = await database;
    Batch batch = db.batch();
    batch.delete(DistributionTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    batch.commit();
    return;
  }

  Future deleteHEFromDB(int id) async {
    final db = await database;
    Batch batch = db.batch();
    batch.delete(HETable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    batch.commit();
    return;
  }

  Future deleteReferralFromDB(int id) async {
    final db = await database;
    Batch batch = db.batch();
    batch.delete(ReferralTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    batch.commit();
    return;
  }

  //UPDATE
  Future updateConsultationInto(ConsultationVo reachVo) async {
    final db = await database;
    Batch batch = db.batch();
    batch.update(
      ConsultationTable.TABLE_NAME,
      reachVo.toMap(),
      where: 'id = ?',
      whereArgs: [reachVo.id],
    );
    await batch.commit();
    return;
  }

  Future updateDistributionInto(DistributionVo reachVo) async {
    final db = await database;
    Batch batch = db.batch();
    batch.update(
      DistributionTable.TABLE_NAME,
      reachVo.toMap(),
      where: 'id = ?',
      whereArgs: [reachVo.id],
    );
    await batch.commit();
    return;
  }

  Future updateHEInto(HEVo reachVo) async {
    final db = await database;
    Batch batch = db.batch();
    batch.update(
      HETable.TABLE_NAME,
      reachVo.toMap(),
      where: 'id = ?',
      whereArgs: [reachVo.id],
    );
    await batch.commit();
    return;
  }

  Future updateReferralInto(ReferalVo reachVo) async {
    final db = await database;
    Batch batch = db.batch();
    batch.update(
      ReferralTable.TABLE_NAME,
      reachVo.toMap(),
      where: 'id = ?',
      whereArgs: [reachVo.id],
    );
    await batch.commit();
    return;
  }
//END SUMMARY FORM


//GET List For Export
  Future<List<String>> getColumns(String columnName, String tableName) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.rawQuery('SELECT DISTINCT $columnName FROM $tableName');

    List<String> columnList = result.map((row) => row[columnName] as String).toList();

    return columnList;
  }

}
