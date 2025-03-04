import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horas_v1/components/menu.dart';
import 'package:horas_v1/models/hour.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Hour> listHorus = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(user: widget.user),
      appBar: AppBar(
        title: Text('Horas V1'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
         onPressed: (){
           //Navigator.push(context, MaterialPageRoute(builder: (context) => AddHour()));
         },
        child: Icon(Icons.add)
      ),
      body: (listHorus.isEmpty) ? const Center(
        child: Text('Nada por aqui.\nVamos registrar um dia de trabalho?',
        textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
      ) : ListView(
          padding: EdgeInsets.only(left: 4, right: 4),
          children: List.generate(listHorus.length, (index) {
            Hour model = listHorus[index];
            return Dismissible(key: ValueKey<Hour>(model), direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 12),
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white,),
                ),
                onDismissed: (DismissDirection direction){
                  remove(model);
                },
                child: Card(
                   elevation: 2,
                   child: Column(
                     children: [
                       ListTile(
                         onLongPress: (){

                         },
                         onTap: () {},
                         leading: Icon(Icons.list_alt_rounded, size: 56,),
                         title: Text("Data: ${model.data} hora: ${model.minutos}"),
                         subtitle: Text(model.descricao != null ? model.descricao! : ''),
                       ),
                     ]
                   ),
                )
            );
          },
          ),
      ),
    );
  }

  void remove(Hour model) {
    setState(() {
      listHorus.remove(model);
    });
  }
}
