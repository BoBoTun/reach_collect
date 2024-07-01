import 'package:reach_collect/network/presistance/database_table.dart';
class PNUVo {
  int? id;
  String? tableName;
  String? orgName;
  String? stateName;
  String? townshipName;
  String? townshipLocalName;
  String? clinic;
  String? villageName;
  String? volunteerName;
  String? reportingPeroid;
  String? date;
  String? name;
  String? age;
  String? sex;
  String? disabled;
  String? relocation;
  String? kofPatient;
  String? symptomsList;
  String? diseaseList;
  String? treatment;
  String? treatmentPeriod;
  String? refer;
  String? referPlace;
  String? referGo;
  String? remark;
  String? createDate;
  String? updateDate;

  PNUVo({
    this.id,
    this.tableName,
    this.orgName,
    this.stateName,
    this.townshipName,
    this.townshipLocalName,
    this.clinic,
    this.villageName,
    this.volunteerName,
    this.reportingPeroid,
    this.date,
    this.name,
    this.age,
    this.sex,
    this.disabled,
    this.relocation,
    this.kofPatient,
    this.symptomsList,
    this.diseaseList,
    this.treatment,
    this.treatmentPeriod,
    this.refer,
    this.referPlace,
    this.referGo,
    this.remark,
    this.createDate,
    this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      PNUTable.COLUMM_Id: id,
      PNUTable.COLUMM_TABLE: tableName,
      PNUTable.COLUMM_ORG_NAME: orgName,
      PNUTable.COLUMM_STATE_NAME: stateName,
      PNUTable.COLUMM_TOWNSHIP_NAME: townshipName,
      PNUTable.COLUMM_TOWNSHIP_LOCAL_NAME: townshipLocalName,
      PNUTable.COLUMM_CLINIC: clinic,
      PNUTable.COLUMM_VILLAGE_NAME: villageName,
      PNUTable.COLUMM_VOLUNTEER_NAME: volunteerName,
      PNUTable.COLUMM_REPORTING_PERIOD: reportingPeroid,
      PNUTable.COLUMN_NAME_Date: date,
      PNUTable.COLUMN_NAME: name,
      PNUTable.COLUMN_AGE: age,
      PNUTable.COLUMN_NAME_SEX: sex,
      PNUTable.COLUMN_NAME_Disabled: disabled,
      PNUTable.COLUMN_NAME_Relocation: relocation,
      PNUTable.COLUMN_NAME_KOFPatient: kofPatient,
      PNUTable.COLUMN_NAME_SymptomsList: symptomsList,
      PNUTable.COLUMN_NAME_DiseaseList: symptomsList,
      PNUTable.COLUMN_NAME_Treatment: treatment,
      PNUTable.COLUMN_NAME_TreatmentPeriod: treatmentPeriod,
      PNUTable.COLUMN_NAME_Refer: refer,
      PNUTable.COLUMN_NAME_ReferPlace: referPlace,
      PNUTable.COLUMN_NAME_ReferGo: referGo,
      PNUTable.COLUMN_NAME_Remark: remark,
      PNUTable.COLUMN_CREATE_DATE: createDate,
      PNUTable.COLUMN_UPDATE_DATE: updateDate,
    };
  }


}