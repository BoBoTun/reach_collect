import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reach_collect/data/model/tb_followup_model.dart';
import 'package:reach_collect/screens/tb_followup_screen.dart';

import '../../data/model/anc_model.dart';
import '../../network/presistance/SQLiteHelper.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_styles.dart';
import '../../utils/preference_keys.dart';
import '../../utils/share_preference.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown_widget.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/male_female_radio.dart';
import '../../widgets/month_picker.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/tdDropdown.dart';
import '../home_screen.dart';
class TBIndividualRegister extends StatefulWidget {
  const TBIndividualRegister({super.key});

  @override
  State<TBIndividualRegister> createState() => _TBIndividualRegisterState();
}

class _TBIndividualRegisterState extends State<TBIndividualRegister> {
  //data var
  String date = '';
  String tbStartdate = '';
  String tbEnddate = '';
  String disability = 'Yes';
  String idp = 'Yes';
  String attendedby = '';
  String outcome = '';
  String reportingPeriod = '';
  String tdSelectString = '';
  String tdSelectedDate = '';
  String channel = '';
  String todayDateString = '';
  String ancFour = 'Yes';
  String transferIn = 'Yes';
  String sex = 'Male';
  String hivStatus = '';
  String testingdate = '';

  String typeOfPatient = '';
  String typeOfDisease = '';
  String tbTreatmentRegimen = '';
  String dmStatus = '';
  String tbHIVStatus = '';
  String tbTreatmentStartdate = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController gestationalWeekController = TextEditingController();
  TextEditingController gravidaController = TextEditingController();
  TextEditingController parityController = TextEditingController();
  TextEditingController findingsController = TextEditingController();
  TextEditingController treatmentController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController clinicTeamController = TextEditingController();
  TextEditingController nOfANCVisitController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController treatmentRegimenController = TextEditingController();
  TextEditingController doseController = TextEditingController();

  final SQLiteHelper helper = SQLiteHelper();
  List<List<String>> titleList = [['']];
  List<List<String>> itemList = [['']];
  List<TBFollowUpVo> followUpVo = [];

  @override
  void initState() {
    super.initState();

    reloadData();
    DateTime todayDate = DateTime.now();

    titleList = AppConstants.tbFollowupList;

    print("TITLE LISt $titleList");
    date = "${todayDate.toLocal()}".split(' ')[0];
    tdSelectedDate = "${todayDate.toLocal()}".split(' ')[0];
    tbStartdate = "${todayDate.toLocal()}".split(' ')[0];
    tbEnddate = "${todayDate.toLocal()}".split(' ')[0];
    testingdate = "${todayDate.toLocal()}".split(' ')[0];
    tbTreatmentStartdate = "${todayDate.toLocal()}".split(' ')[0];
    todayDateString = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);

    clinicTeamController.text = PreferenceManager.getString(CLINIC) ?? '';
    channel = AppConstants.channelList[0];

    reportingPeriod = PreferenceManager.getString(REPORT_PERIOD) ?? date;

    attendedby = AppConstants.attandedList[0];
    outcome = AppConstants.outcomeList[0];
    hivStatus = AppConstants.hivStatusList[0];

    tdSelectString = '1st';


  }

  void reloadData() {
    helper.getAllTBFollowUpFromDB().then((value) {
      followUpVo = value;
      setState(() {

        itemList = followUpVo.asMap()
            .entries.map((item) => [item.value.date, item.value.s, item.value.x, item.value.t,item.value.latNo,item.value.remark,item.value.id].map((e) => e.toString()).toList()).toList();

        print("ITEM LIST SIZE :: ${itemList.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        backgroundColor: AppTheme.secondaryColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Row(
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
                "TB Treatment Register",
                style: AppTheme.navigationTitleStyle,
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  AppTheme.kBackIcon,
                  width: 60,
                  height: 60,
                )),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.primaryColor),
        child: Padding(
          padding:
          const EdgeInsets.only(left: 80, top: 30, bottom: 14, right: 80),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),

                //pre session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Clinic/Team',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Clinic/Team', 1, clinicTeamController,10000),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Channel',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {
                          channel = value;
                        }, options: AppConstants.channelList, currentValue: channel.isEmpty ? AppConstants.channelList[0] : channel,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reporting Period',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MonthPicker(dateString: (dateString) {
                          reportingPeriod = dateString;
                        },
                          updateDateString: reportingPeriod,
                        ),

                      ],
                    ),

                    //channel
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //line
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),

                const SizedBox(
                  height: 20,
                ),

                //date picker session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Name', 1, nameController,10000),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Registration No.',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Registration No.', 1, nameController,10000),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            date = dateString;
                          },
                          updateDateString: date,
                        ),
                      ],
                    ),



                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                //disability session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //age
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Age (number only)',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Age (number only)', 1, ageController,3),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sex',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: SexRadioButton(
                                radioValue: (String value) {
                                  sex = value;
                                },
                                activeValue: sex,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Disability',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: HorizontalRadioButton(
                                radioValue: (String value) {
                                  disability = value;
                                },
                                activeValue: disability,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                //ges week
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'IDP',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: HorizontalRadioButton(
                                radioValue: (String value) {
                                  idp = value;
                                },
                                activeValue: idp,
                              )),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Address',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Address', 1, addressController,10000),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Phone',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Phone', 1, phoneController,10000),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                //line
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
                //For TPT case
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'For TPT case',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Treatment regimen',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Treatment regimen', 1, treatmentRegimenController,10000),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Start Date',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            tbStartdate = dateString;
                          },
                          updateDateString: tbStartdate,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dose',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Dose', 1, doseController,10000),
                      ],
                    ),

                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'End Date',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            tbEnddate = dateString;
                          },
                          updateDateString: tbEnddate,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'HIV status',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {
                          hivStatus = value;
                        }, options: AppConstants.hivStatusList, currentValue: hivStatus.isEmpty ? AppConstants.hivStatusList[0] : hivStatus,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'HIV testing date',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            testingdate = dateString;
                          },
                          updateDateString: testingdate,
                        ),
                      ],
                    ),

                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                //line
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
                //For TB case
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'For TB case',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Type of Patient',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {
                          typeOfPatient = value;
                        }, options: AppConstants.tbPatientTypeList, currentValue: typeOfPatient.isEmpty ? AppConstants.tbPatientTypeList[0] : typeOfPatient,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Type of Disease',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {
                          typeOfDisease = value;
                        }, options: AppConstants.tbDiseaseList, currentValue: typeOfDisease.isEmpty ? AppConstants.tbDiseaseList[0] : typeOfDisease,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Treatment regimen',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {
                          tbTreatmentRegimen = value;
                        }, options: AppConstants.tbTreatmentRegimenList, currentValue: tbTreatmentRegimen.isEmpty ? AppConstants.tbTreatmentRegimenList[0] : tbTreatmentRegimen,),
                      ],
                    ),

                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Treatment started date',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            tbTreatmentStartdate = dateString;
                          },
                          updateDateString: tbTreatmentStartdate,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DM Status',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {
                          dmStatus = value;
                        }, options: AppConstants.tbDMStatusList, currentValue: dmStatus.isEmpty ? AppConstants.tbDMStatusList[0] : dmStatus,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'HIV Status',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {
                          tbHIVStatus = value;
                        }, options: AppConstants.hivStatusList, currentValue: tbHIVStatus.isEmpty ? AppConstants.hivStatusList[0] : tbHIVStatus,),
                      ],
                    ),

                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'HIV testing date',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            testingdate = dateString;
                          },
                          updateDateString: testingdate,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Transfer in',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: HorizontalRadioButton(
                                radioValue: (String value) {
                                  transferIn = value;
                                },
                                activeValue: transferIn,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(width: 250,)

                  ],
                ),

                //Follow up visits
                const SizedBox(
                  height: 10,
                ),
                //line
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Follow up visits',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                if (itemList.length == 0) const Center(child: Text(''),) else Table(
                  border: TableBorder.symmetric(inside: BorderSide.none,outside: BorderSide.none),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: titleList.map((row) {
                    return TableRow(
                      decoration: BoxDecoration(color: AppTheme.secondaryColor),
                      children: row.asMap()
                          .entries.map((cell) {
                        return TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                ),
                itemList.isEmpty ?  const Center(child: Text(''),) : ListView(
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

                                                  helper.deleteFollowUpFromDB(int.parse(cell.value));

                                                  reloadData();

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

                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      buttonHeight: 35,
                      label: 'Add New Follow up',
                      iconName: AppTheme.kPlusIcon,
                      width: 200,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    TBFollowUp())
                        ).then((value) {
                          print("After navigate pop ....");
                          //reloadData();
                        });

                      },

                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                //line
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
                const SizedBox(
                  height: 40,
                ),
                //button
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(
                            buttonText: 'Cancel',
                            type: 1,
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        SizedBox(width: 20,),
                        ButtonWidget(
                            buttonText: 'Save',
                            type: 0,
                            onPressed: () {
                              if (nameController.text.isEmpty||
                                  ageController.text.isEmpty ||
                                  gestationalWeekController.text.isEmpty||
                                  gravidaController.text.isEmpty ||
                                  parityController.text.isEmpty ||
                                  findingsController.text.isEmpty ||
                                  treatmentController.text.isEmpty ||
                                  attendedby.isEmpty ||
                                  outcome.isEmpty ||
                                  clinicTeamController.text.isEmpty ||
                                  reportingPeriod.isEmpty ||
                                  channel.isEmpty ||
                                  tdSelectString.isEmpty ) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Center(
                                      child: Text('Sorry!! Please input empty fields'),
                                    )));
                              } else {
                                //Check Validation for Age
                                var age = int.parse(ageController.text);
                                var gestation = int.parse(gestationalWeekController.text);
                                var gravida = int.parse(gravidaController.text);
                                var parity = int.parse(parityController.text);
                                if (age > 0 && age < 101) {

                                  if (gestation > 0 && gestation < 43){

                                    if (gravida > 0 && gravida < 21){

                                      if (parity > -1 && parity < 21){

                                        //Add To DB
                                        ANCVo dataVo = ANCVo(
                                            tableName: AppConstants.ancTable,
                                            orgName: PreferenceManager.getString(ORG),
                                            stateName: PreferenceManager.getString(STATE),
                                            townshipName: PreferenceManager.getString(REGION),
                                            townshipLocalName: PreferenceManager.getString(REGION_LOCAL),
                                            clinic: clinicTeamController.text,
                                            channel: channel,
                                            reportingPeroid: reportingPeriod,
                                            date: date,
                                            name: nameController.text,
                                            age: ageController.text,
                                            disability: disability,
                                            idp: idp,
                                            gestational: gestationalWeekController.text,
                                            gravida: gravidaController.text,
                                            parity: parityController.text,
                                            noOfANC: nOfANCVisitController.text,
                                            td: tdSelectString,
                                            findings: findingsController.text,
                                            treatment: treatmentController.text,
                                            ancfour: ancFour,
                                            attended: attendedby,
                                            outcome: outcome,
                                            remark: remarkController.text,
                                            createDate: todayDateString,
                                            updateDate: todayDateString);

                                        try {
                                          PreferenceManager.setString(CLINIC, clinicTeamController.text);
                                          PreferenceManager.setString(CHANNEL, channel);
                                          PreferenceManager.setString(REPORT_PERIOD, reportingPeriod);
                                          //  DatabaseProvider provider = DatabaseProvider.db;
                                          // provider.insertACNDataToDB(dataVo);
                                          helper.insertACNDataToDB(dataVo,false);

                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      HomeScreen(indexOfTab: 0, selectedSideIndex: 0,)));
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                              content: Center(
                                                child: Text('Something wrong!!'),
                                              )));
                                        }

                                        //End add to DB


                                      }else{
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            content: Center(
                                              child: Text('Parity should be 0 to 20 !!!'),
                                            )));

                                      }


                                    }else{
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                          content: Center(
                                            child: Text('Gravida should be 1 to 20 !!!'),
                                          )));
                                    }



                                  }else{
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Center(
                                          child: Text('Gestational Week should be 1 to 42 weeks !!!'),
                                        )));
                                  }


                                }else{
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Center(
                                        child: Text('Age should be between 1 to 100 years !!!'),
                                      )));

                                }

                              }
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container inputBox(
      String title, int maxlines, TextEditingController controller, int limit) {
    return Container(
      height: maxlines == 1 ? 50 : 100,
      width: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: controller == ageController ||
            controller == gestationalWeekController ||
            controller == gravidaController ||
            controller == parityController ||
            controller == nOfANCVisitController
            ? TextField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(limit),
          ],
          controller: controller,
          maxLines: maxlines,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey)),
        )
            : TextField(
          controller: controller,
          maxLines: maxlines,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey)),
        ),

      ),
    );
  }

}
