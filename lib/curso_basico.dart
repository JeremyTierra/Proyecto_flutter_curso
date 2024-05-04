import 'dart:convert';
import 'package:curso_basico_flutter/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CursoBasicoPage extends StatefulWidget {
  const CursoBasicoPage({Key? key}) : super(key: key);

  @override
  State<CursoBasicoPage> createState() => _CursoBasicoPageState();
}

class _CursoBasicoPageState extends State<CursoBasicoPage> {
  List<dynamic> data = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData(); // Llama a la función fetchData() al iniciar el estado
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse("https://www.yanditv.com/api/curso_basico"));
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    }
  }

  List<dynamic> filterData(String query) {
    return data
        .where((item) =>
            item['nombre'].toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchData(data));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final item = data[index];
          final name = item['nombre'];
          final isSoftware = item['carrera'] == "SOFTWARE";
          final initials = name!
              .split(' ')
              .map((e) => e[0])
              .take(2)
              .join()
              .toUpperCase(); // Obtener las iniciales de los nombres
          return Card(
            color: isSoftware
                ? Colors.blue
                : Colors.grey[400], // Establecer el color de fondo como azul
            child: ListTile(
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Text(initials,
                        style: TextStyle(color: Colors.grey[700])),
                    backgroundColor: Colors.white70,
                  ),
                  Text('Cédula: ${item['nombre'] ?? ''}',
                      style: TextStyle(color: Colors.white)),
                  Text('Cédula: ${item['cedula'] ?? ''}',
                      style: TextStyle(color: Colors.white)),
                  Text('Correo: ${item['correo'] ?? ''}',
                      style: TextStyle(color: Colors.white)),
                  Text('Celular: ${item['celular'] ?? ''}',
                      style: TextStyle(color: Colors.white)),
                  Text('Carrera: ${item['carrera'] ?? ''}',
                      style: TextStyle(color: Colors.white)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          '${item['carrera'] != null && item['carrera'] != "" ? item['carrera'] : 'Externo'}'),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchData extends SearchDelegate<String> {
  final List<dynamic> data;

  SearchData(this.data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredData = query.isEmpty
        ? data
        : data
            .where((item) =>
                item['nombre'].toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (BuildContext context, int index) {
        final item = filteredData[index];
        final name = item['nombre'];
        final isSoftware = item['carrera'] == "SOFTWARE";
        final initials = name!
            .split(' ')
            .map((e) => e[0])
            .take(2)
            .join()
            .toUpperCase(); // Obtener las iniciales de los nombres
        return Card(
          color: isSoftware
              ? Colors.blue
              : Colors.white, // Establecer el color de fondo como azul
          child: ListTile(
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    child: Text(initials,
                        style: TextStyle(
                          color: Colors
                              .red, // Establece el color del texto como blanco
                        ))),
                Text('Cédula: ${item['nombre'] ?? ''}'),
                Text('Cédula: ${item['cedula'] ?? ''}'),
                Text('Correo: ${item['correo'] ?? ''}'),
                Text('Celular: ${item['celular'] ?? ''}'),
                Text('Carrera: ${item['carrera'] ?? ''}'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        '${item['carrera'] != null && item['carrera'] != "" ? item['carrera'] : 'Externo'}'),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredData = query.isEmpty
        ? data
        : data
            .where((item) =>
                item['nombre'].toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (BuildContext context, int index) {
        final item = filteredData[index];
        return ListTile(
          title: Text(item['nombre']),
          onTap: () {
            query = item['nombre'];
            showResults(context);
          },
        );
      },
    );
  }
}
