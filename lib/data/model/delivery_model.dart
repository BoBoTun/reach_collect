import 'package:reach_collect/network/presistance/database_table.dart';
class DeliveryVo {
  int? id;
  String? tableName;
  String? orgName;
  String? stateName;
  String? townshipName;
  String? townshipLocalName;
  String? clinic;
  String? channel;
  String? reportingPeroid;
  String? date;
  String? name;
  String? age;
  String? disability;
  String? iDP;
  String? gestational;
  String? gravida;
  String? tDComplete;
  String? birthType;
  String? birthWeight;
  String? neonatal;
  String? breastfeeding;
  String? treatment;
  String? attended;
  String? outcome;
  String? remark;
  String? createDate;
  String? updateDate;

  DeliveryVo({
    this.id,
    this.tableName,
    this.orgName,
    this.stateName,
    this.townshipName,
    this.townshipLocalName,
    this.clinic,
    this.channel,
    this.reportingPeroid,
    this.date,
    this.name,
    this.age,
    this.disability,
    this.iDP,
    this.gestational,
    this.gravida,
    this.tDComplete,
    this.birthType,
    this.birthWeight,
    this.neonatal,
    this.breastfeeding,
    this.treatment,
    this.attended,
    this.outcome,
    this.remark,
    this.createDate,
    this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      DeliveryTable.COLUMM_Id:id,
      DeliveryTable.COLUMM_TABLE: tableName,
      DeliveryTable.COLUMM_ORG_NAME: orgName,
      DeliveryTable.COLUMM_STATE_NAME: stateName,
      DeliveryTable.COLUMM_TOWNSHIP_NAME: townshipName,
      DeliveryTable.COLUMM_TOWNSHIP_LOCAL_NAME: townshipLocalName,
      DeliveryTable.COLUMM_CLINIC: clinic,
      DeliveryTable.COLUMM_CHANNEL: channel,
      DeliveryTable.COLUMM_REPORTING_PERIOD: reportingPeroid,
      DeliveryTable.COLUMN_NAME_Date: date,
      DeliveryTable.COLUMN_NAME_Name: name,
      DeliveryTable.COLUMN_NAME_Age: age,
      DeliveryTable.COLUMN_NAME_Disability: disability,
      DeliveryTable.COLUMN_NAME_IDP: iDP,
      DeliveryTable.COLUMN_NAME_Gestational: gestational,
      DeliveryTable.COLUMN_NAME_Gravida: gravida,
      DeliveryTable.COLUMN_NAME_TD_COMPLETE: tDComplete,
      DeliveryTable.COLUMN_NAME_BIRTH_TYPE: birthType,
      DeliveryTable.COLUMN_NAME_BIRTH_WEIGHT: birthWeight,
      DeliveryTable.COLUMN_NAME_NEONATAL: neonatal,
      DeliveryTable.COLUMN_NAME_BREASTFEEDING: breastfeeding,
      DeliveryTable.COLUMN_NAME_Treatment: treatment,
      DeliveryTable.COLUMN_NAME_Attended: attended,
      DeliveryTable.COLUMN_NAME_Outcome: outcome,
      DeliveryTable.COLUMN_NAME_Remark: remark,
      DeliveryTable.COLUMN_CREATE_DATE: createDate,
      DeliveryTable.COLUMN_UPDATE_DATE: updateDate,
    };
  }


}