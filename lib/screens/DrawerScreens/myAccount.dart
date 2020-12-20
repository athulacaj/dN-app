import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/authPage/auth/authIndex.dart';
import 'package:daily_needs/authPage/phoneAuth/login.dart';
import 'package:daily_needs/constants/constants.dart';
import 'package:daily_needs/extracted/extractedButton.dart';
import 'package:daily_needs/screens/CheckOutPage/addAdress.dart';
import 'package:daily_needs/screens/Extracted/commonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../provider.dart';
import '../Extracted/ExtractedAdressBox.dart';

FirebaseFirestore _fireStore = FirebaseFirestore.instance;
bool _showSpinner = false;
int _selected;
String _name;
String _address;
String _phone;
var _addressSelected;

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  void initState() {
    _selected = null;
    _showSpinner = false;
    _name = '';
    _address = '';
    _phone = '';
    _addressSelected = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map _user = Provider.of<IsInList>(context, listen: false).userDetails;

    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      progressIndicator: RefreshProgressIndicator(),
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: _user == null
            ? Column(
                children: <Widget>[
                  CommonAppbar(title: 'My account'),
                  _user == null
                      ? Container(
                          padding: EdgeInsets.all(12),
                          width: double.infinity,
                          child: ExtractedButton(
                            text: 'Login',
                            colour: Colors.purple.shade600,
                            onclick: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PhoneLoginScreen()));
                              setState(() {});
//                              setState(() {
//                                _showSpinner = true;
//                              });
//                              FirebaseUser _currentUser = await handleSignIn();
//                              Map _userDetails = {
//                                'name': '${_currentUser.displayName}',
//                                'image': '${_currentUser.photoUrl}',
//                                'email': '${_currentUser.email}'
//                              };
//                              Provider.of<IsInList>(context, listen: false)
//                                  .addUser(_userDetails);
//                              setState(() {
//                                _showSpinner = false;
//                              });
                            },
                          ),
                        )
                      : Container(),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CommonAppbar(title: 'My account'),
                  Material(
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ),
                      title: Text(
                        '${_user['email']}',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    elevation: 4,
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        StreamBuilder<QuerySnapshot>(
                          stream: _fireStore
                              .collection('address/${_user['email']}/address')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.purple,
                                ),
                              );
                            }
                            var _details = snapshot.data.documents;
                            return _details.length > 0
                                ? Expanded(
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      itemCount: _details.length,
                                      itemBuilder: (context, i) {
                                        Map _detailsMap =
                                            _details[i].data()['address'];
                                        String _id = _details[i].id;
                                        return AddressBox(
                                          selectedIndex: _selected,
                                          i: i,
                                          details: _detailsMap,
                                          editAddress: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddAddressPage(
                                                          user: _user,
                                                          isEditing: true,
                                                          previousAddress:
                                                              _detailsMap,
                                                          id: _id,
                                                        )));
                                          },
                                          deleteFunction: () async {
                                            _onAlertButtonsPressed(
                                                context, _id, _user['email']);
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : Container();
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    height: 1,
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 120,
                      child: Text('add address'),
                      decoration: contaionerBlackOutlineButtonDecoration,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddressPage(
                                    user: _user,
                                  )));
                    },
                  ),
                  SizedBox(height: 5),
                ],
              ),
      ),
    );
  }
}

_onAlertButtonsPressed(context, String id, String email) {
  Alert(
    context: context,
    type: AlertType.none,
    title: 'Confirm delete address !',
//    desc: "",
    buttons: [
      DialogButton(
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Colors.deepPurple,
      ),
      DialogButton(
        child: Text(
          "Conform",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () async {
          _fireStore.collection('address/$email/address').document(id).delete();
          Navigator.pop(context);
        },
        gradient: LinearGradient(colors: [Colors.purple, Colors.purpleAccent]),
      )
    ],
  ).show();
}
