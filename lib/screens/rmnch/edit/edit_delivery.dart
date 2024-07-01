import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reach_collect/data/model/delivery_model.dart';

import '../../../network/presistance/SQLiteHelper.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/custom_dropdown_widget.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/month_picker.dart';
import '../../../widgets/radio_button.dart';
import '../../../widgets/radio_button_live_birth.dart';
import '../../../widgets/textfield_widget.dart';
import '../../home_screen.dart';

class EditDelivery extends StatefulWidget {
  const EditDelivery({super.key, required this.deliveryVo});
  final DeliveryVo deliveryVo;

  @override
  State<EditDelivery> createState() => _EditDeliveryState();
}

class _EditDeliveryState extends State<EditDelivery> {
  final SQLiteHelper helper = SQLiteHelper();

  String channel = '';
  String reportingPeriod = '';
  String createDate = '';
  String updateDate = '';
  String todayDateString = '';

  final TextEditingController orgController = TextEditingController();
  final TextEditingController townshipLocalController = TextEditingController();


  String? _selectedKey;
  String? _selectedItem;

  TextEditingController clinicTeamController = TextEditingController();

  //data var
  String date = '';
  String disability = 'true';
  String idp = 'true';
  String attendedby = '';
  String outcome = '';
  String tdComplete = 'true';
  String liveOrstill = 'Live birth';
  String neonatalRecursion = 'true';
  String breadFeeding = 'true';

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController gestationalWeekController = TextEditingController();
  TextEditingController gravidaController = TextEditingController();
  //TextEditingController parityController = TextEditingController();
  TextEditingController findingsController = TextEditingController();
  TextEditingController treatmentController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController birthWeightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    orgController.text = widget.deliveryVo.orgName ?? '';
    townshipLocalController.text = widget.deliveryVo.townshipLocalName ?? '';

    _selectedKey = widget.deliveryVo.stateName ?? '';
    _selectedItem = widget.deliveryVo.townshipName ?? '';

    clinicTeamController.text = widget.deliveryVo.clinic ?? '';
    channel = widget.deliveryVo.channel ?? '';
    reportingPeriod = widget.deliveryVo.reportingPeroid ?? '';
    createDate = widget.deliveryVo.createDate ?? '';
    updateDate = widget.deliveryVo.updateDate ?? '';

    DateTime todayDate = DateTime.now();
    todayDateString = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);


    attendedby = widget.deliveryVo.attended ?? '';
    outcome = widget.deliveryVo.outcome ?? '';

    date = widget.deliveryVo.date ?? '';
    nameController.text = widget.deliveryVo.name ?? '';
    ageController.text = widget.deliveryVo.age ?? '';
    gestationalWeekController.text = widget.deliveryVo.gestational ?? '';
    gravidaController.text = widget.deliveryVo.gravida ?? '';
    treatmentController.text = widget.deliveryVo.treatment ?? '';
    remarkController.text = widget.deliveryVo.remark ?? '';
    birthWeightController.text = widget.deliveryVo.birthWeight ?? '';

    disability = widget.deliveryVo.disability ?? 'true';
    idp = widget.deliveryVo.iDP ?? 'true';
    tdComplete = widget.deliveryVo.tDComplete ?? 'true';
    liveOrstill = widget.deliveryVo.birthType ?? 'Live birth';
    neonatalRecursion = widget.deliveryVo.neonatal ?? 'true';
    breadFeeding = widget.deliveryVo.breastfeeding ?? 'true';



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
                "Delivery",
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

/*
                      DropdownListView(containerWidth: 200, value: (String value, int index) {
                        setState(() {
                          print("Selected Index :: $index");
                          //selectedStateId = index ;
                          townshipList = AppConstants.townshipList[index];
                          selectedState = value;
                        });
                       }, options: stateList,),
                    */
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
                        inputBox('Birth Weight', 1, birthWeightController,2),
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

                            DeliveryVo dataVo = DeliveryVo(
                              id: widget.deliveryVo.id,
                                tableName: AppConstants.deliveryTable,
                                orgName: orgController.text,
                                stateName: _selectedKey,
                                townshipName: _selectedItem,
                                townshipLocalName: townshipLocalController.text,
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
                                createDate: createDate,
                                updateDate: todayDateString
                            );

                            try {
                              // DatabaseProvider provider = DatabaseProvider.db;
                              helper.updateDeliveryInto(dataVo);

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
        child: controller == ageController ||
            controller == gestationalWeekController ||
            controller == gravidaController ||
            controller == birthWeightController
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
