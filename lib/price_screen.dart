import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:cryptocoins/coin_data.dart';
import 'package:cryptocoins/coin_card.dart';
import 'package:flutter/cupertino.dart';

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
      backgroundColor: Color(0xFF1C1F21),
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
        elevation: 0.0,
        title: Text(
          '🤑 Live Crypto Ticker 🤑',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'Pacifico',
          ),
        ),
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
            color: Color(0xFF1C1F21),
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
