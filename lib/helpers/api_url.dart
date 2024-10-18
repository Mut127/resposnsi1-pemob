class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/';
  static const String registrasi = baseUrl + 'api/registrasi';
  static const String login = baseUrl + 'api/login';
  static const String listGenre = baseUrl + 'api/buku/genre';
  static const String createGenre = baseUrl + 'api/buku/genre';
  static String updateGenre(int id) {
    return baseUrl + 'api/buku/genre/' + id.toString() + '/update';
  }

  static String showGenre(int id) {
    return baseUrl + 'api/buku/genre' + id.toString();
  }

  static String deleteGenre(int id) {
    return baseUrl + 'api/buku/genre/' + id.toString() + '/delete';
  }
}
