enum PetType {
  cat("Cat"),
  dog("Dog");

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
