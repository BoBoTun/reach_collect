import 'package:reach_collect/network/presistance/database_table.dart';
class TBFollowUpVo {
  int? id;
  String? tbId;
  String? date;
  String? s;
  String? x;
  String? t;
  String? latNo;
  String? remark;

  TBFollowUpVo({
    this.id,
    this.tbId,
    this.date,
    this.s,
    this.x,
    this.t,
    this.latNo,
    this.remark
  });

  Map<String, dynamic> toMap() {
    return {
      TBFollowUpTable.COLUMM_Id: id,
      TBFollowUpTable.COLUMM_TB_Id: tbId,
      TBFollowUpTable.COLUMM_DATE: date,
      TBFollowUpTable.COLUMM_S: s,
      TBFollowUpTable.COLUMM_X: x,
      TBFollowUpTable.COLUMM_T: t,
      TBFollowUpTable.COLUMM_LABNO: latNo,
      TBFollowUpTable.COLUMM_REMARK: remark
    };
  }


}

