import 'package:flutter/material.dart';
import 'package:flutter_auth/components/multiselect.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var appTitle = 'Ingredients';
  @override
  Widget build(BuildContext context)  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Vegetable(title: appTitle),
    );
  }
}

class Vegetable extends StatelessWidget {
  final String title;

  Vegetable({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(child: MultiSelect(
          titleText: 'Vegetable',
      autovalidate: false,
          validator: (value) {
            if (value == null) {
              return 'Please select one or more option(s)';
            }
          },
          errorText: 'Please select one or more option(s)',
          dataSource: [
            {
              "display": "Tomato",
              "value": 1,
            },
            {
              "display": "Potato",
              "value": 2,
            },
            {
              "display": "zuccini",
              "value": 3,
            },
            {
              "display": "Carrots",
              "value": 4,
            },
            {
              "display": "Coriander",
              "value": 5,
            },
            {
              "display": "Ginger",
              "value": 6,
            },
            {
              "display": "Broccoli",
              "value": 7,

            },
            {
              "display": "Onion",
              "value": 8,
            },
            {
              "display": "Eggplant",
              "value": 9,
            },
            {
              "display": "Garlic",
              "value": 10,
            },
          ],
          textField: 'display',
          valueField: 'value',
          filterable: true,
          required: true,
          value: null,
          onSaved: (value) {
            print('The value is $value');
          }
      ),),
    );
  }
}
