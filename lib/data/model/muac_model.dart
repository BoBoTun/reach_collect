import 'package:reach_collect/network/presistance/database_table.dart';
class MUACVo {
  int? id;
  String? tableName;
  String? orgName;
  String? stateName;
  String? townshipName;
  String? townshipLocalName;
  String? clinic;
  String? villageName;
  String? volunteerName;
  String? date;
  String? name;
  String? age;
  String? sex;
  String? disabled;
  String? relocation;
  String? phone;
  String? armSize;
  String? weight;
  String? swelling;
  String? refer;
  String? referPlace;
  String? referGo;
  String? remark;
  String? createDate;
  String? updateDate;

  MUACVo({
    this.id,
    this.tableName,
    this.orgName,
    this.stateName,
    this.townshipName,
    this.townshipLocalName,
    this.clinic,
    this.villageName,
    this.volunteerName,
    this.date,
    this.name,
    this.age,
    this.sex,
    this.disabled,
    this.relocation,
    this.phone,
    this.armSize,
    this.weight,
    this.swelling,
    this.refer,
    this.referPlace,
    this.referGo,
    this.remark,
    this.createDate,
    this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      MUACTable.COLUMM_Id: id,
      MUACTable.COLUMM_TABLE: tableName,
      MUACTable.COLUMM_ORG_NAME: orgName,
      MUACTable.COLUMM_STATE_NAME: stateName,
      MUACTable.COLUMM_TOWNSHIP_NAME: townshipName,
      MUACTable.COLUMM_TOWNSHIP_LOCAL_NAME: townshipLocalName,
      MUACTable.COLUMM_CLINIC: clinic,
      MUACTable.COLUMM_VILLAGE_NAME: villageName,
      MUACTable.COLUMM_VOLUNTEER_NAME: volunteerName,
      MUACTable.COLUMN_NAME_Date: date,
      MUACTable.COLUMN_NAMEE: name,
      MUACTable.COLUMN_AGE: age,
      MUACTable.COLUMN_NAME_SEX: sex,
      MUACTable.COLUMN_NAME_Disabled: disabled,
      MUACTable.COLUMN_NAME_Relocation: relocation,
      MUACTable.COLUMN_NAME_Phone: phone,
      MUACTable.COLUMN_NAME_Armsize: armSize,
      MUACTable.COLUMN_NAME_Weight: weight,
      MUACTable.COLUMN_NAME_Swelling: swelling,
      MUACTable.COLUMN_NAME_Refer: refer,
      MUACTable.COLUMN_NAME_ReferPlace: referPlace,
      MUACTable.COLUMN_NAME_ReferGo: referGo,
      MUACTable.COLUMN_NAME_Remark: remark,
      MUACTable.COLUMN_CREATE_DATE: createDate,
      MUACTable.COLUMN_UPDATE_DATE: updateDate,
    };
  }


}