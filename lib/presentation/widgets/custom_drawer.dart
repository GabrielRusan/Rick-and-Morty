// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/routes.dart';
import 'package:rick_and_morty/styles/colors.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;
  const CustomDrawer({Key? key, required this.content}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  Widget _buildDrawer() {
    return Scaffold(
      body: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://rickandmortyapi.com/api/character/avatar/118.jpeg'),
            ),
            accountName: Text(
              'Gabriel Rusan',
              style: TextStyle(color: kRichBlack, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              'gabrieldwiputra12@gmail.com',
              style: TextStyle(color: kRichBlack, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.favoritePage);
            },
            child: const ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Favorite Characters'),
            ),
          ),
        ],
      ),
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          double slide = 255.0 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);
          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: widget.content,
              ),
            ],
          );
        },
      ),
    );
  }
}
