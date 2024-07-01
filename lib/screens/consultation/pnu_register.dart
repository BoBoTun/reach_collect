import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:reach_collect/data/model/pnu_model.dart';
import '../../network/presistance/SQLiteHelper.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_styles.dart';
import '../../utils/preference_keys.dart';
import '../../utils/share_preference.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_dropdown_widget.dart';
import '../../widgets/custom_radio.dart';
import '../../widgets/date_picker.dart';
import 'package:dropdown_multi_select/dropdown_multi_select.dart';

import '../../widgets/month_picker.dart';
import '../home_screen.dart';

class PNURegister extends StatefulWidget {
  const PNURegister({super.key});

  @override
  State<PNURegister> createState() => _PNURegisterState();
}

class _PNURegisterState extends State<PNURegister> {
  //data var
  String date = '';
  String disability = 'Yes';
  String gender = 'ကျား';
  String disabled = 'Yes';
  String relocation = 'Yes';
  String bcgValue = '';
  String isPrevent = 'Yes';
  String handOverValue = '';

  String reportingPeriod = '';
  String channel = '';
  String todayDateString = '';
  String swelling = '';
  String patientType = '';

  String clinic = 'ဆေးခန်း';
  String referGo = 'Yes';

  String selectSymptomsList = '';
  String selectTypeOfDiseaseList = '';

  String amclin = 'အလုံး';


  TextEditingController clinicTeamController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  TextEditingController villageNameController = TextEditingController();
  TextEditingController volunteerNameController = TextEditingController();

  TextEditingController ageController = TextEditingController();
  TextEditingController treatmentPeriodController = TextEditingController();
  TextEditingController amoSislinController = TextEditingController();
  TextEditingController saltPackageContoller = TextEditingController();
  TextEditingController zincSulphateWholeController = TextEditingController();
  TextEditingController paracetamolWholeController = TextEditingController();

  late List<String> selectedValueList;


  final SQLiteHelper helper = SQLiteHelper();

  @override
  void initState() {
    super.initState();

    DateTime todayDate = DateTime.now();

    date = "${todayDate.toLocal()}".split(' ')[0];
    todayDateString = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);

    clinicTeamController.text = PreferenceManager.getString(CLINIC) ?? '';
    channel = PreferenceManager.getString(CHANNEL) ?? '';
    reportingPeriod = PreferenceManager.getString(REPORT_PERIOD) ?? date;

    handOverValue = AppConstants.handoverList[0];
    patientType = AppConstants.patientTypeList[0];

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
                "Pnu&Diarr Register",
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
                          'Clinic',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {
                          clinic = value;
                        }, options: AppConstants.clinicList, currentValue: clinic.isEmpty ? AppConstants.clinicList[0] : clinic,),

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ကျေးရွာအမည်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('ကျေးရွာအမည်', 1, villageNameController,10000),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'စေတနာ့ဝန်ထမ်းအမည်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('စေတနာ့ဝန်ထမ်းအမည်', 1, volunteerNameController,10000),
                      ],
                    ),

                    //channel
                  ],
                ),
                //pre session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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

                //Row 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ရက်စွဲ',
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
                    //Name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'အမည်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('အမည်', 1, nameController,10000),
                      ],
                    ),
                    //Age
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'အသက်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('အသက်', 1, ageController,3),
                      ],
                    ),

                  ],
                ),
                const SizedBox(
                  height: 40,
                ),

                //Row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Gender
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ကျား/မ',
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
                                  gender = value;
                                },
                                activeValue: gender, radioList: ['ကျား','မ'],
                              )),
                        ],
                      ),
                    ),
                    //Disabled
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'မသန်စွမ်းသူ',
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
                                  disabled = value;
                                },
                                activeValue: disabled, radioList: const ['Yes','No'],
                              )),
                        ],
                      ),
                    ),
                    //Relocation
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ရွှေ့ပြောင်း နေထိုင်သူ',
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
                                  relocation = value;
                                },
                                activeValue: relocation, radioList: ['Yes','No'],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 40,
                ),

                //Row 3
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'လူနာအမျိုးအစား',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250,
                          value: (String value, int index) { patientType = value; }, options: AppConstants.patientTypeList, currentValue: AppConstants.patientTypeList[0],),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ရောဂါလက္ခဏာ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
                              ]),
                          child:MultiSelectDropdown.simpleList(
                            list: AppConstants.symptomsList,
                            initiallySelected: const [],
                            onChange: (newList) {
                              // your logic
                              selectSymptomsList = newList.join('||');
                            },
                            includeSearch: true,
                            includeSelectAll: true,
                            isLarge: true, // Modal size will be a little large
                            // Give a definite width when rendering this widget in a row
                            width: 250, // Must be a definite number
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ရောဂါအမျိုးအစား',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
                              ]),
                          child:MultiSelectDropdown.simpleList(
                            list: AppConstants.typeOfDiseaseList,
                            initiallySelected: const [],
                            onChange: (newList) {
                              // your logic
                              selectTypeOfDiseaseList = newList.join('||');
                            },
                            includeSearch: true,
                            includeSelectAll: true,
                            isLarge: false, // Modal size will be a little large
                            // Give a definite width when rendering this widget in a row
                            width: 250, // Must be a definite number
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
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
                                'ကုသမှု',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'အမောက်စီစလင်',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: CustomRadioButton(
                                radioValue: (String value) {
                                  amclin = value;
                                },
                                activeValue: amclin, radioList: ['အလုံး','အရည်'],
                              )),
                          halfInputBox('အရည်အတွက်', amoSislinController,10000),
                        ],
                      ),
                    ),

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                              height: 50,
                              width: 200,
                              child: Text('')),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ဓာတ်ဆား (ထုပ်)',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),

                          halfInputBox('အရည်အတွက်', saltPackageContoller,10000),
                        ],
                      ),
                    ),

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                              height: 50,
                              width: 200,
                              child: Text('')),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ဇင့်ဆာလဖိတ် (လုံး)',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),

                          halfInputBox('အရည်အတွက်', zincSulphateWholeController,10000),
                        ],
                      ),
                    ),

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                              height: 50,
                              width: 200,
                              child: Text('')),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ပါရာစီတမော (လုံး)',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),

                          halfInputBox('အရည်အတွက်', paracetamolWholeController,10000),
                        ],
                      ),
                    ),

                  ],
                ),
                const SizedBox(
                  height: 40,
                ),

                //Row 4.5
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ကုသသည့်ကာလ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('ကုသသည့်ကာလ', 1, treatmentPeriodController,10000),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'ညွှန်းပို့မှု',
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
                                  isPrevent = value;
                                },
                                activeValue: isPrevent, radioList: ['Yes','No'],
                              )),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: 250),
                  ],
                ),


                const SizedBox(
                  height: 40,
                ),
                //Row 5
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //dorp down
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ညွှန်းပို့သည့်နေရာ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250,
                          value: (String value, int index) { handOverValue = value; }, options: AppConstants.handoverList, currentValue: AppConstants.handoverList[0],),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ညွှန်းပို့ရာသို့ သွား/မသွား',
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
                                  referGo = value;
                                },
                                activeValue: referGo, radioList: ['Yes','No'],
                              )),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'မှတ်ချက်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('မှတ်ချက်', 3, remarkController,10000),
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
                    width: 300,
                    child: ButtonWidget(
                        buttonText: 'Save',
                        onPressed: () {
                          {
                          if (nameController.text.isEmpty||
                              ageController.text.isEmpty ||
                              clinicTeamController.text.isEmpty||
                              villageNameController.text.isEmpty ||
                              volunteerNameController.text.isEmpty ||
                              treatmentPeriodController.text.isEmpty ||
                              amoSislinController.text.isEmpty ||
                              saltPackageContoller.text.isEmpty ||
                              zincSulphateWholeController.text.isEmpty ||
                              paracetamolWholeController.text.isEmpty ||
                              reportingPeriod.isEmpty ||
                              channel.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Center(
                                  child: Text('Sorry!! Please input empty fields'),
                                )));
                          } else {
                            //Check Validation for Age
                            var age = int.parse(ageController.text);
                            if (age > 0 && age < 101) {
                              String trementValue = "$amclin||${amoSislinController.text}||${saltPackageContoller.text}||${zincSulphateWholeController.text}||${paracetamolWholeController.text}";
                              PNUVo dataVo = PNUVo(
                                  tableName: AppConstants.pnuTable,
                                orgName: PreferenceManager.getString(ORG),
                                stateName: PreferenceManager.getString(STATE),
                                townshipName: PreferenceManager.getString(REGION),
                                townshipLocalName: PreferenceManager.getString(REGION_LOCAL),
                                clinic: clinic,
                                villageName: villageNameController.text,
                                volunteerName: volunteerNameController.text,
                                reportingPeroid: reportingPeriod,
                                date: date,
                                name: nameController.text,
                                age: ageController.text,
                                sex: gender,
                                disabled: disabled,
                                relocation: relocation,
                                kofPatient: patientType,
                                symptomsList: selectSymptomsList,
                                diseaseList: selectTypeOfDiseaseList,
                                treatment: trementValue,
                                treatmentPeriod: treatmentPeriodController.text,
                                refer: isPrevent,
                                referPlace: handOverValue,
                                referGo: referGo,
                                  remark: remarkController.text,
                                  createDate: todayDateString,
                                  updateDate: todayDateString);
                              //Add To DB

                              try {
                                PreferenceManager.setString(CLINIC, clinicTeamController.text);
                                PreferenceManager.setString(CHANNEL, channel);
                                PreferenceManager.setString(REPORT_PERIOD, reportingPeriod);
                                //  DatabaseProvider provider = DatabaseProvider.db;
                                // provider.insertACNDataToDB(dataVo);
                                helper.insertPNUDataToDB(dataVo,false);

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            HomeScreen(indexOfTab: 2, selectedSideIndex: 1,)));
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
                                    child: Text('Age should be between 1 to 100 years !!!'),
                                  )));

                            }

                          }
                        }

                        }
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
        child: controller == ageController
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
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey)),
        ),

      ),
    );
  }
}
