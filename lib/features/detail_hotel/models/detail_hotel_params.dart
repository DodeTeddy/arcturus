class DetailHotelParams {
  String person;
  String checkIn;
  String checkOut;
  String country;
  String sort;

  DetailHotelParams({
    required this.person,
    required this.checkIn,
    required this.checkOut,
    required this.country,
    required this.sort,
  });

  Map<String, dynamic> queryParameters() => {
        "person": person,
        "checkin": checkIn,
        "checkout": checkOut,
        "country": country,
        "sort": sort,
      };
}
