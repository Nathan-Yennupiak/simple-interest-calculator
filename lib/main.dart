import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
            accentColor: Colors.indigoAccent,
      ),
    )
  );
}

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ["Cedis", "Dollars", "Pounds"];
  var _currentItemSelected = "Cedis";

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = ' ';

  @override
  void initState(){
    super.initState();
    _currentItemSelected = _currencies[0];
  }
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      /*resizeToAvoidBottomPadding: false,*/
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              getImageAsset(),

              Padding(
                padding:  EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,

                  controller: principalController,
                    validator:
                        (String value){
                        if (value.isEmpty) {
                          return 'Please Enter principal amount';
                        }else
                    return null;
                    },

                  decoration: InputDecoration(
                  labelText: 'Principal',
                    labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                      ),
                    hintText: 'Enter Principal e.g 1200',
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  validator: (String value){
                    if (value.isEmpty) {
                      return 'Please Enter Rate ';
                    }else
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                      ),
                      hintText: 'In Percentage',
                      border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                      children: <Widget>[
                        Expanded(
                          child:TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                            controller: termController,
                            validator: (String value){
                              if (value.isEmpty) {
                                return 'Please Enter term';
                              }else
                              return null;
                            },
                          decoration: InputDecoration(
                              labelText: 'Term',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                              ),
                              hintText: 'Time in Years',
                              border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(5.0)
                              )
                          ),
                        ),
                        ),

                        Container(
                          width: 10.0,
                        ),

                        Expanded(
                          child: DropdownButton<String>(
                          items: _currencies.map((String value)  {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: textStyle,),

                            );
                          }).toList(),


                          onChanged: (String newValueSelected) {
                            setState(() {
                              this._currentItemSelected = newValueSelected;
                            });

                          },
                            value: _currentItemSelected,


                        ),
                        ),

    ],
    ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text("Calculate", style: textStyle,
                        ),
                        onPressed: (){

                          setState(() {
                            if (_formKey.currentState.validate()) {
                              this.displayResult = _calculateTotalReturns();
                            }

                          });
                        },
                      ),
                    ),
                    Container(
                      width: 20.0,
                    ),

                    Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,


                        child: Text("Reset", style: textStyle,),
                        onPressed: (){
                            setState(() {
                              _reset();
                            });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(this.displayResult, style: textStyle,),

              ),
            ],
          ),

    ),
      ),
    );

  }


Widget getImageAsset() {
  AssetImage assetImage = AssetImage('images/brain.png');
  Image image = Image(image: assetImage, width: 125.0, height: 125.0,);

  return Container(
    child: image, margin: EdgeInsets.all(20.0),
  );
}

 String _calculateTotalReturns() {
  double principal = double.parse(principalController.text);
  double roi = double.parse(roiController.text);
  int term = int.parse(termController.text);

  double totalAmountPayable = principal + (principal * roi * term) /100;

  String result = 'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
  return result;
}

void _reset(){
    principalController.text = '';
   roiController.text = '';
    termController.text = '';
    _currentItemSelected = _currencies[0];
    displayResult = '';
}
}
