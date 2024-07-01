
import '../../network/presistance/database_table.dart';

class ConsultationVo {
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
  String? trauma;
  String? consultations;
  String? pneumonia;
  String? diarrhoea;
  String? iDP;
  String? disability;
  String? remark;
  String? createDate;
  String? updateDate;

  ConsultationVo({
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
    this.trauma,
    this.consultations,
    this.pneumonia,
    this.diarrhoea,
    this.iDP,
    this.disability,
    this.remark,
    this.createDate,
    this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      ConsultationTable.COLUMM_Id: id,
      ConsultationTable.COLUMM_TABLE: tableName,
      ConsultationTable.COLUMM_ORG_NAME: orgName,
      ConsultationTable.COLUMM_STATE_NAME: stateName,
      ConsultationTable.COLUMM_TOWNSHIP_NAME: townshipName,
      ConsultationTable.COLUMM_TOWNSHIP_LOCAL_NAME: townshipLocalName,
      ConsultationTable.COLUMM_CLINIC: clinic,
      ConsultationTable.COLUMM_CHANNEL: channel,
      ConsultationTable.COLUMM_REPORTING_PERIOD: reportingPeroid,
      ConsultationTable.COLUMN_NAME_Date: date,
      ConsultationTable.COLUMN_NAME_Trauma : trauma,
      ConsultationTable.COLUMN_NAME_Other_Consultations :consultations,
      ConsultationTable.COLUMN_NAME_U5_Pneumonia :pneumonia,
      ConsultationTable.COLUMN_NAME_U5_Diarrhoea :diarrhoea,
      ConsultationTable.COLUMN_NAME_IDP :iDP,
      ConsultationTable.COLUMN_NAME_Disability: disability,
      ConsultationTable.COLUMN_NAME_Remark: remark,
      ConsultationTable.COLUMN_CREATE_DATE: createDate,
      ConsultationTable.COLUMN_UPDATE_DATE: updateDate,
    };
  }


}