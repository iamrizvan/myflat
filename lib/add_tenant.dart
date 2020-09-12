import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTenant extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddTenantFormState();
  }
}

class AddTenantFormState extends State<AddTenant> {
  final Map<String, dynamic> _formData = {
    "name": null,
    "package": null,
    'mobile': null,
    'joiningDate': null
  };
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Card(
          child: Container(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildNameField(formData: _formData),
                    _buildPackageField(formData: _formData),
                    _buildMobileField(formData: _formData),
                    SubmitButton(formKey: _formKey, formData: _formData)
                  ],
                )),
          ),
        ));
  }
}

class _buildMobileField extends StatelessWidget {
  const _buildMobileField({
    Key key,
    @required Map<String, dynamic> formData,
  })  : _formData = formData,
        super(key: key);

  final Map<String, dynamic> _formData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Enter mobile number",
        icon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['mobile'] = value;
      },
    );
  }
}

class _buildPackageField extends StatelessWidget {
  const _buildPackageField({
    Key key,
    @required Map<String, dynamic> formData,
  })  : _formData = formData,
        super(key: key);

  final Map<String, dynamic> _formData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Enter Package", icon: Icon(Icons.category)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter package';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['package'] = value;
      },
    );
  }
}

class _buildNameField extends StatelessWidget {
  const _buildNameField({
    Key key,
    @required Map<String, dynamic> formData,
  })  : _formData = formData,
        super(key: key);

  final Map<String, dynamic> _formData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Enter Name", icon: Icon(Icons.person_outline)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required Map<String, dynamic> formData,
  })  : _formKey = formKey,
        _formData = formData,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final Map<String, dynamic> _formData;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        }
        _formKey.currentState.save();
        Firestore.instance.collection('myflat').add({
          "name": _formData['name'],
          "mobile": _formData['mobile'],
          "package": _formData['package'],
          "joiningDate": DateTime.now().millisecondsSinceEpoch
        }).then((value) {
          print(value.documentID);
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(value.documentID.toString())));
        });
      },
      child: Text('Submit'),
    );
  }
}

/*
String getCurrentDate() {
  var date = new DateTime.now().toString();
  var dateParse = DateTime.parse(date);
  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  return formattedDate.toString();
}
*/
