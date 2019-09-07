import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

class CoinData {
  static double lastPrice = 0;
  Future getCoinData(String currency, String cryptoType) async {
    var url = '$bitcoinAverageURL$cryptoType$currency';
    print(url);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String coinData = response.body;

      var decodedData = jsonDecode(coinData);
      lastPrice = await decodedData['last'];

      print(lastPrice);
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request!';
    }
  }
}
