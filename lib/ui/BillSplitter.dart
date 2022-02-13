import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPrecentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;
  double _tipAmount = 0.0;
  double _total = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Total per person",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "\$${_total.toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid)),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.0),
                        hintText: "Enter a Bill Amount ",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple))),
                    cursorColor: Colors.deepPurple,
                    onChanged: (String value) {
                      setState(() {
                        try {
                          _billAmount = double.parse(value);
                          calculateTip();
                          calculateTotalPerPerson();
                        } catch (exception) {
                          _billAmount = 0.0;
                          _tipAmount = 0.0;
                          _total = 0.0;
                        }
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                  calculateTotalPerPerson();
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Colors.deepPurple.shade50),
                              child: const Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$_personCounter",
                            style: const TextStyle(
                                color: Colors.deepPurple, fontSize: 17.0),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                                calculateTotalPerPerson();
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade50,
                                  borderRadius: BorderRadius.circular(7.0)),
                              child: const Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "\$${_tipAmount.toStringAsFixed(2)}",
                          style: const TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "$_tipPrecentage %",
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.deepPurple,
                          inactiveColor: Colors.deepPurple.shade50,
                          divisions: 10,
                          value: _tipPrecentage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPrecentage = newValue.round();
                              calculateTip();
                              calculateTotalPerPerson();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void calculateTip() {
    _tipAmount = _billAmount * _tipPrecentage / 100;
  }

  void calculateTotalPerPerson() {
    _total = (_billAmount + _tipAmount) / _personCounter;
  }
}