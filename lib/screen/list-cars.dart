// ignore_for_file: file_names

import 'dart:ffi';

import 'package:flutter/material.dart';

import '../model/race-car.dart';

import '../api/race-cars.dart';

class ListaCars extends StatefulWidget {
  const ListaCars({Key? key, required this.titulo}) : super(key: key);
  final String titulo;

  @override
  ListaCarsState createState() => ListaCarsState();
}

class ListaCarsState extends State<ListaCars> {
  //recebendo para preencher
  final name = TextEditingController();
  final year = TextEditingController();
  final color = TextEditingController();
  final price = TextEditingController();
  final brand = TextEditingController();
  final imageURL = TextEditingController();
  final formKey = GlobalKey<FormState>();

  int tamanhoList = 0;
  List<RaceCar> listaCars = [];

  @override
  void initState() {
    Future<List<RaceCar>> listaCars = RaceCarApi.getAll();

    listaCars.then((newListaCars) {
      setState(() {
        this.listaCars =
            newListaCars; //pega o resultado da lista e coloca em uma nova lista para inicializar
        tamanhoList = newListaCars.length;
      });
    });
  }

  _carregarLista() {
    Future<List<RaceCar>> noteListFuture = RaceCarApi.getAll();
    noteListFuture.then((newListaCars) {
      setState(() {
        listaCars = newListaCars; // atualiza a lista
        tamanhoList = newListaCars.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //estrutura estetica do cabeçalho
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      body: listaCar(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addCars();
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 101, 101, 101),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget campoName() {
    //onde será digitado o nome, faz a verificação do preenchimento
    return TextFormField(
      controller: name,
      keyboardType: TextInputType.text,
      validator: (valor) {
        if (valor!.isEmpty) {
          return "Campo Obrigatorio";
        }
      },
      decoration: const InputDecoration(
        hintText: 'Nome',
        labelText: 'Nome',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget campoYear() {
    //onde será digitado o ano, faz a verificação do preenchimento
    return TextFormField(
      controller: year,
      keyboardType: TextInputType.text,
      validator: (valor) {
        if (valor!.isEmpty) {
          return "Campo Obrigatorio";
        }
      },
      decoration: const InputDecoration(
        hintText: 'Ano',
        labelText: 'Ano',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget campoColor() {
    //onde será digitado a cor, faz a verificação do preenchimento
    return TextFormField(
      controller: color,
      keyboardType: TextInputType.text,
      validator: (valor) {
        if (valor!.isEmpty) {
          return "Campo Obrigatorio";
        }
      },
      decoration: const InputDecoration(
        hintText: 'Cor',
        labelText: 'Cor',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget campoBrand() {
    return TextFormField(
      controller: brand,
      keyboardType: TextInputType.number,
      validator: (valor) {
        if (valor!.isEmpty) {
          return "Campo Obrigatorio";
        }
      },
      decoration: const InputDecoration(
        hintText: 'Marca',
        labelText: 'Marca',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget campoPrice() {
    //onde será digitado o preço, faz a verificação do preenchimento
    return TextFormField(
      controller: price,
      keyboardType: TextInputType.text,
      validator: (valor) {
        if (valor!.isEmpty) {
          return "Campo Obrigatorio";
        }
      },
      decoration: const InputDecoration(
        hintText: 'Preço',
        labelText: 'Preço',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget campoImageURL() {
    //onde será digitado a URL da imagem, faz a verificação do preenchimento
    return TextFormField(
      controller: imageURL,
      keyboardType: TextInputType.text,
      validator: (valor) {
        if (valor!.isEmpty) {
          return "Campo Obrigatorio";
        }
      },
      decoration: const InputDecoration(
        hintText: 'URL da imagem',
        labelText: 'URL da imagem',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget listaCar() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: tamanhoList,
      itemBuilder: (context, index) {
        return GestureDetector(
          key: Key("RaceCar#$index"),
          child: Column(
            children: [
              ListTile(
                title: Text(listaCars[index].name),
                subtitle: Text("${listaCars[index].year} -R\$ ${listaCars[index].price.toStringAsFixed(2)}"),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(listaCars[index].imageURL),
                ),
              ),
            ],
          ),
          onTap: () {
            atualizarCar(listaCars[index]);
          },
        );
      },
    );
  }

  void addCars() {
    // metodo de adicionar
    name.text = ''; //recebe os dados
    year.text = '';
    color.text = '';
    price.text = '';
    imageURL.text = '';

    showDialog(
        // estrutura onde estarão todos os campos, junto com verificação
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Salvar Carro"),
            content: Container(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    campoName(),
                    const Divider(
                      color: Colors.transparent,
                      height: 20.0,
                    ),
                    campoBrand(),
                    const Divider(
                      color: Colors.transparent,
                      height: 20.0,
                    ),
                    campoYear(),
                    const Divider(
                      color: Colors.transparent,
                      height: 20.0,
                    ),
                    campoColor(),
                    const Divider(
                      color: Colors.transparent,
                      height: 20.0,
                    ),
                    campoPrice(),
                    const Divider(
                      color: Colors.transparent,
                      height: 20.0,
                    ),
                    campoImageURL(),
                    const Divider(
                      color: Colors.transparent,
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              //botão de inserir q verifica se é valido e recarrega a lista para já ser atualizada
              TextButton(
                  child: const Text("salvar"),
                  onPressed: () {
                    RaceCarApi.create(
                      RaceCar(
                        0,
                        int.parse(brand.text),
                        name.text,
                        int.parse(year.text),
                        color.text,
                        int.parse(price.text),
                        imageURL.text,
                      )
                    );
                    _carregarLista();
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
    }

    void atualizarCar(RaceCar car) {
      //metodo para receber as novas informações
      name.text = car.name;
      year.text = "${car.year}";
      color.text = car.color;
      price.text = "${car.price}";

      showDialog(
          //estrutura aonde os campos de atualizar se encontram
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atualizar carro"),
              content: Container(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      campoName(),
                      const Divider(
                        color: Colors.transparent,
                        height: 20.0,
                      ),
                      campoYear(),
                      const Divider(
                        color: Colors.transparent,
                        height: 20.0,
                      ),
                      campoColor(),
                      const Divider(
                        color: Colors.transparent,
                        height: 20.0,
                      ),
                      campoPrice(),
                      const Divider(
                        color: Colors.transparent,
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  //botão de atualizar, q verifica e já recarrega a lista para sempre ta atualizada
                  child: const Text("Atualizar"),
                  onPressed: () {
                      RaceCarApi.update(
                        RaceCar(
                          int.parse(car.id.toString()),
                          int.parse(brand.text),
                          name.text,
                          int.parse(year.text),
                          color.text,
                          int.parse(price.text),
                          imageURL.text,
                        )
                      );
                      _carregarLista();
                      Navigator.of(context).pop();
                  },
                ),
                  TextButton(//botão de deletar
                     child: const Text("Deletar"),
                     onPressed: () {
                      RaceCarApi.delete(car.id);
                      _carregarLista();
                      Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
  }
}