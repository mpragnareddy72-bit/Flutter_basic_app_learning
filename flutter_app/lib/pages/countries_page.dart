import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; //to make use of root bundle

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  List<dynamic> countries = [];

  @override
  void initState() {
    super.initState();
    loadCountries(); //we load the countries and read the json file
  }

  Future<void> loadCountries() async {
    final jsonString =
        await rootBundle.loadString('assets/countries.json');

    final jsonData = jsonDecode(jsonString);//converting json text in dart data

    setState(() {      //tells that my data has changed, re build the UI
      countries = jsonData['countries'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
      ),

      body: countries.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];

                return ListTile(
                  title: Text(country['name']),
                  subtitle: Text(country['capital']),
                  onTap: () {
                    showCountryDetails(context, country);
                  },
                );
              },
            ),
    );
  }

  void showCountryDetails(
    BuildContext context,
    dynamic country,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(country['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Code: ${country['code']}'),
              Text('Capital: ${country['capital']}'),
              Text('Region: ${country['region']}'),
              Text('Population: ${country['population']}'),
              Text('Currency: ${country['currency']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}