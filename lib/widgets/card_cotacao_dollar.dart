
import 'package:flutter/material.dart';

import '../moeda.dart';

class CardCotacaoDollar extends StatelessWidget {

  final Moeda moeda;

  const CardCotacaoDollar({
    super.key, required this.moeda
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child:  Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '${moeda.name}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'R\$ ${moeda.sell}',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                '${moeda.variation}',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}