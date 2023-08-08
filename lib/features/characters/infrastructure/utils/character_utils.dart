class CharacterUtils {
  static String getStatus(String status) {
    switch (status) {
      case "Alive":
        return "Vivo";
      case "Dead":
        return "Muerto";
      case "unknown":
        return "Desconocido";
      case "":
        return "No especificado";
      default:
        return status;
    }
  }

  static String getSpecies(String species) {
    switch (species) {
      case "Human":
        return "Humano";
      case "Animal":
        return "Animal";
      case "Alien":
        return "Alien";
      case "Humanoid":
        return "Humanoide";
      case "Mythological Creature":
        return "Criatura Mitológica";
      case "unknown":
        return "Desconocido";
      case "":
        return "No especificado";
      default:
        return species;
    }
  }

  static String getType(String type) {
    switch (type) {
      case "unknown":
        return "Desconocido";
      case "":
        return "No especificado";
      default:
        return type;
    }
  }

  static String getGender(String gender) {
    switch (gender) {
      case "Male":
        return "Masculino";
      case "Female":
        return "Femenino";
      case "unknown":
        return "Desconocido";
      case "":
        return "No especificado";
      default:
        return gender;
    }
  }

  static String verifyValue(String text) {
    if (text.isEmpty) {
      return "No especificado";
    }

    if (text == "unknown") {
      return "Desconocido";
    }

    return text;
  }

  static String getValue(String title, String text) {
    switch (title) {
      case "Estado":
        return getStatus(text);
      case "Especie":
        return getSpecies(text);
      case "Tipo":
        return getType(text);
      case "Género":
        return getGender(text);
      case "Origen":
        return verifyValue(text);
      case "Ubicación":
        return verifyValue(text);
      default:
        return text;
    }
  }
}
