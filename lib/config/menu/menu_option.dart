import 'package:flutter/material.dart';

class MenuOption {
  final String title;
  final String image;
  final IconData? icon;
  final String link;

  const MenuOption({
    required this.title,
    required this.image,
    this.icon,
    required this.link,
  });
}

const List<MenuOption> menuOptions = [
  MenuOption(
    title: 'Personajes',
    image: 'assets/images/characters.webp',
    link: '/characters',
  ),
  MenuOption(
    title: 'Episodios',
    image: 'assets/images/episodes.jpg',
    link: '/episodes',
  ),
  MenuOption(
    title: 'Configuración',
    image: '',
    icon: Icons.settings,
    link: '/settings',
  ),
];
