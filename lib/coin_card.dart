import 'package:flutter/material.dart';

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
        color: Color(0xF4FFFFFF),
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
              fontSize: 21.0,
              color: Color(0xFF1C1F21),
              fontFamily: 'Muli',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
