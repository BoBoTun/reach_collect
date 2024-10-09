import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../data/model/anc_model.dart';
import '../../network/presistance/SQLiteHelper.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_styles.dart';
import '../../utils/preference_keys.dart';
import '../../utils/share_preference.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_dropdown_widget.dart';
import '../../widgets/custom_radio.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/male_female_radio.dart';
import '../../widgets/month_picker.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/tdDropdown.dart';
import '../home_screen.dart';
class TBScreenRegister extends StatefulWidget {
  const TBScreenRegister({super.key});

  @override
  State<TBScreenRegister> createState() => _TBScreenRegisterState();
}

class _TBScreenRegisterState extends State<TBScreenRegister> {
  //data var
  String date = '';
  String disability = 'Yes';
  String idp = 'Yes';
  String attendedby = '';
  String outcome = '';
  String reportingPeriod = '';
  String tdSelectString = '';
  String tdSelectedDate = '';
  String channel = '';
  String todayDateString = '';
  String tvContact = 'Yes';
  String sex = 'Male';
  String symptoms = '';


  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController referredFromController = TextEditingController();
  TextEditingController gravidaController = TextEditingController();
  TextEditingController parityController = TextEditingController();
  TextEditingController findingsController = TextEditingController();
  TextEditingController treatmentController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController clinicTeamController = TextEditingController();
  TextEditingController nOfANCVisitController = TextEditingController();
  TextEditingController tbResultController = TextEditingController();
  TextEditingController regNumController = TextEditingController();

  final SQLiteHelper helper = SQLiteHelper();


  @override
  void initState() {
    super.initState();

    DateTime todayDate = DateTime.now();

    date = "${todayDate.toLocal()}".split(' ')[0];
    tdSelectedDate = "${todayDate.toLocal()}".split(' ')[0];
    todayDateString = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);

    clinicTeamController.text = PreferenceManager.getString(CLINIC) ?? '';
    channel = AppConstants.channelList[0];

    reportingPeriod = PreferenceManager.getString(REPORT_PERIOD) ?? date;

    attendedby = AppConstants.attandedList[0];
    outcome = AppConstants.outcomeList[0];

    tdSelectString = '1st';


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
                "TB Screening Register",
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
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                //disability session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Referred from',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Referred from', 1, referredFromController,200),
                      ],
                    ),


                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TB Contact',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: CustomRadioButton(
                                radioValue: (String value) {
                                  tvContact = value;
                                },
                                activeValue: tvContact, radioList: const ['Yes','No'],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                //ges week
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    //dorp down
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Symptoms',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250,
                          value: (String value, int index) { symptoms = value; }, options: AppConstants.tbSymptomsList, currentValue: AppConstants.tbSymptomsList[0],),
                      ],
                    ),
                  ],
                ),


                const SizedBox(
                  height: 40,
                ),

                //Row 4
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                'Examination Result',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),

                              Text(
                                'S',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          halfInputBox('အ‌ဖြေ‌ရေးရန်', nameController,5),
                        ],
                      ),
                    ),

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'CXR',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),

                          halfInputBox('အ‌ဖြေ‌ရေးရန်', nameController,5),
                        ],
                      ),
                    ),

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'X',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),

                          halfInputBox('အ‌ဖြေ‌ရေးရန်', nameController,5),
                        ],
                      ),
                    ),

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'T',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),

                          halfInputBox('အ‌ဖြေ‌ရေးရန်', nameController,5),
                        ],
                      ),
                    ),

                  ],
                ),
                const SizedBox(
                  height: 40,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Result(1-3)',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Result(1-3)', 1, tbResultController,200),
                      ],
                    ),


                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TPT (6H/3HP/No)',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: CustomRadioButton(
                                radioValue: (String value) {
                                  tvContact = value;
                                },
                                activeValue: tvContact, radioList: const ['Yes','No'],
                              )),
                      inputBox('', 1, tbResultController,200)
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Reg No.',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Reg No.', 1, regNumController,200),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 40,
                ),

                //attended
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Remark',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Remark', 3, remarkController,10000),
                      ],
                    ),
                  ],
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
                                  referredFromController.text.isEmpty||
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
                                var gestation = int.parse(referredFromController.text);
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
                                            gestational: referredFromController.text,
                                            gravida: gravidaController.text,
                                            parity: parityController.text,
                                            noOfANC: nOfANCVisitController.text,
                                            td: tdSelectString,
                                            findings: findingsController.text,
                                            treatment: treatmentController.text,
                                            ancfour: tvContact,
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

Container halfInputBox(
    String title, TextEditingController controller, int limit) {
  return Container(
    height: 50,
    width: 170,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
        ]),
    child: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: TextField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(limit),
        ],
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: title,
            hintStyle: const TextStyle(color: Colors.grey)),
      ),

    ),
  );
}
