import 'package:reach_collect/network/presistance/database_table.dart';
class ANCVo {
  int? id;
  String? tableName;
  String? orgName;
  String? stateName;
  String? townshipName;
  String? townshipLocalName;
  String? clinic;
  String? channel;
  String? reportingPeroid;
  String? name;
  String? age;
  String? date;
  String? disability;
  String? idp;
  String? gestational;
  String? gravida;
  String? parity;
  String? noOfANC;
  String? td;
  String? findings;
  String? treatment;
  String? ancfour;
  String? attended;
  String? outcome;
  String? remark;
  String? createDate;
  String? updateDate;

  ANCVo({
    this.id,
    this.tableName,
    this.orgName,
    this.stateName,
    this.townshipName,
    this.townshipLocalName,
    this.clinic,
    this.channel,
    this.reportingPeroid,
    this.name,
    this.age,
    this.date,
    this.disability,
    this.idp,
    this.gestational,
    this.gravida,
    this.parity,
    this.noOfANC,
    this.td,
    this.findings,
    this.treatment,
    this.ancfour,
    this.attended,
    this.outcome,
    this.remark,
    this.createDate,
    this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      AncRegisterTable.COLUMM_Id: id,
      AncRegisterTable.COLUMM_TABLE: tableName,
      AncRegisterTable.COLUMM_ORG_NAME: orgName,
      AncRegisterTable.COLUMM_STATE_NAME: stateName,
      AncRegisterTable.COLUMM_TOWNSHIP_NAME: townshipName,
      AncRegisterTable.COLUMM_TOWNSHIP_LOCAL_NAME: townshipLocalName,
      AncRegisterTable.COLUMM_CLINIC: clinic,
      AncRegisterTable.COLUMM_CHANNEL: channel,
      AncRegisterTable.COLUMM_REPORTING_PERIOD: reportingPeroid,
      AncRegisterTable.COLUMN_NAME_Name: name,
      AncRegisterTable.COLUMN_NAME_Age: age,
      AncRegisterTable.COLUMN_NAME_Date: date,
      AncRegisterTable.COLUMN_NAME_Disability: disability,
      AncRegisterTable.COLUMN_NAME_IDP: idp,
      AncRegisterTable.COLUMN_NAME_Gestational: gestational,
      AncRegisterTable.COLUMN_NAME_Gravida: gravida,
      AncRegisterTable.COLUMN_NAME_Parity: parity,
      AncRegisterTable.COLUMN_NAME_NoOfANC: noOfANC,
      AncRegisterTable.COLUMN_NAME_Td: td,
      AncRegisterTable.COLUMN_NAME_Findings: findings,
      AncRegisterTable.COLUMN_NAME_Treatment: treatment,
      AncRegisterTable.COLUMN_NAME_ANC4: ancfour,
      AncRegisterTable.COLUMN_NAME_Attended: attended,
      AncRegisterTable.COLUMN_NAME_Outcome: outcome,
      AncRegisterTable.COLUMN_NAME_Remark: remark,
      AncRegisterTable.COLUMN_CREATE_DATE: createDate,
      AncRegisterTable.COLUMN_UPDATE_DATE: updateDate,
    };
  }


}

