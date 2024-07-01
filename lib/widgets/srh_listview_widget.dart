//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:reach_collect/data/model/anc_model.dart';
import 'package:reach_collect/data/model/delivery_model.dart';
import 'package:reach_collect/data/model/srh_model.dart';
import 'package:reach_collect/screens/rmnch/edit/edit_acn.dart';
import 'package:reach_collect/utils/app_styles.dart';

import '../network/presistance/SQLiteHelper.dart';


class SRHListView extends StatelessWidget {
  const SRHListView({super.key, required this.reachData, required this.reloadView});

  final List<SRHVo> reachData;
  final Function reloadView;

  @override
  Widget build(BuildContext context) {
    List<String> titleArray = [
      'Sr.',
      'Date',
      'Name',
      'Age',
      'Sex',
      'Disability',
      'IDP',
      'Service Type',
      'First reach this year'
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 150),
                  color: AppTheme.secondaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: titleArray
                        .map((e) => SizedBox(
                              width: e == titleArray[0] ? 30 : 90,
                              child: Text(
                                e,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: reachData
                .asMap()
                .entries
                .map((e) => ContactView(
                      data: e.value,
                      index: e.key, reload: reloadView,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ContactView extends StatefulWidget {
  const ContactView({super.key, required this.data, required this.index, required this.reload});

  final SRHVo data;
  final int index;
  final Function reload;

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final SQLiteHelper helper = SQLiteHelper();
  List<String> titleArray = [
    '100',
    '12.3.2024',
    'Sai Sai Khen',
    '20',
    'Disability',
    'IDP',
    'Gestational',
    'Gravida'
  ];

  @override
  void initState() {
    super.initState();

    titleArray = [
      '${widget.index + 1}',
      widget.data.date ?? '',
      widget.data.name ?? '',
      widget.data.age ?? '',
      widget.data.sex ?? '',
      widget.data.disability ?? '',
      widget.data.iDP ?? '',
      widget.data.serviceType ?? '',
      widget.data.firstReach ?? ''
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 3.0, spreadRadius: 2.0, color: Colors.black12)
      ]),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: titleArray
                  .map((e) => SizedBox(
                      width: e == titleArray[0] ? 30 : 90,
                      child: Text(
                        e,
                        style:
                            const TextStyle(overflow: TextOverflow.ellipsis),
                      )))
                  .toList(),
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          InkWell(
            onTap: () {
            //   AwesomeDialog(
            //     width:  MediaQuery.of(context).size.width * 0.3,
            // context: context,
            // dialogType: DialogType.warning,
            // animType: AnimType.rightSlide,
            // title: 'Are you sure want to delete?',
            // desc: 'This data remove from data record.',
            // btnCancelOnPress: () {},
            // btnOkOnPress: () {
            //   try {
            //     //DatabaseProvider.db.deleteSRHFromDB(widget.data.id ?? 0);
            //     helper.deleteSRHFromDB(widget.data.id ?? 0);
            //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //         content: Center(
            //       child: Text('Delete data successfully!'),
            //     )));
            //   } catch (e) {
            //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //         content: Center(
            //       child: Text('Delete Fail!!'),
            //     )));
            //   }
            //   widget.reload();
            // },
            // ).show();
              
            },
            child: Container(
              height: 30,
              width: 30,
              color: Colors.red,
              child: const Center(
                child: Icon(
                  Icons.delete,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              //Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditUserInfo(reachCollectVo: widget.data)));
            },
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
          const SizedBox(
            width: 40,
          )
        ],
      ),
    );
  }
}
