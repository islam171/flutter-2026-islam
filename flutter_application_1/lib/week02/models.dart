abstract class LibraryItem{
  LibraryItem({required this.title, required this.year});
  final String title;
  final int year;

  String describe();

  bool get isOld => this.year > 50;

}


class Author {
  final String name;
  final String? country;

  const Author({required this.name, this.country});

  @override
  String toString() {
    return this.name;
  }
}

enum Genre {
  craft("Craft"),
  theory("Theory"),
  unknown("Unknown");

  final String label;

  const Genre(this.label);

  static Genre fromString(String? raw){
    if(raw == null) return Genre.unknown;
    final norm = raw.trim().toLowerCase();

    for(Genre genre in Genre.values){
      if(genre.name.toLowerCase() == norm || genre.label.toLowerCase() == norm){
        return genre;
      }
    }

    return Genre.unknown;
  }

}

class Book extends LibraryItem with Borrowable{
  // final String title;
  // final int year;
  final Author author;
  final Genre genre;
  final String? description;
  final int pages;

  Book({
    required super.title,
    required super.year,
    required this.pages,
    required this.genre,
    required this.author,
    this.description
  });

  Book.missing()
      :
        pages = 0,
        genre = Genre.unknown,
        author = const Author(name: "Author unknown"),
        description = null,
  super(title: 'Unknown title', year: 0);

  factory Book.fromJson(Map<String, dynamic> json){
    return Book(
        title: json['title'],
        year: json['year'],
        pages: json['pages'],
        genre: Genre.fromString(json['genre']),
        author: json['author'],
        description: json['description'],
    );
  }

  bool get isLong {
    return this.pages > 400;
  }

  Book copyWith({
    String? title,
    int? year,
    int? pages,
    Author? author,
    Genre? genre,
    String? description,
  }) {
    return Book(
      title: title ?? this.title,
      year: year ?? this.year,
      pages: pages ?? this.pages,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
    );
  }

  @override
  String describe(){
    return "Hello";
  }


}

class Magazine extends LibraryItem{
  final int issue;

  Magazine({required super.title, required super.year, required this.issue});

  @override
  String describe(){
    return "Hello";
  }
}

mixin Borrowable on LibraryItem{
  String borrowLabel() => "Borrow $title";
}


class Ghost implements LibraryItem{
  Ghost({required this.title, required this.year});

  final String title;
  final int year;

  @override
  String describe() => "Title: $title";
  @override
  bool get isOld => this.year > 50;

}