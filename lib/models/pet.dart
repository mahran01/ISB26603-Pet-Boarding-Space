enum PetType {
  cat("cat"),
  dog("dog");

  final String value;

  const PetType(this.value);
}

class Pet {
  String name;
  PetType petType;
  int age;

  Pet({
    required this.name,
    required this.petType,
    required this.age,
  });
}
