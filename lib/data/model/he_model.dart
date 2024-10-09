import '../../network/presistance/database_table.dart';
class HEVo {
  int? id;
  String? tableName;
  String? orgName;
  String? stateName;
  String? townshipName;
  String? townshipLocalName;
  String? reportingPeroid;
  String? villageName;
  String? topic;
  String? date;
  String? presenterName;
  String? position;
  String? attendedName;
  String? age;
  String? gender;
  String? disability;
  String? relocation;
  String? isNew;
  String? remark;
  String? createDate;
  String? updateDate;

  HEVo({
    this.id,
    this.tableName,
    this.orgName,
    this.stateName,
    this.townshipName,
    this.townshipLocalName,
    this.reportingPeroid,
    this.villageName,
    this.topic,
    this.date,
    this.presenterName,
    this.position,
    this.attendedName,
    this.age,
    this.gender,
    this.disability,
    this.relocation,
    this.isNew,
    this.remark,
    this.createDate,
    this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      HETable.COLUMM_Id: id,
      HETable.COLUMM_TABLE: tableName,
      HETable.COLUMM_ORG_NAME: orgName,
      HETable.COLUMM_STATE_NAME: stateName,
      HETable.COLUMM_TOWNSHIP_NAME: townshipName,
      HETable.COLUMM_TOWNSHIP_LOCAL_NAME: townshipLocalName,
      HETable.COLUMM_REPORTING_PERIOD: reportingPeroid,
      HETable.COLUMM_Village_Name: villageName,
      HETable.COLUMM_NAME_Topic: topic,
      HETable.COLUMN_NAME_Date: date,
      HETable.COLUMN_NAME_Presenter_Name: presenterName,
      HETable.COLUMN_NAME_Position: position,
      HETable.COLUMN_NAME_Attended_Name: attendedName,
      HETable.COLUMN_NAME_Age: age,
      HETable.COLUMN_NAME_Gender: gender,
      HETable.COLUMN_NAME_Disability: disability,
      HETable.COLUMN_NAME_Relocation: relocation,
      HETable.COLUMN_NAME_IS_New: isNew,
      HETable.COLUMN_NAME_Remark: remark,
      HETable.COLUMN_CREATE_DATE: createDate,
      HETable.COLUMN_UPDATE_DATE: updateDate,
    };
  }


}