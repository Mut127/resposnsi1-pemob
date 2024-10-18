class Genre {
  int? id;
  String? bookTitle;
  String? bookGenre;
  String? coverType;
  Genre({this.id, this.bookTitle, this.bookGenre, this.coverType});

  factory Genre.fromJson(Map<String, dynamic> obj) {
    return Genre(
        id: obj['id'],
        bookTitle: obj['book_title'],
        bookGenre: obj['book_genre'],
        coverType: obj['cover_type']);
  }
}
