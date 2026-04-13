import 'package:ecommercetwoexample/core/constractor/color.dart';
import 'package:ecommercetwoexample/core/constractor/linkapi.dart';
import 'package:ecommercetwoexample/core/service/apiservice.dart';
import 'package:ecommercetwoexample/view/widget/editrest/castuminputeditdate.dart';
import 'package:ecommercetwoexample/view/widget/editrest/castumtextformedit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AddNewRetaurant extends StatefulWidget {
  const AddNewRetaurant({
    super.key,
  });

  @override
  State<AddNewRetaurant> createState() => _EditRestmManagmintState();
}

class _EditRestmManagmintState extends State<AddNewRetaurant> {
  TextEditingController name = TextEditingController();
  TextEditingController subName = TextEditingController();
  TextEditingController dateCreat = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
  final DateTime _creatDate = DateTime.now();
  final DateTime p = DateTime.now();
  bool notify = false;
  String _states = "inactive";
  @override
  void initState() {
    dateCreat.text = _creatDate.toString();
    _startDate = _creatDate;
    _endDate = _creatDate;
    super.initState();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  saveAdd() async {
    if (notify) {
      _states = "active";
    }
    if (name.text.isEmpty || subName.text.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "لا يمكن ان يكون اسم المطعم او النطاق فارغ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 255, 1, 1),
          duration: Duration(seconds: 3),
        ));
      });
    } else {
      var response = await Apiservice.postRequest(LinkApi.restAdd, {
        "name": name.text,
        "subdomain": subName.text,
        "subscription_start_date": _startDate.toString(),
        "subscription_end_date": _endDate.toString(),
        "rest_creat": dateCreat.text,
        "rest_state": _states,
      });
      if (response["status"] == "Success") {
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            textColor: AppColor.textColorButton,
            onPressed: () async {
              await saveAdd();
              // print(_startDate.toString());
            },
            child: const Row(
              children: [
                Icon(Icons.save),
                Text(
                  "حفظ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            CastumTextFormEdit(
              hinttext: "اسم المطعم",
              text: "اسم المطعم",
              mycontroller: name,
            ),
            const SizedBox(
              height: 20,
            ),
            CastumTextFormEdit(
              hinttext: "النطاق",
              text: "النطاق",
              mycontroller: subName,
            ),
            const SizedBox(
              height: 20,
            ),
            CastumTextFormEdit(
              hinttext: "تاريخ الانشاء",
              text: "تاريخ الانشاء",
              mycontroller: dateCreat,
              enable: false,
            ),
            const SizedBox(
              height: 20,
            ),
            CastumInputEditDate(
              text: 'تاريخ بداية الاشتراك',
              date: _startDate!,
              dateFormatter: _dateFormatter,
              onTap: () => _selectDate(context, true),
            ),
            const SizedBox(
              height: 20,
            ),
            CastumInputEditDate(
              text: 'تاريخ نهاية الاشتراك',
              date: _endDate!,
              dateFormatter: _dateFormatter,
              onTap: () => _selectDate(context, false),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                leading: Switch(
                    value: notify,
                    onChanged: (val) {
                      setState(() {
                        notify = val;
                      });
                    }),
                trailing: const Text(
                  "تفعيل المطعم ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
