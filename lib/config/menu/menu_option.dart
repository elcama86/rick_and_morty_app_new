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
    title: 'characters',
    image: 'assets/images/characters.webp',
    link: '/characters',
  ),
  MenuOption(
    title: 'episodes',
    image: 'assets/images/episodes.jpg',
    link: '/episodes',
  ),
  MenuOption(
    title: 'locations',
    image: 'assets/images/locations.webp',
    link: '/locations',
  ),
  MenuOption(
    title: 'settings',
    image: '',
    icon: Icons.settings,
    link: '/settings',
  ),
];
