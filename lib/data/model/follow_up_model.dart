import 'package:reach_collect/network/presistance/database_table.dart';
class FollowUpVo {
  int? id;
  String? artId;
  String? date;
  String? outcome;
  String? tbStatus;
  String? adHerence;
  String? viralLoad;
  String? nextVISIT;

  FollowUpVo({
    this.id,
    this.artId,
    this.date,
    this.outcome,
    this.tbStatus,
    this.adHerence,
    this.viralLoad,
    this.nextVISIT
  });

  Map<String, dynamic> toMap() {
    return {
      FollowUpTable.COLUMM_Id: id,
      FollowUpTable.COLUMM_ART_Id: artId,
      FollowUpTable.COLUMM_DATE: date,
      FollowUpTable.COLUMM_OUTCOME: outcome,
      FollowUpTable.COLUMM_TB_STATUS: tbStatus,
      FollowUpTable.COLUMM_ADHERENCE: adHerence,
      FollowUpTable.COLUMM_VIRAL_LOAD: viralLoad,
      FollowUpTable.COLUMM_NEXT_VISIT: nextVISIT
    };
  }


}

