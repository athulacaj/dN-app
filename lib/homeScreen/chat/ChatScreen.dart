import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_needs/authPage/auth/authIndex.dart';
import 'package:daily_needs/extracted/extractedButton.dart';
import 'package:daily_needs/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'addons.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;
List listMessage = [];
List toSendMap = [];
TextEditingController _textEditingController;
ScrollController _scrollController = new ScrollController();

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map _user = Provider.of<IsInList>(context, listen: false).userDetails;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffffcf7f2),
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: _user == null
          ? _user == null
              ? Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  child: ExtractedButton(
                    text: 'Login to Continue',
                    colour: Colors.purple.shade600,
                    onclick: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AuthIndex()));
                      setState(() {});
                    },
                  ),
                )
              : Container()
          : Column(
              children: [
                Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: _firestore
                          .collection('messages/670511/messages')
                          .doc(_user['email'])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.purple)));
                        } else {
                          print(snapshot.data.exists);
                          listMessage = [];
                          List listMessageReversed = [];
                          if (snapshot.data.exists) {
                            listMessage =
                                snapshot.data.data()['messages'] ?? [];
                            listMessageReversed = listMessage.reversed.toList();
                          }

                          return snapshot.data.exists
                              ? ListView.builder(
                                  padding: EdgeInsets.all(10),
                                  reverse: true,
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: listMessage?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return ChatMessageBox(_user['email'], size,
                                        listMessageReversed[index]);
                                  },
                                )
                              : Container();
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: TextField(
                            decoration: KtextfieldDecoration,
                            controller: _textEditingController,
                          ),
                        ),
                      ),
                      IconButton(
                        splashRadius: 25,
                        onPressed: () {
                          print(_textEditingController.text);
                          if (_textEditingController.text != '') {
                            int _nowInMS =
                                DateTime.now().millisecondsSinceEpoch;
                            Map toSendMap = {
                              'message': _textEditingController.text,
                              'email': _user['email'],
                              'time': _nowInMS,
                            };
                            listMessage.add(toSendMap);
                            _textEditingController.clear();
                            _firestore
                                .collection('messages/670511/messages')
                                .document(_user['email'])
                                .setData({'messages': listMessage});
                            _scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                          }
                        },
                        iconSize: 30,
                        icon: CircleAvatar(
                            radius: 30, child: Icon(Icons.send, size: 20)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
