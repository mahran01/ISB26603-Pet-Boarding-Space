enum PetType { cat, dog }

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
