class CharacterUtils {
  static String getStatus(String status) {
    switch (status) {
      case "Alive":
        return "alive";
      case "Dead":
        return "dead";
      case "unknown":
        return "unknown";
      case "":
        return "not_specified";
      default:
        return status;
    }
  }

  static String getSpecies(String species) {
    switch (species) {
      case "Human":
        return "human";
      case "Animal":
        return "animal";
      case "Alien":
        return "alien";
      case "Humanoid":
        return "humanoid";
      case "Mythological Creature":
        return "mythological";
      case "unknown":
        return "unknown";
      case "":
        return "not_specified";
      default:
        return species;
    }
  }

  static String getType(String type) {
    switch (type) {
      case "unknown":
        return "unknown";
      case "":
        return "not_specified";
      default:
        return type;
    }
  }

  static String getGender(String gender) {
    switch (gender) {
      case "Male":
        return "male";
      case "Female":
        return "female";
      case "Genderless":
        return "genderless";
      case "unknown":
        return "unknown";
      case "":
        return "not_specified";
      default:
        return gender;
    }
  }

  static String verifyValue(String text) {
    if (text.isEmpty) {
      return "not_specified";
    }

    if (text == "unknown") {
      return "unknown";
    }

    return text;
  }

  static String getValue(String title, String text) {
    switch (title) {
      case "status":
        return getStatus(text);
      case "species":
        return getSpecies(text);
      case "type":
        return getType(text);
      case "gender":
        return getGender(text);
      case "origin":
        return verifyValue(text);
      case "location":
        return verifyValue(text);
      default:
        return text;
    }
  }
}
