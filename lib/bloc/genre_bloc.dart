import 'dart:convert';
import 'package:responsi1_muthiakhanza_c/helpers/api.dart';
import 'package:responsi1_muthiakhanza_c/helpers/api_url.dart';
import 'package:responsi1_muthiakhanza_c/model/genre.dart';

class GenreBloc {
  static Future<List<Genre>> getGenres() async {
    String apiUrl = ApiUrl.listGenre;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listGenre = (jsonObj as Map<String, dynamic>)['data'];
    List<Genre> genres = [];
    for (int i = 0; i < listGenre.length; i++) {
      genres.add(Genre.fromJson(listGenre[i]));
    }
    return genres;
  }

  static Future addGenre({Genre? genre}) async {
    String apiUrl = ApiUrl.createGenre;
    var body = {
      "book_title": genre!.bookTitle,
      "book_genre": genre.bookGenre,
      "cover_type": genre.coverType,
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateGenre({required Genre genre}) async {
    String apiUrl = ApiUrl.updateGenre(genre.id!);
    print(apiUrl);
    var body = {
      "book_title": genre.bookTitle,
      "book_genre": genre.bookGenre,
      "cover_type": genre.coverType,
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteGenre({int? id}) async {
    String apiUrl = ApiUrl.deleteGenre(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
