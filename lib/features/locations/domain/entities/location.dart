class Location {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final DateTime created;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.created,
  });
}
