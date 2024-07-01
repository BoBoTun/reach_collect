
import '../../network/presistance/database_table.dart';

class DistributionVo {
  int? id;
  String? tableName;
  String? orgName;
  String? stateName;
  String? townshipName;
  String? townshipLocalName;
  String? clinic;
  String? reportingPeroid;
  String? date;
  String? distribution;
  String? beneficiary;
  String? item1;
  String? item2;
  String? item3;
  String? household;
  String? under18;
  String? over18;
  String? iDP;
  String? disability;
  String? remark;
  String? createDate;
  String? updateDate;

  DistributionVo({
    this.id,
    this.tableName,
    this.orgName,
    this.stateName,
    this.townshipName,
    this.townshipLocalName,
    this.clinic,
    this.reportingPeroid,
    this.date,
    this.distribution,
    this.beneficiary,
    this.item1,
    this.item2,
    this.item3,
    this.household,
    this.under18,
    this.over18,
    this.iDP,
    this.disability,
    this.remark,
    this.createDate,
    this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      DistributionTable.COLUMM_Id: id,
      DistributionTable.COLUMM_TABLE: tableName,
      DistributionTable.COLUMM_ORG_NAME: orgName,
      DistributionTable.COLUMM_STATE_NAME: stateName,
      DistributionTable.COLUMM_TOWNSHIP_NAME: townshipName,
      DistributionTable.COLUMM_TOWNSHIP_LOCAL_NAME: townshipLocalName,
      DistributionTable.COLUMM_CLINIC: clinic,
      DistributionTable.COLUMM_REPORTING_PERIOD: reportingPeroid,
      DistributionTable.COLUMN_NAME_Date: date,
      DistributionTable.COLUMN_NAME_Distribution_Type: distribution,
      DistributionTable.COLUMN_NAME_Beneficiary_Type: beneficiary,
      DistributionTable.COLUMN_NAME_Item1: item1,
      DistributionTable.COLUMN_NAME_Item2: item2,
      DistributionTable.COLUMN_NAME_Item3: item3,
      DistributionTable.COLUMN_NAME_Household: household,
      DistributionTable.COLUMN_NAME_Under18: under18,
      DistributionTable.COLUMN_NAME_Over18: over18,
      DistributionTable.COLUMN_NAME_IDP :iDP,
      DistributionTable.COLUMN_NAME_Disability: disability,
      DistributionTable.COLUMN_NAME_Remark: remark,
      DistributionTable.COLUMN_CREATE_DATE: createDate,
      DistributionTable.COLUMN_UPDATE_DATE: updateDate,
    };
  }


}