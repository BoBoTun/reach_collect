import 'package:reach_collect/network/presistance/database_table.dart';
class EPIVo {
  int? id;
  String? tableName;
  String? orgName;
  String? stateName;
  String? townshipName;
  String? townshipLocalName;
  String? clinic;
  String? channel;
  String? reportingPeroid;
  String? childName;
  String? sex;
  String? disabled;
  String? relocation;
  String? address;
  String? dob;
  String? bcg;
  String? opv;
  String? penta;
  String? mmr;
  String? je;
  String? vaccined;
  String? refer;
  String? referPlace;
  String? remark;
  String? createDate;
  String? updateDate;

  EPIVo({
    this.id,
    this.tableName,
    this.orgName,
    this.stateName,
    this.townshipName,
    this.townshipLocalName,
    this.clinic,
    this.channel,
    this.reportingPeroid,
    this.childName,
    this.sex,
    this.disabled,
    this.relocation,
    this.address,
    this.dob,
    this.bcg,
    this.opv,
    this.penta,
    this.mmr,
    this.je,
    this.vaccined,
    this.refer,
    this.referPlace,
    this.remark,
    this.createDate,
    this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      EPITable.COLUMM_Id: id,
      EPITable.COLUMM_TABLE: tableName,
      EPITable.COLUMM_ORG_NAME: orgName,
      EPITable.COLUMM_STATE_NAME: stateName,
      EPITable.COLUMM_TOWNSHIP_NAME: townshipName,
      EPITable.COLUMM_TOWNSHIP_LOCAL_NAME: townshipLocalName,
      EPITable.COLUMM_CLINIC: clinic,
      EPITable.COLUMM_CHANNEL: channel,
      EPITable.COLUMM_REPORTING_PERIOD: reportingPeroid,
      EPITable.COLUMN_CHILD_NAME: childName,
      EPITable.COLUMN_NAME_SEX: sex,
      EPITable.COLUMN_NAME_Disabled: disabled,
      EPITable.COLUMN_NAME_Relocation: relocation,
      EPITable.COLUMN_NAME_Address: address,
      EPITable.COLUMN_NAME_DOB: dob,
      EPITable.COLUMN_NAME_BCG: bcg,
      EPITable.COLUMN_NAME_OPV: opv,
      EPITable.COLUMN_NAME_PENTA: penta,
      EPITable.COLUMN_NAME_MMR: mmr,
      EPITable.COLUMN_NAME_JE: je,
      EPITable.COLUMN_NAME_Vaccined: vaccined,
      EPITable.COLUMN_NAME_Refer: refer,
      EPITable.COLUMN_NAME_ReferPlace: referPlace,
      EPITable.COLUMN_NAME_Remark: remark,
      EPITable.COLUMN_CREATE_DATE: createDate,
      EPITable.COLUMN_UPDATE_DATE: updateDate,
    };
  }


}