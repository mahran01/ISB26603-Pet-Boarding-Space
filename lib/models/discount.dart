import 'dart:math' as math;

enum DiscountType { deduction, percentage }

class Discount {
  final String code;
  double deduction;
  final double percentage;
  final DiscountType type;
  final double minimumSpent;
  final double maximumValue;

  Discount({
    required this.code,
    this.deduction = 0.0,
    this.percentage = 0.0,
    required this.type,
    this.minimumSpent = 0.0,
    this.maximumValue = double.infinity,
  });

  bool isValid(double price) {
    return minimumSpent <= price;
  }

  double getDiscount(double price) {
    switch (type) {
      case DiscountType.percentage:
        deduction = price * (percentage / 100);
        deduction = math.min(maximumValue, deduction);
      case DiscountType.deduction:
        return deduction;
    }
    return price;
  }
}
