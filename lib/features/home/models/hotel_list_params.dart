class HotelListParams {
  String search;
  String checkIn;
  String checkOut;
  String person;
  String page;
  String sort;

  HotelListParams({
    required this.search,
    required this.checkIn,
    required this.checkOut,
    required this.person,
    required this.page,
    required this.sort,
  });

  Map<String, dynamic> queryParameters() => {
        "search": search,
        "checkin": checkIn,
        "checkout": checkOut,
        "person": person,
        "page": page,
        "sort": sort,
      };
}
