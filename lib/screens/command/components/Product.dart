import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class ProductLine extends StatefulWidget {
  const ProductLine({Key? key, required this.create}) : super(key: key);

  final bool create;

  @override
  _ProductLineState createState() => _ProductLineState();
}

class _ProductLineState extends State<ProductLine> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Libellé"),
          TextFormField(
            decoration: const InputDecoration(hintText: 'libellé'),
          ),
        ],
      ),),
      Padding(padding: EdgeInsets.all(defaultPadding)),
      Expanded(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Modèle"),
          TextFormField(
            decoration: const InputDecoration(hintText: 'modèle'),
          ),
        ],
      ),),
      Padding(padding: EdgeInsets.all(defaultPadding)),
      Expanded(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Quantité"),
          TextFormField(
            decoration: const InputDecoration(hintText: 'quantité'),
          ),
        ],
      ),),
      Padding(padding: EdgeInsets.all(defaultPadding)),
      Expanded(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Prix Unitaire"),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Prix unitaire'),
          ),
        ],
      ),),
      if(!widget.create)
        Padding(padding: EdgeInsets.all(defaultPadding)),
      if(!widget.create)
        Expanded(child: Column(
          children: [
            Text("Etat"),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Etat'),
            ),
          ],
        ),),
    ],);
  }
}
