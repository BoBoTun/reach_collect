import '../../network/presistance/database_table.dart';
class ReferalVo {
  int? id;
  String? tableName;
  String? orgName;
  String? stateName;
  String? townshipName;
  String? townshipLocalName;
  String? clinic;
  String? reportingPeroid;
  String? villageName;
  String? date;
  String? name;
  String? age;
  String? gender;
  String? disability;
  String? relocation;
  String? referralType;
  String? referralCase;
  String? referralPlace;
  String? referralCost;
  String? referralStaffName;
  String? remark;
  String? createDate;
  String? updateDate;

  ReferalVo({
    this.id,
    this.tableName,
    this.orgName,
    this.stateName,
    this.townshipName,
    this.townshipLocalName,
    this.clinic,
    this.reportingPeroid,
    this.villageName,
    this.date,
    this.name,
    this.age,
    this.gender,
    this.disability,
    this.relocation,
    this.referralType,
    this.referralCase,
    this.referralPlace,
    this.referralCost,
    this.referralStaffName,
    this.remark,
    this.createDate,
    this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      ReferralTable.COLUMM_Id: id,
      ReferralTable.COLUMM_TABLE: tableName,
      ReferralTable.COLUMM_ORG_NAME: orgName,
      ReferralTable.COLUMM_STATE_NAME: stateName,
      ReferralTable.COLUMM_TOWNSHIP_NAME: townshipName,
      ReferralTable.COLUMM_TOWNSHIP_LOCAL_NAME: townshipLocalName,
      ReferralTable.COLUMM_CLINIC:clinic,
      ReferralTable.COLUMM_REPORTING_PERIOD: reportingPeroid,
      ReferralTable.COLUMM_Village_Name: villageName,
      ReferralTable.COLUMN_NAME_Date: date,
      ReferralTable.COLUMN_NAME_Name: name,
      ReferralTable.COLUMN_NAME_Age: age,
      ReferralTable.COLUMN_NAME_Gender: gender,
      ReferralTable.COLUMN_NAME_Disability: disability,
      ReferralTable.COLUMN_NAME_Relocation: relocation,
      ReferralTable.COLUMN_NAME_Referral_Type: referralType,
      ReferralTable.COLUMN_NAME_Referral_Case: referralCase,
      ReferralTable.COLUMN_NAME_Referral_Place: referralPlace,
      ReferralTable.COLUMN_NAME_Referral_Cost: referralCost,
      ReferralTable.COLUMN_NAME_Referral_Staff_Name: referralStaffName,
      ReferralTable.COLUMN_NAME_Remark: remark,
      ReferralTable.COLUMN_CREATE_DATE: createDate,
      ReferralTable.COLUMN_UPDATE_DATE: updateDate,
    };
  }


}