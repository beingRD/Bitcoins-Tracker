import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'INR';
  var getCurrencyName = 'INR';
  String cryptoBTC = 'BTC';
  String cryptoETH = 'ETH';
  String cryptoLTC = 'LTC';
  String bitcoinValue;
  String ethereumValue;
  String litecoinValue;
  CoinData coinData = CoinData();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var dataBTC = await coinData.getCoinData(selectedCurrency, cryptoBTC);
    var dataETH = await coinData.getCoinData(selectedCurrency, cryptoETH);
    var dataLTC = await coinData.getCoinData(selectedCurrency, cryptoLTC);
    setState(() {
      bitcoinValue = dataBTC.toStringAsFixed(2);
      ethereumValue = dataETH.toStringAsFixed(2);
      litecoinValue = dataLTC.toStringAsFixed(2);
    });
  }

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (newValue) {
        setState(() {
          selectedCurrency = newValue;
          print(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.blue[900],
      onSelectedItemChanged: (indexValue) {
        indexValue.toInt();

        setState(() {
          print(currenciesList[indexValue]);
          getCurrencyName = currenciesList[indexValue];
          selectedCurrency = currenciesList[indexValue].toString();
          getData();
        });
      },
      itemExtent: 32.0,
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CoinCard(
              crypto: cryptoList.elementAt(0),
              bitcoinValue: bitcoinValue,
              getCurrencyName: getCurrencyName),
          CoinCard(
            crypto: cryptoList.elementAt(1),
            bitcoinValue: ethereumValue,
            getCurrencyName: getCurrencyName,
          ),
          CoinCard(
            crypto: cryptoList.elementAt(2),
            bitcoinValue: litecoinValue,
            getCurrencyName: getCurrencyName,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.blue[900],
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  CoinCard({
    @required this.crypto,
    @required this.bitcoinValue,
    @required this.getCurrencyName,
  });

  final String crypto;
  final String bitcoinValue;
  final String getCurrencyName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 76.0, 18.0, 18.0),
      child: Card(
        color: Colors.blue[900],
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $bitcoinValue $getCurrencyName',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
