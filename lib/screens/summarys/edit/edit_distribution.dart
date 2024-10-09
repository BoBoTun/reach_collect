import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../data/model/distribution_model.dart';
import '../../../network/presistance/SQLiteHelper.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/preference_keys.dart';
import '../../../utils/share_preference.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/custom_dropdown_widget.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/month_picker.dart';
import '../../../widgets/textfield_widget.dart';
import '../../home_screen.dart';

class EditDistribution extends StatefulWidget {
  const EditDistribution({super.key, required this.reachCollectVo});
  final DistributionVo reachCollectVo;
  @override
  State<EditDistribution> createState() => _EditDistributionState();
}

class _EditDistributionState extends State<EditDistribution> {

  String date = '';
  String attendedby = '';
  String reportingPeriod = '';
  String channel = '';
  String todayDateString = '';
  String beneficiary = '';
  String distribution = '';


  TextEditingController remarkController = TextEditingController();
  TextEditingController clinicTeamController = TextEditingController();

  TextEditingController item1Controller = TextEditingController();
  TextEditingController item2Controller = TextEditingController();
  TextEditingController item3Controller = TextEditingController();

  TextEditingController item1ControllerQty = TextEditingController();
  TextEditingController item2ControllerQty = TextEditingController();
  TextEditingController item3ControllerQty = TextEditingController();

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

  final TextEditingController orgController = TextEditingController();
  final TextEditingController townshipLocalController = TextEditingController();


  String? _selectedKey;
  String? _selectedItem;


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

    orgController.text = widget.reachCollectVo.orgName ?? '';
    townshipLocalController.text = widget.reachCollectVo.townshipLocalName ?? '';

    _selectedKey = widget.reachCollectVo.stateName ?? '';
    _selectedItem = widget.reachCollectVo.townshipName ?? '';

        remarkController.text = widget.reachCollectVo.remark ?? '';
        clinicTeamController.text = widget.reachCollectVo.clinic ?? '';

        List item1 = (widget.reachCollectVo.item1 ?? '').split('|');
    List item2 = (widget.reachCollectVo.item2 ?? '').split('|');
    List item3 = (widget.reachCollectVo.item3 ?? '').split('|');

        item1Controller.text = item1[0];
        item2Controller.text = item2[0];
        item3Controller.text = item3[0];

    item1ControllerQty.text = item1[1];
    item2ControllerQty.text = item2[1];
    item3ControllerQty.text = item3[1];

        householdController.text = widget.reachCollectVo.household ?? '';

    List under18List = (widget.reachCollectVo.under18 ?? '').split('|');
        under18M.text = under18List[0];
        under18F.text = under18List[1];

    List over18List = (widget.reachCollectVo.over18 ?? '').split('|');
        over18M.text = over18List[0];
        over18F.text = over18List[1];

        List idpList = (widget.reachCollectVo.iDP ?? '').split('|');
        idpM.text = idpList[0];
        idpF.text = idpList[1];

        List disabilityList = (widget.reachCollectVo.disability ?? '').split('|');
        disabilityM.text = disabilityList[0];
        disabilityF.text = disabilityList[1];

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
                "Distribution",
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
                        inputBox('Item 1 name', 1, item1Controller,10000),

                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Item 1 Qty', 1, item1ControllerQty,5),
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
                        inputBox('Item 2 name', 1, item2Controller,10000),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Item 2 Qty', 1, item2ControllerQty,5),
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
                        inputBox('Item 3 name', 1, item3Controller,10000),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Item 3 Qty', 1, item3ControllerQty,5),
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
                        inputBox('# of Household', 1, householdController,3),
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
                    width: 600,
                    child:
                    Row(
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
                                  id: widget.reachCollectVo.id,
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
                                  createDate: widget.reachCollectVo.createDate,
                                  updateDate: todayDateString
                              );

                              try {
                                helper.updateDistributionInto(dataVo);

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
        child: controller == householdController ||
            controller == item1ControllerQty ||
            controller == item2ControllerQty ||
            controller == item3ControllerQty
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
        ) : TextField(
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