
///Uses Dr. P.E. Watson's Formula.
///[height] is in [cm].
///[weight] is in [kg].
double calculateBodyWater(
    {required String gender,
    required int age,
    required double height,
    required double weight}) {
  if (gender.toLowerCase() == 'female') {
    return (2.447 - 0.09156 * age + 0.1074 * height + 0.3362 * weight);
  } else {
    return (-2.097 + 0.1069 * height + 0.2466 * weight);
  }
}
