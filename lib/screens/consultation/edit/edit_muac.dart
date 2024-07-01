import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/muac_model.dart';
import '../../../network/presistance/SQLiteHelper.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/preference_keys.dart';
import '../../../utils/share_preference.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/custom_dropdown_widget.dart';
import '../../../widgets/custom_radio.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/textfield_widget.dart';
import '../../home_screen.dart';

class EditMUAC extends StatefulWidget {
  const EditMUAC({super.key, required this.reachCollectVo});
  final MUACVo reachCollectVo;
  @override
  State<EditMUAC> createState() => _EditMUACState();
}

class _EditMUACState extends State<EditMUAC> {

  String date = '';
  String gender = 'ကျား';
  String disabled = 'Yes';
  String relocation = 'Yes';
  String bcgValue = '';
  String handOverValue = '';
  String clinic = 'ဆေးခန်း';

  String todayDateString = '';
  String swelling = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController villageNameController = TextEditingController();
  TextEditingController volunteerNameController = TextEditingController();

  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController armSizeController = TextEditingController();
  TextEditingController bodyWieghtController = TextEditingController();

  String isPrefer = 'Yes';
  String isPreferGo = 'Yes';

  final SQLiteHelper helper = SQLiteHelper();

  final TextEditingController orgController = TextEditingController();
  final TextEditingController townshipLocalController = TextEditingController();

  String? _selectedKey;
  String? _selectedItem;

  @override
  void initState() {
    super.initState();

    date = widget.reachCollectVo.date ?? '';
    gender = widget.reachCollectVo.sex ?? 'ကျား';
    disabled = widget.reachCollectVo.disabled ?? 'Yes';
    relocation = widget.reachCollectVo.relocation ?? 'Yes';
    handOverValue = widget.reachCollectVo.referPlace ?? '';
    clinic = widget.reachCollectVo.clinic ?? 'ဆေးခန်း';

    villageNameController.text = widget.reachCollectVo.villageName ?? '';
    date = widget.reachCollectVo.date ?? '';
    nameController.text = widget.reachCollectVo.name ?? '';
    swelling = widget.reachCollectVo.swelling ?? '';

    remarkController.text = widget.reachCollectVo.remark ?? '';
    volunteerNameController.text = widget.reachCollectVo.volunteerName ?? '';

    ageController.text = widget.reachCollectVo.age ?? '';
    phoneController.text = widget.reachCollectVo.phone ?? '';
    armSizeController.text = widget.reachCollectVo.armSize ?? '';
    bodyWieghtController.text = widget.reachCollectVo.weight ?? '';

    isPrefer = widget.reachCollectVo.refer ?? 'Yes';
    isPreferGo = widget.reachCollectVo.referGo ?? 'Yes';


   orgController.text = widget.reachCollectVo.orgName ?? '';
   townshipLocalController.text = widget.reachCollectVo.townshipLocalName ?? '';

    _selectedKey = widget.reachCollectVo.stateName ?? '';
    _selectedItem = widget.reachCollectVo.townshipName ?? '';

    DateTime todayDate = DateTime.now();
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
                "MUAC",
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

                //section two
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Organization *',
                          style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    spreadRadius: 5.0,
                                    color: AppTheme.shadowColor)
                              ]),
                          child: TextFieldWidget(
                              maxLength: 300,
                              maxLines: 1,
                              hintText: "Organization name",
                              obscureText: false,
                              controller: orgController),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const  Text(
                              'State/Region *',
                              style: TextStyle(
                                  color: AppTheme.secondaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: _selectedKey,
                                  //icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 30,
                                  elevation: 16,
                                  hint: Text('Please Select'),
                                  style: const TextStyle(fontSize: 16, color: Colors.black),
                                  underline: Container(
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedKey = newValue;
                                      _selectedItem = null;
                                    });
                                  },
                                  items: AppConstants.stateAndTownshipList.keys
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),


                    _selectedKey != null ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          'Township(MIMU) *',
                          style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedItem,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 30,
                              elevation: 16,
                              hint: Text('Please Select'),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              underline: Container(
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedItem = newValue;
                                });
                              },
                              items: AppConstants.stateAndTownshipList[_selectedKey]!
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),


                      ],
                    ) : Container(),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Township(Local)',
                          style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //DropdownListView(),
                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    spreadRadius: 5.0,
                                    color: AppTheme.shadowColor)
                              ]),
                          child: TextFieldWidget(
                              maxLength: 300,
                              maxLines: 1,
                              hintText: "Township Local",
                              obscureText: false,
                              controller: townshipLocalController),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
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
                        inputBox('အသက်', 1, ageController,10000),
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
                          'ဖုန်းနံပါတ်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('ဖုန်းနံပါတ်', 1, phoneController,12),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'လက်မောင်းလုံးပတ်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('လက်မောင်းလုံးပတ်', 1, armSizeController,20),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ကိုယ် အလေးချိန် (ကီလိုဂရမ်)',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('ကိုယ် အလေးချိန် (ကီလိုဂရမ်)',1, bodyWieghtController,12),
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

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ဖောရောင်ခြင်း',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250,
                          value: (String value, int index) { swelling = value; }, options: AppConstants.swellingList, currentValue: swelling,),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  isPrefer = value;
                                },
                                activeValue: isPrefer, radioList: ['Yes','No'],
                              )),
                        ],
                      ),
                    ),
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
                          value: (String value, int index) {
                          print("Selected Refer Value ::: $value");
                          handOverValue = value;
                          }, options: AppConstants.handoverList, currentValue: handOverValue
                          ,),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                //Row 5
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

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
                                  isPreferGo = value;
                                },
                                activeValue: isPreferGo, radioList: ['Yes','No'],
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
                    SizedBox(width: 250,)
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
                                phoneController.text.isEmpty ||
                                armSizeController.text.isEmpty ||
                                bodyWieghtController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                  content: Center(
                                    child: Text('Sorry!! Please input empty fields'),
                                  )));
                            } else {
                              //Check Validation for Age
                              var age = int.parse(ageController.text);
                              if (age > 0 && age < 101) {

                                //Add To DB
                                MUACVo dataVo = MUACVo(
                                    id: widget.reachCollectVo.id,
                                    tableName: AppConstants.muacTable,
                                    orgName: orgController.text,
                                    stateName: _selectedKey,
                                    townshipName: _selectedItem,
                                    townshipLocalName: townshipLocalController.text,
                                    clinic: clinic,
                                    villageName: villageNameController.text,
                                    volunteerName: volunteerNameController.text,
                                    date: date,
                                    name: nameController.text,
                                    age: ageController.text,
                                    sex: gender,
                                    disabled: disabled,
                                    relocation: relocation,
                                    phone: phoneController.text,
                                    armSize: armSizeController.text,
                                    weight: bodyWieghtController.text,
                                    swelling: swelling,
                                    refer: isPrefer,
                                    referPlace: handOverValue,
                                    referGo: isPreferGo,
                                    remark: remarkController.text,
                                    createDate: widget.reachCollectVo.createDate,
                                    updateDate: todayDateString);


                                try {

                                  helper.updateMUACInto(dataVo);
                                  //helper.insertMUACDataToDB(dataVo,false);

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              HomeScreen(indexOfTab: 1, selectedSideIndex: 1,)));
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
