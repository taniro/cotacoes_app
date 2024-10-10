import 'package:flutter/material.dart';

class CardBolsaValores extends StatelessWidget {
  const CardBolsaValores({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "IBOVESPA",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Sao Paulo, Brazil",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "1.69",
          style: TextStyle(
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
