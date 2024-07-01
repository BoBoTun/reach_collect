import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reach_collect/data/model/distribution_model.dart';

import '../../network/presistance/SQLiteHelper.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_styles.dart';
import '../../utils/preference_keys.dart';
import '../../utils/share_preference.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_dropdown_widget.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/month_picker.dart';
import '../home_screen.dart';

class DistributionRegister extends StatefulWidget {
  const DistributionRegister({super.key});

  @override
  State<DistributionRegister> createState() => _DistributionRegisterState();
}

class _DistributionRegisterState extends State<DistributionRegister> {

  String date = '';
  String attendedby = '';
  String reportingPeriod = '';
  String channel = '';
  String todayDateString = '';
  String beneficiary = '';
  String distribution = '';


  TextEditingController nameController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController clinicTeamController = TextEditingController();

  TextEditingController item1Controller = TextEditingController();
  TextEditingController item2Controller = TextEditingController();
  TextEditingController item3Controller = TextEditingController();

  TextEditingController householdController = TextEditingController();


  TextEditingController under18M = TextEditingController();
  TextEditingController under18F = TextEditingController();

  TextEditingController over18M = TextEditingController();
  TextEditingController over18F = TextEditingController();

  TextEditingController idpM = TextEditingController();
  TextEditingController idpF = TextEditingController();

  TextEditingController disabilityM = TextEditingController();
  TextEditingController disabilityF = TextEditingController();


  final SQLiteHelper helper = SQLiteHelper();



  @override
  void initState() {
    super.initState();

    DateTime todayDate = DateTime.now();

    date = "${todayDate.toLocal()}".split(' ')[0];
    //tdSelectedDate = "${todayDate.toLocal()}".split(' ')[0];
    todayDateString = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);

    clinicTeamController.text = PreferenceManager.getString(CLINIC) ?? '';
    channel = PreferenceManager.getString(CHANNEL) ?? '';
    reportingPeriod = PreferenceManager.getString(REPORT_PERIOD) ?? date;

    attendedby = AppConstants.attandedList[0];
    distribution = AppConstants.distributionList[0];
    beneficiary = AppConstants.beneficiaryList[0];



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
                "Distribution Register",
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
                          'Distribution Type',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {
                          distribution = value;
                        }, options: AppConstants.distributionList, currentValue: distribution.isEmpty ? AppConstants.distributionList[0] : distribution,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Beneficiary Type',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {
                          beneficiary = value;
                        }, options: AppConstants.beneficiaryList, currentValue: beneficiary.isEmpty ? AppConstants.beneficiaryList[0] : beneficiary,),
                      ],
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
                        const Text(
                          'Item 1',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Item 1', 1, item1Controller,10000),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Item 2',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Item 2', 1, item2Controller,10000),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Item 3',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Item 3', 1, item3Controller,10000),
                      ],
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
                        const Text(
                          '# of Household',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('# of Household', 1, householdController,10000),
                      ],
                    ),

                  ],
                ),

                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //U5 Pneumonia
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '<18 yr>',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            small_inputBox('M', 1, under18M,100),
                            SizedBox(width: 10,),
                            small_inputBox('F', 1, under18F,100),
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: 25,),
                    //U5 Diarrhoea
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '>=18 yr',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            small_inputBox('M', 1, over18M,100),
                            SizedBox(width: 10,),
                            small_inputBox('F', 1, over18F,100),
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: 25,),
                    //IDP
                    Column(
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

                        Row(
                          children: [
                            small_inputBox('M', 1, idpM,100),
                            SizedBox(width: 10,),
                            small_inputBox('F', 1, idpF,100),
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: 25,),
                    //Disability
                    Column(
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

                        Row(
                          children: [
                            small_inputBox('M', 1, disabilityM,100),
                            SizedBox(width: 10,),
                            small_inputBox('F', 1, disabilityF,100),
                          ],
                        )
                      ],
                    )
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
                  height: 20,
                ),
                //button
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: ButtonWidget(
                        buttonText: 'Save',
                        onPressed: () {
                          /*
                          if (nameController.text.isEmpty ) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Center(
                                  child: Text('Sorry!! Please input empty fields'),
                                )));
                          }
                          */
                          //Add To DB
                          DistributionVo dataVo = DistributionVo(
                              tableName : AppConstants.consultationTable,
                              orgName: PreferenceManager.getString(ORG),
                              stateName: PreferenceManager.getString(STATE),
                              townshipName: PreferenceManager.getString(REGION),
                              townshipLocalName: PreferenceManager.getString(REGION_LOCAL),
                              clinic: clinicTeamController.text,
                              reportingPeroid: reportingPeriod,
                              date: date,
                              distribution: distribution,
                              beneficiary: beneficiary,
                              item1: item1Controller.text,
                              item2: item2Controller.text,
                              item3: item3Controller.text,
                              household: householdController.text,
                              under18: "${under18M.text}|${under18F.text}",
                              over18: "${over18M.text}|${over18F.text}",
                              iDP: "${idpM.text}|${idpF.text}",
                              disability: "${disabilityM.text}|${disabilityF.text}",
                              remark: remarkController.text,
                              createDate: todayDateString,
                              updateDate: todayDateString
                          );

                          try {
                            PreferenceManager.setString(CLINIC, clinicTeamController.text);
                            PreferenceManager.setString(CHANNEL, channel);
                            PreferenceManager.setString(REPORT_PERIOD, reportingPeriod);
                            //  DatabaseProvider provider = DatabaseProvider.db;
                            // provider.insertACNDataToDB(dataVo);
                            helper.insertDistributionDataToDB(dataVo,false);

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        HomeScreen(indexOfTab: 1, selectedSideIndex: 2,)));
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Center(
                                  child: Text('Something wrong!!'),
                                )));
                          }

                          //End add to DB
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

  SizedBox small_inputBox(
      String title, int maxlines, TextEditingController controller, int limit) {

    return SizedBox(
      width: 80,
      height: 50,
      child: TextField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(5),
        ],
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          labelText: title,
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
        child: TextField(
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

