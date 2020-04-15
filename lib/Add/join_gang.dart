
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tellthetruth/common_widgets/loading_page.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/firebase/firebase_common_variables.dart';

class JoinGang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return F_JoinGang();
  }
}

class F_JoinGang extends StatefulWidget {
  @override
  _F_JoinGangState createState() => _F_JoinGangState();
}

class _F_JoinGangState extends State<F_JoinGang> {

  final _formKey = GlobalKey<FormState>();
  String _gangCode;
  bool isLoading = false;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {

    setState(() {
      isLoading = true;
    });

    if (_validateAndSaveForm()) {


      Firestore.instance.collection('testgangs').where('gang_code', isEqualTo:int.parse(_gangCode))
          .snapshots().listen(
              (data) => {
            if(data.documents.length == 1){

             // var gangCode = data.documents[0].documentID,


            }else{
      print('invalid'),

            }
          }
      );

      setState(() {
        isLoading = false;
      });

    }else{
      setState(() {
        isLoading = false;
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          body: _buildContent(context),
        ),
      ),
    );
  }

  @override
  Widget _buildContent(BuildContext context) {
    return TransparentLoading(
      loading: isLoading,
      child: Container(
        color: Color(0xFF7E7ED5),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.brown,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Good morning sri,\nJoin a new gang.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),

              Form(
                key: _formKey,
                child: TextFormField(
                  onChanged: (value) => _gangCode = value,
                  textInputAction: TextInputAction.done,
                  autocorrect: true,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  keyboardAppearance: Brightness.dark,
                  autofocus: true,
                  cursorColor: Colors.white,
                  onEditingComplete: _submit,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 26,decoration: TextDecoration.none),
                  decoration: const InputDecoration(
                    counterStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Add gang code',
                    hintStyle: TextStyle(
                        color: Colors.white30,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 26,decoration: TextDecoration.none),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                  ),
                  validator: (value) {
                    print(value);
                    if (value.isEmpty) {
                      return 'Please enter gang code';
                    }
                    return null;
                  },
                ),
              ),

              Center(
                child: FlatButton(
                  onPressed: () {
                    _submit();
                  },
                  child: Text(
                    'Join',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

