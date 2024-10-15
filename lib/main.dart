import 'dart:io';

import 'package:cotacoes_app/widgets/card_bolsa_valores.dart';
import 'package:cotacoes_app/widgets/card_cotacao_dollar.dart';
import 'package:cotacoes_app/widgets/card_outras_moedas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'moeda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeMaterial(),
    );
  }
}

class HomeMaterial extends StatefulWidget {
  const HomeMaterial({super.key});

  @override
  State<HomeMaterial> createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  late Future<Map<String, dynamic>> dadosCotacoes;

  @override
  void initState() {
    super.initState();
    dadosCotacoes = getDadosCotacoes();
  }

  Future<Map<String, dynamic>> getDadosCotacoes() async {
    try {
      final res = await http.get(
        Uri.parse(
          'http://api.hgbrasil.com/finance/quotations?key=<suakey>',
        ),
      );

      if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexão';
      }

      final data = jsonDecode(res.body);

      //print(data["results"]["currencies"]["USD"]);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cotações Brasil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
          future: dadosCotacoes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              String name = snapshot.data!["results"]["currencies"]["USD"]["name"];

              print("name" + name);
              double buy = snapshot.data!["results"]["currencies"]["USD"]["buy"];
              double sell = snapshot.data!["results"]["currencies"]["USD"]["sell"];
              double variation = snapshot.data!["results"]["currencies"]["USD"]["variation"];

              Moeda dolar =
                  Moeda(name: name, buy: buy, sell: sell, variation: variation);


              Moeda euro = Moeda()
                ..name = snapshot.data!["results"]["currencies"]["EUR"]["name"]
                ..variation =
                    snapshot.data!["results"]["currencies"]["EUR"]["variation"]
                ..sell = snapshot.data!["results"]["currencies"]["EUR"]["sell"]
                ..buy = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

              Moeda gbp = Moeda()
                ..name = snapshot.data!["results"]["currencies"]["GBP"]["name"]
                ..variation =
                    snapshot.data!["results"]["currencies"]["GBP"]["variation"]
                ..sell = snapshot.data!["results"]["currencies"]["GBP"]["sell"]
                ..buy = snapshot.data!["results"]["currencies"]["GBP"]["buy"];

              Moeda ars = Moeda()
                ..name = snapshot.data!["results"]["currencies"]["ARS"]["name"]
                ..variation =
                    snapshot.data!["results"]["currencies"]["ARS"]["variation"]
                ..sell = snapshot.data!["results"]["currencies"]["ARS"]["sell"]
                ..buy = snapshot.data!["results"]["currencies"]["ARS"]["buy"];

              List<Moeda> moedasList = [euro, gbp, ars, euro, gbp, ars, euro];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // main card
                    CardCotacaoDollar(moeda: dolar),
                    const SizedBox(height: 20),
                    const Text(
                      'Outras moedas',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Container(
                        child:
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: moedasList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CardOutrasMoedas(moeda: moedasList[index]);
                            },
                          ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bolsa de Valores',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CardBolsaValores(),
                        CardBolsaValores(),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Text("Algum erro aconteceu");
          }),
    );
  }
}

/*
class HomeMaterial extends StatefulWidget {
  const HomeMaterial({super.key});

  @override
  State<HomeMaterial> createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  late Future<Map<String, dynamic>> dadosCotacoes;

  @override
  void initState() {
    super.initState();
    dadosCotacoes = getDadosCotacoes();
  }

  Future<Map<String, dynamic>> getDadosCotacoes() async {
    print("get dados");
    try {
      final res = await http.get(
        Uri.parse(
          'http://api.hgbrasil.com/finance/quotations?key=<suakey>',
        ),
      );

      if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexão';
      }

      final data = jsonDecode(res.body);

      print(data);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cotações Brasil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
          future: dadosCotacoes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            final data = snapshot.data!;

            return Text("Dados lidos");
          }),
    );
  }
}
*/
