//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reach_collect/data/model/anc_model.dart';
import 'package:reach_collect/data/model/consultation_model.dart';
import 'package:reach_collect/data/model/delivery_model.dart';
import 'package:reach_collect/data/model/distribution_model.dart';
import 'package:reach_collect/data/model/he_model.dart';
import 'package:reach_collect/data/model/muac_model.dart';
import 'package:reach_collect/data/model/pnu_model.dart';
import 'package:reach_collect/data/model/referal_model.dart';
import 'package:reach_collect/data/model/srh_model.dart';
import 'package:reach_collect/screens/consultation/edit/edit_epi.dart';
import 'package:reach_collect/screens/consultation/edit/edit_muac.dart';
import 'package:reach_collect/screens/consultation/edit/edit_pnu.dart';
import 'package:reach_collect/screens/consultation/epi_register.dart';
import 'package:reach_collect/screens/consultation/muac_register.dart';
import 'package:reach_collect/screens/consultation/pnu_register.dart';
import 'package:reach_collect/screens/ihrp/art_register.dart';
import 'package:reach_collect/screens/ihrp/hiv_register.dart';
import 'package:reach_collect/screens/ihrp/malaria_register.dart';
import 'package:reach_collect/screens/ihrp/tb_individual_register.dart';
import 'package:reach_collect/screens/ihrp/tb_referral_register.dart';
import 'package:reach_collect/screens/ihrp/tb_screen_register.dart';
import 'package:reach_collect/screens/rmnch/acm_register.dart';
import 'package:reach_collect/screens/rmnch/delivery_register.dart';
import 'package:reach_collect/screens/rmnch/edit/edit_delivery.dart';
import 'package:reach_collect/screens/rmnch/edit/edit_srh.dart';
import 'package:reach_collect/screens/rmnch/srh_register.dart';
import 'package:reach_collect/screens/summarys/consultation_register.dart';
import 'package:reach_collect/screens/summarys/distribution_register.dart';
import 'package:reach_collect/screens/summarys/edit/edit_consultation.dart';
import 'package:reach_collect/screens/summarys/edit/edit_distribution.dart';
import 'package:reach_collect/screens/summarys/edit/edit_health_education.dart';
import 'package:reach_collect/screens/summarys/edit/edit_referral.dart';
import 'package:reach_collect/screens/summarys/health_education_register.dart';
import 'package:reach_collect/screens/summarys/referral_register.dart';
import 'package:reach_collect/utils/app_constant.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/widgets/custom_button.dart';
import 'package:reach_collect/widgets/sidebar_listview.dart';
import '../data/model/epi_model.dart';
import '../network/presistance/SQLiteHelper.dart';
import 'rmnch/edit/edit_acn.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.indexOfTab, required this.selectedSideIndex});
  int indexOfTab;
  int selectedSideIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SQLiteHelper helper = SQLiteHelper();
  List<ANCVo> ancVo = [];
  List<DeliveryVo> deliveryVo = [];
  List<SRHVo> srHVo = [];

  List<EPIVo> epiVo = [];
  List<MUACVo> muacVo = [];
  List<PNUVo> pnuVo = [];

  List<ConsultationVo> consultationVo = [];
  List<DistributionVo> distributionVo = [];
  List<HEVo> heVo = [];
  List<ReferalVo> referralVo = [];

  List<String> rmnchList = ['ANC', 'Delivery', 'SRH'];
  List<String> consultationList = ['EPI', 'MUAC', 'Pnu&Diarr'];
  List<String> summaryList = ['Consultation','Distribution','Health Education','Referral'];
  List<String> ihrpList = ['Malaria', 'TB Referral', 'TB Screening','TB Treatment','HIV Testing', 'ART'];
  List<List<String>> titleList = [['']];
  List<List<String>> itemList = [['']];


  @override
  void initState() {
    super.initState();

    reloadData();


  }

  void reloadData() {
    print("Reload Data ....");

    if (widget.selectedSideIndex == 0){
      //MUAC FORM
      titleList = widget.indexOfTab == 0 ?
      AppConstants.ancTitleList :
      widget.indexOfTab == 1 ?
      AppConstants.deliveryTitleList :
      AppConstants.srhTitleList;

      //titleList.add([' ']);

      if (widget.indexOfTab == 0){
        print("Get From Data ....");
        helper.getAllAncDataFromDB().then((value) {
          ancVo = value;
          setState(() {

            print("Get Value in set state ....");
            itemList = ancVo.asMap()
                .entries.map((item) => [item.key + 1, item.value.date, item.value.name, item.value.age, item.value.disability,item.value.idp,item.value.gestational,item.value.gravida,item.value.id].map((e) => e.toString()).toList()).toList();
            //itemList.add([" "]);
          });
        });

      }else if (widget.indexOfTab == 1){
        helper.getAllDeliveryDataFromDB().then((value) {
          setState(() {
            deliveryVo = value;
            itemList = deliveryVo.asMap()
                .entries.map((item) => [item.key + 1, item.value.date, item.value.name, item.value.age, item.value.disability,item.value.iDP,item.value.gestational,item.value.gravida,item.value.id].map((e) => e.toString()).toList()).toList();
            //itemList.add([" "]);
          });
        });

      }else{

        helper.getAllSRHDataFromDB().then((value) {
          setState(() {
            srHVo = value;
            itemList = srHVo.asMap()
                .entries.map((item) => [item.key + 1, item.value.date, item.value.name, item.value.age, item.value.sex,item.value.disability,item.value.iDP,item.value.serviceType,item.value.id].map((e) => e.toString()).toList()).toList();
            //itemList.add([" "]);
          });
        });
      }
    }
    else if (widget.selectedSideIndex == 1){
      //UNDER5 FORM
      titleList = widget.indexOfTab == 0 ?
      AppConstants.epiTitleList :
      widget.indexOfTab == 1 ?
      AppConstants.muacTitleList :
      AppConstants.pnuTitleList;

      //titleList.add([' ']);

      if (widget.indexOfTab == 0){
        helper.getAllEPIDataFromDB().then((value) {
          epiVo = value;
          setState(() {

            itemList = epiVo.asMap()
                .entries.map((item) => [item.key + 1, item.value.childName, item.value.sex, item.value.disabled, item.value.relocation,item.value.address,item.value.dob,item.value.bcg,item.value.id].map((e) => e.toString()).toList()).toList();
            //itemList.add([" "]);
          });
        });

      }else if (widget.indexOfTab == 1){
        helper.getAllMUACDataFromDB().then((value) {
          setState(() {
            muacVo = value;
            itemList = muacVo.asMap()
                .entries.map((item) => [item.key + 1, item.value.date, item.value.name, item.value.age, item.value.sex,item.value.disabled,item.value.relocation,item.value.phone,item.value.id].map((e) => e.toString()).toList()).toList();
            //itemList.add([" "]);
          });
        });

      }else{

        helper.getAllPNUDataFromDB().then((value) {
          setState(() {
            pnuVo = value;
            itemList = pnuVo.asMap()
                .entries.map((item) => [item.key + 1, item.value.date, item.value.name, item.value.age, item.value.sex,item.value.disabled,item.value.relocation,item.value.kofPatient,item.value.id].map((e) => e.toString()).toList()).toList();
            //itemList.add([" "]);
          });
        });
      }
    }
    else if (widget.selectedSideIndex == 3){
      //UNDER5 FORM
      titleList = widget.indexOfTab == 0 ?
      AppConstants.consultationTitleList :
      widget.indexOfTab == 1 ?
      AppConstants.distributionTitleList :
      widget.indexOfTab == 2 ?
      AppConstants.heTitleList
      : AppConstants.referralTitleList;

      //titleList.add([' ']);

      if (widget.indexOfTab == 0){
        helper.getAllConsultationDataTFromDB().then((value) {
          consultationVo = value;
          setState(() {

            itemList = consultationVo.asMap()
                .entries.map((item) => [item.key + 1, item.value.date, item.value.channel, item.value.trauma, item.value.consultations,item.value.pneumonia,item.value.diarrhoea,item.value.iDP,item.value.id].map((e) => e.toString()).toList()).toList();
            //itemList.add([" "]);
          });
        });

      }else if (widget.indexOfTab == 1){
        helper.getAllDistributionDataFromDB().then((value) {
          distributionVo = value;
          setState(() {
            itemList = distributionVo.asMap()
                .entries.map((item) => [item.key + 1, item.value.date, item.value.distribution, item.value.beneficiary, item.value.item1,item.value.item2,item.value.item3,item.value.household,item.value.id].map((e) => e.toString()).toList()).toList();
            //itemList.add([" "]);
          });
        });

      }else if (widget.indexOfTab == 2) {
        helper.getAllHEDataFromDB().then((value) {
          heVo = value;
          setState(() {
            itemList = heVo
                .asMap()
                .entries
                .map((item) =>
                [
                  item.key + 1,
                  item.value.date,
                  item.value.presenterName,
                  item.value.position,
                  item.value.attendedName,
                  item.value.age,
                  item.value.gender,
                  item.value.disability,
                  item.value.id
                ].map((e) => e.toString()).toList())
                .toList();
            //itemList.add([" "]);
          });
        });
      }else{
        helper.getAllReferralDataFromDB().then((value) {
          referralVo = value;
          setState(() {
            itemList = referralVo.asMap()
                .entries.map((item) => [item.key + 1,
            item.value.date,
              item.value.name,
            item.value.age,
              item.value.gender,
              item.value.disability,
              item.value.relocation,item.value.referralType,item.value.id].map((e) => e.toString()).toList()).toList();
            //itemList.add([" "]);
          });
        });
      }
    }
    else{
      titleList = [];
      itemList = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        backgroundColor: AppTheme.secondaryColor,
        title: Row(
          children: [
            Image.asset(
              AppTheme.kInsuranceLogo,
              width: 50,
              height: 50,
            ),
            const SizedBox(
              width: 30,
            ),
            const Text(
              "REACH Collect",
              style: AppTheme.navigationTitleStyle,
            ),
          ],
        ),
      ),
      backgroundColor: AppTheme.whiteColor,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Side Bar
          Expanded(
            flex: 1,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.15,
              color: AppTheme.primaryColor,
              child: SidebarListItemView(sideItemSelected: (int value) {
                setState(() {
                  widget.selectedSideIndex = value;
                  widget.indexOfTab = 0;
                  reloadData();
                });
              }, selectedIndex: widget.selectedSideIndex,),
            ),
          ),


          Expanded(
              flex: 4,
              child: Container(
                color: Colors.white,
                child: SizedBox(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [

                        if (widget.selectedSideIndex == 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:  EdgeInsets.only(top: 20),
                                  child: DefaultTabController(
                                    initialIndex: widget.indexOfTab,
                                    length: rmnchList.length,
                                    child: TabBar(
                                        onTap: (value) {
                                          setState(() {
                                            widget.indexOfTab = value;
                                            //widget.tab(value);
                                            reloadData();
                                          });
                                        },
                                        tabAlignment: TabAlignment.start,
                                        isScrollable: true,
                                        dividerColor: Colors.white,
                                        tabs: rmnchList
                                            .map((e) => Tab(
                                          child: Text(e),
                                        ))
                                            .toList()),
                                  ),
                                ),
                              ),
                              CustomButton(
                                buttonHeight: 35,
                                label: 'New',
                                iconName: AppTheme.kPlusIcon,
                                width: 120,
                                onPressed: () {
                                  if (widget.indexOfTab == 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                            const AcmRegisterScreen()));
                                  }else if(widget.indexOfTab ==1 ){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                            const DeliveryRegisterScreen()));
                                  }else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                            const SRHRegisterScreen()));
                                  }
                                },

                              )
                            ],
                          )
                        else if (widget.selectedSideIndex == 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:  EdgeInsets.only(top: 20),
                                  child: DefaultTabController(
                                    initialIndex: widget.indexOfTab,
                                    length: consultationList.length,
                                    child: TabBar(
                                        onTap: (value) {
                                          setState(() {
                                            widget.indexOfTab = value;
                                            //widget.tab(value);
                                            reloadData();
                                          });
                                        },
                                        tabAlignment: TabAlignment.start,
                                        isScrollable: true,
                                        dividerColor: Colors.white,
                                        tabs: consultationList
                                            .map((e) => Tab(
                                          child: Text(e),
                                        ))
                                            .toList()),
                                  ),
                                ),
                              ),
                              CustomButton(
                                buttonHeight: 35,
                                label: 'New',
                                iconName: AppTheme.kPlusIcon,
                                width: 120,
                                onPressed: () {
                                  if (widget.indexOfTab == 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                            const EPIRegister()));
                                  }else if(widget.indexOfTab ==1 ){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                            const MUACRegister()));
                                  }else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                            const PNURegister()));
                                  }
                                },
                              )
                            ],
                          )
                        else if (widget.selectedSideIndex == 3)
                          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.only(top: 20),
                  child: DefaultTabController(
                    initialIndex: widget.indexOfTab,
                    length: summaryList.length,
                    child: TabBar(
                        onTap: (value) {
                          setState(() {
                            widget.indexOfTab = value;
                            //widget.tab(value);
                            reloadData();
                          });
                        },
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        dividerColor: Colors.white,
                        tabs: summaryList
                            .map((e) => Tab(
                          child: Text(e),
                        ))
                            .toList()),
                  ),
                ),
              ),
              CustomButton(
                buttonHeight: 35,
                label: 'New',
                iconName: AppTheme.kPlusIcon,
                width: 120,
                onPressed: () {
                  if (widget.indexOfTab == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) =>
                            const ConsultationRegister()));
                  }else if(widget.indexOfTab == 1 ){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) =>
                            const DistributionRegister()));
                  }else if(widget.indexOfTab == 2 ){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) =>
                            const HealthEducationRegister()));
                  }else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) =>
                            const ReferralRegister()));
                  }
                },
              )
            ],
          )
                        else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:  EdgeInsets.only(top: 20),
                                    child: DefaultTabController(
                                      initialIndex: widget.indexOfTab,
                                      length: ihrpList.length,
                                      child: TabBar(
                                          onTap: (value) {
                                            setState(() {
                                              widget.indexOfTab = value;
                                              //widget.tab(value);
                                              reloadData();
                                            });
                                          },
                                          tabAlignment: TabAlignment.start,
                                          isScrollable: true,
                                          dividerColor: Colors.white,
                                          tabs: ihrpList
                                              .map((e) => Tab(
                                            child: Text(e),
                                          ))
                                              .toList()),
                                    ),
                                  ),
                                ),
                                CustomButton(
                                  buttonHeight: 35,
                                  label: 'New',
                                  iconName: AppTheme.kPlusIcon,
                                  width: 120,
                                  onPressed: () {
                                    if (widget.indexOfTab == 0) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                              const MalariaRegister()));
                                    }else if(widget.indexOfTab == 1 ){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                              const TBReferralRegister()));
                                    }else if(widget.indexOfTab == 2 ){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                              const TBScreenRegister()));
                                    }else if(widget.indexOfTab == 3 ){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                              const TBIndividualRegister()));
                                    }else if(widget.indexOfTab == 4 ){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                              const HIVRegister()));
                                    }else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                              const ARTRegister()));
                                    }
                                  },
                                )
                              ],
                            ),

                        //divider
                        const Divider(),
                        //
                        titleList.isNotEmpty ? Table(
                          border: TableBorder.symmetric(inside: BorderSide.none,outside: BorderSide.none),
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: titleList.map((row) {
                            return TableRow(
                              decoration: BoxDecoration(color: AppTheme.secondaryColor),
                              children: row.asMap()
                                  .entries.map((cell) {
                                return TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: cell.key == (cell.value.length - 1) ? Container(
                                      color: Colors.redAccent,
                                    ) : Text(
                                      cell.value,
                                      style: AppTheme.headerTextStyle,
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }).toList(),
                        ) : Center(child: Text('No Data Found.'),),
                        itemList.isNotEmpty ? Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Table(
                                border: TableBorder.symmetric(inside: BorderSide.none,outside: BorderSide(color: AppTheme.secondaryColor)),//TableBorder.all(color: Colors.white),
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children:  itemList.asMap()
                                    .entries.map((row) {
                                  return TableRow(
                                    decoration: (row.key%2) == 0 ? BoxDecoration(color: Colors.white) : BoxDecoration(color: AppTheme.primaryColor),
                                    children: row.value.asMap()
                                        .entries.map((cell) {
                                      return TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                                          child: (itemList[row.key].length - 1) == cell.key ? Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              InkWell(
                                                onTap: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) => AlertDialog(
                                                      title: const Text('Are you sure want to delete?'),
                                                      content: const Text('This data remove from data record.'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                                          child: const Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: (){

                                                            try {

                                                              if (widget.selectedSideIndex == 0) {
                                                                if (widget.indexOfTab == 0) {
                                                                  helper.deleteANCFromDB(int.parse(cell.value));
                                                                }else if(widget.indexOfTab == 1){
                                                                  helper.deleteDeliveryFromDB(int.parse(cell.value));
                                                                }else{
                                                                  helper.deleteSRHFromDB(int.parse(cell.value));
                                                                }
                                                              }else if (widget.selectedSideIndex == 1){
                                                                if (widget.indexOfTab == 0) {
                                                                  helper.deleteEPIFromDB(int.parse(cell.value));
                                                                }else if(widget.indexOfTab == 1){
                                                                  helper.deleteMUACFromDB(int.parse(cell.value));
                                                                }else{
                                                                  helper.deletePNUFromDB(int.parse(cell.value));
                                                                }
                                                              }else{
                                                                if (widget.indexOfTab == 0) {
                                                                  helper.deleteConsultationFromDB(int.parse(cell.value));
                                                                }else if(widget.indexOfTab == 1){
                                                                  helper.deleteDistributionFromDB(int.parse(cell.value));
                                                                }else if(widget.indexOfTab == 2){
                                                                  helper.deleteHEFromDB(int.parse(cell.value));
                                                                }else{
                                                                  helper.deleteReferralFromDB(int.parse(cell.value));
                                                                }
                                                              }
                                                              reloadData();
                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                  content: Center(
                                                                    child: Text('Delete data successfully!'),
                                                                  )));
                                                            } catch (e) {
                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                  content: Center(
                                                                    child: Text('Delete Fail!!'),
                                                                  )));
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Text('OK'),
                                                        ),
                                                      ],
                                                    ),
                                                  );




                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(8,8,0,0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    color: Colors.red,
                                                    padding: EdgeInsets.all(8.0),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.delete,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              InkWell(
                                                onTap: () {
                                                  if (widget.selectedSideIndex == 0) {
                                                    if (widget.indexOfTab == 0) {
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditANC(reachCollectVo: ancVo[row.key])));
                                                    }
                                                    if (widget.indexOfTab == 1){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditDelivery(deliveryVo: deliveryVo[row.key])));
                                                    }

                                                    if (widget.indexOfTab == 2){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditSRH(srhVo: srHVo[row.key])));
                                                    }
                                                  }
                                                  else if (widget.selectedSideIndex == 1){
                                                    if (widget.indexOfTab == 0) {
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditEPI(reachCollectVo: epiVo[row.key])));
                                                    }
                                                    if (widget.indexOfTab == 1){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditMUAC(reachCollectVo: muacVo[row.key])));
                                                    }

                                                    if (widget.indexOfTab == 2){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditPNU(reachCollectVo: pnuVo[row.key])));
                                                    }
                                                  }
                                                  else{
                                                    if (widget.indexOfTab == 0) {
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditConsultation(reachCollectVo: consultationVo[row.key])));
                                                    }
                                                    if (widget.indexOfTab == 1){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditDistribution(reachCollectVo: distributionVo[row.key])));
                                                    }

                                                    if (widget.indexOfTab == 2){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditHE(reachCollectVo: heVo[row.key])));
                                                    }
                                                    if (widget.indexOfTab == 3){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditReferral(reachCollectVo: referralVo[row.key])));
                                                    }
                                                  }

                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(8,8,0,0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    color: AppTheme.thirdColor,
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.remove_red_eye,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),



                                            ],
                                          ) : Text(
                                            cell.value,
                                            style: AppTheme.itemTextStyle,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }).toList(),

                              )],
                          ),
                        ) : Center(child: Text(''),)


                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),

    );
  }
}
