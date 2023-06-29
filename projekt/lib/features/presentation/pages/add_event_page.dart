import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projekt/features/data/remote_data_source/firestore_helper.dart';
import 'package:projekt/features/data/remote_data_source/models/event_model.dart';

import '../widgets/header_widget.dart';

class AddEventPage extends StatefulWidget {
  final String uid;
  const AddEventPage({super.key, required this.uid});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final SingleValueDropDownController _disciplineController =
      SingleValueDropDownController();
  final TextEditingController _localizationController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _disciplineController.dispose();
    _localizationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      body: Center(
        child: Column(
          children: [
            const HeaderWidget(title: 'Add Event'),
            Container(
                margin: const EdgeInsets.only(top: 20),
                height: 70,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: "TITLE (max. 20 characters)",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.title)),
                  controller: _titleController,
                )),
            Container(
                margin: const EdgeInsets.only(top: 20),
                height: 150,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: "DESCRIPTION",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.library_books)),
                  controller: _descriptionController,
                  maxLines: null,
                )),
            Container(
                margin: const EdgeInsets.only(top: 20),
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  inputFormatters: [
                    MaskTextInputFormatter(mask: "##/##/####"),
                  ],
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      labelText: "dd/mm/yyyy",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.calendar_month)),
                  controller: _dateController,
                )),
            Container(
                margin: const EdgeInsets.only(top: 20),
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: "LOCALIZATION (cooridinates)",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.map)),
                  controller: _localizationController,
                )),
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropDownTextField(
                controller: _disciplineController,
                clearOption: true,
                textFieldDecoration: const InputDecoration(
                    labelText: "DISCIPLINE",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.sports)),
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                dropDownItemCount: 10,
                dropDownList: const [
                  DropDownValueModel(name: 'football', value: "football"),
                  DropDownValueModel(
                    name: 'pool',
                    value: "pool",
                  ),
                  DropDownValueModel(name: 'run', value: "run"),
                  DropDownValueModel(
                    name: 'yoga',
                    value: "yoga",
                  ),
                  DropDownValueModel(name: 'fitness', value: "fitness"),
                  DropDownValueModel(name: 'hockey', value: "hockey"),
                  DropDownValueModel(name: 'cycling', value: "cycling"),
                  DropDownValueModel(name: 'volleyball', value: "volleyball"),
                  DropDownValueModel(name: 'basketball', value: "basketball"),
                  DropDownValueModel(name: 'other', value: "other"),
                ],
                onChanged: (val) {},
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  onPressed: () {
                    FirestoreHelper.create(EventModel(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        date: _dateController.text,
                        localization: _localizationController.text,
                        discipline: _disciplineController.dropDownValue!.value,
                        uid: widget.uid));
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Text("Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.pink,
        hoverColor: Colors.black,
        tooltip: 'Go Back',
        child: const Icon(
          Icons.arrow_back_rounded,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
