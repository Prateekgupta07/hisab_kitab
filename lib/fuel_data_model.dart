class FuelData {
  final int? id;
  final double meter;
  final double rate;
  final double amount;
  final String? date;
  final String fuelType;


  FuelData({ this.date, this.id, required this.meter, required this.rate, required this.amount, required this.fuelType});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meter': meter,
      'rate': rate,
      'amount': amount,
      'date': date ,
      'fuelType': fuelType
    };
  }

  @override
  String toString() {
    return 'FuelData{ id: $id, meter: $meter, rate: $rate, amount: $amount, date: $date, fuelType: $fuelType}';
  }
}
