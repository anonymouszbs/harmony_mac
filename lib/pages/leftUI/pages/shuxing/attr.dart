import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AttrPage extends StatefulWidget {
  const AttrPage({Key? key}) : super(key: key);

  @override
  State<AttrPage> createState() => _AttrPageState();
}

class _AttrPageState extends State<AttrPage> {
  @override
  Widget build(BuildContext context) {
    return Text('Attr页');
  }
}