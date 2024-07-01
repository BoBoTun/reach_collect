import 'package:reach_collect/network/presistance/database_table.dart';
class SRHVo {
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
  String? sex;
  String? disability;
  String? iDP;
  String? serviceType;
  String? firstReach;
  String? fpCommodity;
  String? quantity;
  String? fnpDiagnosis;
  String? treatment;
  String? attended;
  String? outcome;
  String? remark;
  String? createDate;
  String? updateDate;

  SRHVo({
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
    this.sex,
    this.disability,
    this.iDP,
    this.serviceType,
    this.firstReach,
    this.fpCommodity,
    this.quantity,
    this.fnpDiagnosis,
    this.treatment,
    this.attended,
    this.outcome,
    this.remark,
    this.createDate,
    this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      SRHTable.COLUMM_Id:id,
      SRHTable.COLUMM_TABLE: tableName,
      SRHTable.COLUMM_ORG_NAME: orgName,
      SRHTable.COLUMM_STATE_NAME: stateName,
      SRHTable.COLUMM_TOWNSHIP_NAME: townshipName,
      SRHTable.COLUMM_TOWNSHIP_LOCAL_NAME: townshipLocalName,
      SRHTable.COLUMM_CLINIC: clinic,
      SRHTable.COLUMM_CHANNEL: channel,
      SRHTable.COLUMM_REPORTING_PERIOD: reportingPeroid,
      SRHTable.COLUMN_NAME_Date: date,
      SRHTable.COLUMN_NAME_Name: name,
      SRHTable.COLUMN_NAME_Age: age,
      SRHTable.COLUMN_NAME_SEX: sex,
      SRHTable.COLUMN_NAME_Disability: disability,
      SRHTable.COLUMN_NAME_IDP: iDP,
      SRHTable.COLUMN_NAME_SERVICE_TYPE: serviceType,
      SRHTable.COLUMN_NAME_FIRST_REACH: firstReach,
      SRHTable.COLUMN_NAME_FP_COMMODITY: fpCommodity,
      SRHTable.COLUMN_NAME_QUANTITY: quantity,
      SRHTable.COLUMN_NAME_FANDP_DIAGNOSIS: fnpDiagnosis,
      SRHTable.COLUMN_NAME_Treatment: treatment,
      SRHTable.COLUMN_NAME_Attended: attended,
      SRHTable.COLUMN_NAME_Outcome: outcome,
      SRHTable.COLUMN_NAME_Remark: remark,
      SRHTable.COLUMN_CREATE_DATE: createDate,
      SRHTable.COLUMN_UPDATE_DATE: updateDate,
    };
  }


}