import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../common/theme.dart';

FirebaseFirestore _fireStore = FirebaseFirestore.instance;
bool _showSpinner = false;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

String _name;
Map _address;
String _phone;
String _houseName;
String _street;
String _landMark;
String _locality;
String _city;
String type = 'Home';
String _pincode;
bool _isEditing;

TextStyle _ktextStyle = TextStyle(color: primaryColor);
TextEditingController _numberController = TextEditingController();
TextEditingController _nameController = TextEditingController();
TextEditingController _houseController = TextEditingController();
TextEditingController _streetController = TextEditingController();
TextEditingController _landmarkController = TextEditingController();
TextEditingController _pincodeController = TextEditingController();
TextEditingController _localityController = TextEditingController();
TextEditingController _cityController = TextEditingController();

class AddAddressPage extends StatefulWidget {
  final user;
  final bool isEditing;
  final Map previousAddress;
  final String id;
  AddAddressPage({this.user, this.isEditing, this.id, this.previousAddress});
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  void initState() {
    _city = _cityController.text = 'Cherupuzha';
    _pincode = _pincodeController.text = '670511';
    _isEditing = false;
    _showSpinner = false;
    _isEditing = widget.isEditing != null ? widget.isEditing : false;
    editAddressFunction();
    super.initState();
  }

  void editAddressFunction() {
    if (_isEditing == true) {
      Map previousAdress = widget.previousAddress;
      _name = _nameController.text = previousAdress['name'];
      _phone = _numberController.text = previousAdress['phone'];
      _houseName = _houseController.text = previousAdress['houseName'];
      _street = _streetController.text = previousAdress['street'];
      _landMark = _landmarkController.text = previousAdress['landmark'];
//      _pincode = _pincodeController.text = previousAdress['pincode'];
      _locality = _localityController.text = previousAdress['locality'];
//      _city = _cityController.text = previousAdress['city'];
      type = previousAdress['type'];
    } else {
      _name = _nameController.text = '';
      _phone = _numberController.text = '+91 ';
      _houseName = _houseController.text = '';
      _street = _streetController.text = '';
      _landMark = _landmarkController.text = '';
//      _pincode = _pincodeController.text = '';
      _locality = _localityController.text = '';
//      _city = _cityController.text = '';
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      progressIndicator: RefreshProgressIndicator(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 30,
                    color: Colors.purple[600],
                  ),
                  SafeArea(
                    child: Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(width: 5),
                            Text(
                              'Add Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          border: Border(
                            bottom: BorderSide(
                                width: 0.5,
                                color: Colors.grey.withOpacity(0.5)),
                          )),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      SizedBox(height: 8),
                      Text(
                        'Name :',
                        style: _ktextStyle,
                      ),
                      TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        decoration:
                            textFieldDecoration.copyWith(hintText: 'eg: Smith'),
                        onChanged: (value) {
                          _name = value;
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Phone No :',
                        style: _ktextStyle,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        minLines: 1,
                        maxLines: 5,
                        controller: _numberController,
                        onChanged: (value) {
                          _phone = value;
                        },
                        decoration: textFieldDecoration.copyWith(
                            hintText: 'eg : +91 xxxxxxxxxx'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'House Name / Flat Number :',
                        style: _ktextStyle,
                      ),
                      TextField(
                        controller: _houseController,
                        decoration: textFieldDecoration.copyWith(
                            hintText: 'eg: Flat no. 8'),
                        onChanged: (value) {
                          _houseName = value;
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Street :',
                        style: _ktextStyle,
                      ),
                      TextField(
                        controller: _streetController,
                        decoration:
                            textFieldDecoration.copyWith(hintText: 'Street'),
                        onChanged: (value) {
                          _street = value;
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Landmark :',
                        style: _ktextStyle,
                      ),
                      TextField(
                        controller: _landmarkController,
                        decoration:
                            textFieldDecoration.copyWith(hintText: 'Landmark'),
                        onChanged: (value) {
                          _landMark = value;
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Pincode :',
                        style: _ktextStyle,
                      ),
                      TextField(
                        controller: _pincodeController,
                        readOnly: true,
                        decoration:
                            textFieldDecoration.copyWith(hintText: 'Pincode'),
                        onChanged: (value) {
                          _pincode = value;
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Locality :',
                        style: _ktextStyle,
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _localityController,
                        validator: (value) {
                          final validCharacters = RegExp(r'^[a-zA-Z]+$');

                          if (value.isEmpty) {
                            return 'Cannot be null';
                          } else if (!validCharacters.hasMatch(value)) {
                            return ' Space , Numbers and Characters  are not allowed';
                          }
                          return null;
                        },
                        decoration: textFieldDecoration.copyWith(
                            hintText: 'eg: kokkadavu'),
                        onChanged: (value) {
                          _locality = value;
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        'City :',
                        style: _ktextStyle,
                      ),
                      SizedBox(height: 5),
                      TextField(
                        controller: _cityController,
                        readOnly: true,
                        decoration:
                            textFieldDecoration.copyWith(hintText: 'City'),
                        onChanged: (value) {
                          _city = value;
                        },
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            child: buildTypeContainer('Home', Icons.home, type),
                            onTap: () {
                              setState(() {
                                type = 'Home';
                              });
                            },
                          ),
                          Spacer(),
                          GestureDetector(
                            child:
                                buildTypeContainer('Office', Icons.work, type),
                            onTap: () {
                              setState(() {
                                type = 'Office';
                              });
                            },
                          ),
                          Spacer(),
                          GestureDetector(
                            child: buildTypeContainer(
                                'Other', Icons.location_on, type),
                            onTap: () {
                              setState(() {
                                type = 'Other';
                              });
                            },
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      SizedBox(height: 35),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    print(_formKey.currentState.validate());
                    validateAndSave();
                  }
                },
                child: Container(
                  height: 43,
                  color: Colors.purple.shade600,
                  alignment: Alignment.center,
                  child: Text(
                    'Save Address',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
//            SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTypeContainer(String title, IconData icon, String whatType) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon,
              size: 25,
              color: whatType == title ? primaryColor : Colors.black54),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('$title',
                style: TextStyle(
                    textBaseline: TextBaseline.ideographic,
                    color: whatType == title ? primaryColor : Colors.black54)),
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color:
              whatType == title ? primaryColor.withOpacity(0.1) : Colors.white,
          border: Border.all(
              color: whatType == title ? primaryColor : Colors.white)),
    );
  }

  void validateAndSave() async {
    String error;
    if (_name == '') {
      error = 'name cannot be null !';
      return buildSnackBar(error);
    }
    if (_phone == '') {
      error = 'Enter a valid phone number';
      return buildSnackBar(error);
    }
    if (_phone != '') {
      if (_phone.length < 9) {
        error = 'Enter a valid phone number';
        return buildSnackBar(error);
      }
    }
    if (_houseName == '') {
      error = 'House name / Flat Number cannot be null !';
      return buildSnackBar(error);
    }
    if (_street == '') {
      error = 'Street cannot be null !';
      return buildSnackBar(error);
    }
    if (_pincode == '') {
      error = 'Pincode cannot be null !';
      return buildSnackBar(error);
    }
    if (_locality == '') {
      error = 'Locality cannot be null !';
      return buildSnackBar(error);
    }
    if (_city == '') {
      error = 'City cannot be null !';
      return buildSnackBar(error);
    }
    setState(() {
      _showSpinner = true;
    });
    _address = {
      'name': _name,
      'phone': '$_phone',
      'houseName': _houseName,
      'street': _street,
      'landmark': _landMark,
      'pincode': _pincode,
      'locality': _locality,
      'city': _city,
      'type': type
    };
    if (_isEditing == true) {
      await _fireStore
          .collection('address/${widget.user['email']}/address')
          .document('${widget.id}')
          .updateData({'name': _name, 'phone': _phone, 'address': _address});
    } else {
      await _fireStore
          .collection('address/${widget.user['email']}/address')
          .add({'name': _name, 'phone': _phone, 'address': _address});
    }

    setState(() {
      _showSpinner = false;
    });
    Navigator.pop(context);
  }
}

buildSnackBar(String error) {
  _scaffoldKey.currentState.showSnackBar(
    new SnackBar(
      duration: Duration(milliseconds: 1300),
      backgroundColor: Colors.deepPurple,
      content: new Text('$error '),
    ),
  );
}
