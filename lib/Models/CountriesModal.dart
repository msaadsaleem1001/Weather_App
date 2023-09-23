

class CountriesModal{
  final String countryName;
  final String countryCode;
  final String countryFlag;

  CountriesModal({
    required this.countryName,
    required this.countryCode,
    required this.countryFlag,
  });
}

// Country Detail given by API
// [
//   {
//   name : "Afghanistan"
//   isoCode : "AF"
//   flag : "🇦🇫"
//   phonecode : "93"
//   currency : "AFN"
//   latitude : "33.00000000"
//   longitude : "65.00000000"
//   }
// ]