class MenuOption {
  final String title;
  final String image;
  final String link;

  const MenuOption({
    required this.title,
    required this.image,
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
];
