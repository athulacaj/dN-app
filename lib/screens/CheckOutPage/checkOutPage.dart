import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/authPage/phoneAuth/login.dart';
import 'package:daily_needs/constants/constants.dart';
import 'package:daily_needs/extracted/extractedButton.dart';
import 'package:daily_needs/screens/CheckOutPage/addAdress.dart';
import 'package:daily_needs/screens/CheckOutPage/sucessful/delivarySlot.dart';
import 'package:daily_needs/screens/Extracted/commonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
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
        body: Stack(
          children: <Widget>[
            Container(
              height: 30,
              color: Colors.purple[600],
            ),
            _user == null
                ? Column(
                    children: <Widget>[
                      CommonAppbar(title: 'Login/Register'),
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
                      CommonAppbar(title: 'Select Address'),
                      Material(
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.deepPurple,
                          ),
                          title: RichText(
                            text: new TextSpan(
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(text: ' Signed in as '),
                                TextSpan(
                                    text: '${_user['email']}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
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
                                  .collection(
                                      'address/${_user['email']}/address')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SpinKitRotatingCircle(
                                      color: Colors.purple,
                                      size: 30,
                                    ),
                                  );
                                }

                                var _details = snapshot.data.docs;

                                return _details.length > 0
                                    ? Expanded(
                                        child: AnimationLimiter(
                                          child: ListView.builder(
                                            padding: EdgeInsets.all(0),
                                            itemCount: _details.length,
                                            itemBuilder: (context, i) {
                                              Map _detailsMap =
                                                  _details[i].data()['address'];
                                              String _id = _details[i].id;
                                              return AnimationConfiguration
                                                  .staggeredList(
                                                delay:
                                                    Duration(milliseconds: 100),
                                                position: i,
                                                duration: const Duration(
                                                    milliseconds: 600),
                                                child: FadeInAnimation(
                                                  child: AddressBox(
                                                    selectedIndex: _selected,
                                                    i: i,
                                                    details: _detailsMap,
                                                    checkBoxFunction: () async {
                                                      _selected = i;
                                                      _addressSelected =
                                                          _detailsMap;
                                                      setState(() {});
                                                    },
                                                    editAddress: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddAddressPage(
                                                                    user: _user,
                                                                    isEditing:
                                                                        true,
                                                                    previousAddress:
                                                                        _detailsMap,
                                                                    id: _id,
                                                                  )));
                                                    },
                                                    deleteFunction: () async {
                                                      _onAlertButtonsPressed(
                                                          context,
                                                          _id,
                                                          _user['email']);
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.5),
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
                      SizedBox(height: 10),
                    ],
                  ),
          ],
        ),
        bottomNavigationBar: _user == null
            ? null
            : GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  color: Colors.purple[400],
                  height: 48,
                  child:
                      Text('Continue', style: TextStyle(color: Colors.white)),
                ),
                onTap: () {
                  if (_addressSelected == null) {
                    print(_addressSelected);
                    _scaffoldKey.currentState.showSnackBar(
                      new SnackBar(
                        duration: Duration(milliseconds: 700),
                        backgroundColor: Colors.lightGreen,
                        content: new Text('Please select a address !',
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                      return DelivarySlot(
                        address: _addressSelected,
                        email: _user['email'],
                        user: _user,
                      );
                    }, transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                      var begin = Offset(1.0, 0.0);
                      var end = Offset(0.0, 0.0);
                      var tween = Tween(begin: begin, end: end);
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    }));
                  }
                },
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
          "Confirm",
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
