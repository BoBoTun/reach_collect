import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reach_collect/data/model/anc_model.dart';
import 'package:reach_collect/data/model/delivery_model.dart';
import 'package:reach_collect/network/presistance/SQLiteHelper.dart';
import 'package:reach_collect/screens/home_screen.dart';
import 'package:reach_collect/utils/app_constant.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/utils/preference_keys.dart';
import 'package:reach_collect/utils/share_preference.dart';
import 'package:reach_collect/widgets/button_widget.dart';
import 'package:reach_collect/widgets/custom_dropdown_widget.dart';
import 'package:reach_collect/widgets/date_picker.dart';
import 'package:reach_collect/widgets/radio_button.dart';
import 'package:reach_collect/widgets/radio_button_live_birth.dart';

import '../../widgets/month_picker.dart';

// ignore: must_be_immutable
class DeliveryRegisterScreen extends StatefulWidget {
  const DeliveryRegisterScreen({super.key});

  @override
  State<DeliveryRegisterScreen> createState() => _DeliveryRegisterScreenState();
}

class _DeliveryRegisterScreenState extends State<DeliveryRegisterScreen> {
  final SQLiteHelper helper = SQLiteHelper();
  //data var
  String date = '';
  String disability = 'true';
  String idp = 'true';
  String attendedby = '';
  String outcome = '';
  String reportingPeriod = '';
  String channel = '';
  String tdComplete = 'true';
  String liveOrstill = 'Live birth';
  String neonatalRecursion = 'true';
  String breadFeeding = 'true';
  String todayDateString = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController gestationalWeekController = TextEditingController();
  TextEditingController gravidaController = TextEditingController();
  TextEditingController findingsController = TextEditingController();
  TextEditingController treatmentController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController clinicTeamController = TextEditingController();
  TextEditingController birthWeightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    DateTime todayDate = DateTime.now();

    date = "${todayDate.toLocal()}".split(' ')[0];

    clinicTeamController.text = PreferenceManager.getString(CLINIC) ?? '';
    channel = PreferenceManager.getString(CHANNEL) ?? '';
    reportingPeriod = PreferenceManager.getString(REPORT_PERIOD) ?? date;

    attendedby = AppConstants.attandedList[0];
    outcome = AppConstants.outcomeList[0];

    todayDateString = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);
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
                "Delivery Register",
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

                //date picker session
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
                        DropdownListView(
                          containerWidth: 250,
                          value: (String value, int index) {
                            channel = value;
                          },
                          options: AppConstants.channelList,
                          currentValue: channel.isEmpty
                              ? AppConstants.channelList[0]
                              : channel,
                        ),
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

                    //extra space
                    const SizedBox(
                      width: 250,
                    )
                  ],
                ),

                //ges week
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
                          'Gestational Week',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox(
                            'Gestational Week', 1, gestationalWeekController,2),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Gravida',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Gravida', 1, gravidaController,2),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TD complete',
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
                                  tdComplete = value;
                                },
                                activeValue: tdComplete,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
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
                            'Type(live birth/still birth)',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: LiveStillRadioButton(
                                radioValue: (String value) {
                                  liveOrstill = value;
                                },
                                activeValue: liveOrstill,
                              )),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Birth Weight',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Birth Weight', 1, birthWeightController,10),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Neonatal Resucition',
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
                                  neonatalRecursion = value;
                                },
                                activeValue: neonatalRecursion,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),
                //finding
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Breast Feeding in 30 minutes',
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
                                breadFeeding = value;
                              },
                              activeValue: breadFeeding,
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Treatment',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Treatment', 3, treatmentController,10000),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attended by',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownListView(
                          containerWidth: 250,
                          value: (String value, int index) {
                            attendedby = value;
                          },
                          options: AppConstants.attandedList,
                          currentValue: AppConstants.attandedList[0],
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                //attended
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //dorp down

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Outcome',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownListView(
                          containerWidth: 250,
                          value: (String value, int index) {
                            outcome = value;
                          },
                          options: AppConstants.outcomeList,
                          currentValue: AppConstants.outcomeList[0],
                        ),
                      ],
                    ),
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

                    const SizedBox(
                      width: 250,
                    )
                  ],
                ),

                const SizedBox(
                  height: 40,
                ),
                //button
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: ButtonWidget(
                        buttonText: 'Save',
                        onPressed: () {
                          if (nameController.text.isEmpty ||
                              ageController.text.isEmpty ||
                              clinicTeamController.text.isEmpty ||
                              gestationalWeekController.text.isEmpty ||
                              gravidaController.text.isEmpty ||
                              birthWeightController.text.isEmpty ||
                              treatmentController.text.isEmpty ||
                              channel.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Center(
                              child: Text('Sorry!! Please input empty fields'),
                            )));
                          } else {

                            var age = int.parse(ageController.text);
                            var gestation = int.parse(gestationalWeekController.text);
                            var gravida = int.parse(gravidaController.text);
                            var birthWeight = double.parse(birthWeightController.text);

                            if (age > 0 && age < 101){
                              if (gestation > 0 && gestation < 43){
                                if (gravida > 0 && gravida < 21){
                                  if (birthWeight > 0.0 && birthWeight < 15.0){

                                    DeliveryVo dataVo = DeliveryVo(
                                      tableName: AppConstants.deliveryTable,
                                        orgName: PreferenceManager.getString(ORG),
                                        stateName: PreferenceManager.getString(STATE),
                                        townshipName:
                                        PreferenceManager.getString(REGION),
                                        townshipLocalName:
                                        PreferenceManager.getString(REGION_LOCAL),
                                        clinic: clinicTeamController.text,
                                        channel: channel,
                                        reportingPeroid: reportingPeriod,
                                        date: date,
                                        name: nameController.text,
                                        age: ageController.text,
                                        disability: disability,
                                        iDP: idp,
                                        gestational: gestationalWeekController.text,
                                        gravida: gravidaController.text,
                                        tDComplete: tdComplete,
                                        birthType: liveOrstill,
                                        birthWeight: birthWeightController.text,
                                        neonatal: neonatalRecursion,
                                        breastfeeding: breadFeeding,
                                        treatment: treatmentController.text,
                                        attended: attendedby,
                                        outcome: outcome,
                                        remark: remarkController.text,
                                        createDate: todayDateString,
                                        updateDate: todayDateString
                                    );

                                    try {
                                      // DatabaseProvider provider = DatabaseProvider.db;
                                      helper.insertDeliveryDataToDB(dataVo,false);

                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                          builder: (builder) => HomeScreen(
                                            indexOfTab: 1, selectedSideIndex: 0,
                                          )));
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                          content: Center(
                                            child: Text('Something wrong!!'),
                                          )));
                                    }

                                  }else{
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Center(
                                          child: Text('Birth Weight should be 1 to 14 !!!'),
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
                        }),
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
        child: 
        controller == birthWeightController ?
        TextField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
            LengthLimitingTextInputFormatter(limit),
          ],
          controller: controller,
          maxLines: maxlines,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey)),
        ) :
        controller == ageController ||
                controller == gestationalWeekController ||
                controller == gravidaController
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
