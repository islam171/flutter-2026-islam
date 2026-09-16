import "./models.dart";

class Library{

  Library({required this.items});

  final List<LibraryItem> items;

  void add(LibraryItem item) => this.items.add(item);

  Book? findByTitle(String title){
    for(LibraryItem item in this.items){
      if(item is Book && item.title == title){
        return item;
      }
    }
    return null;
  }

  String countryOf(String title){
    Book? book = findByTitle(title);
    String? country = book?.author?.country;
    return country ?? "Unknown";
  }

  late final DateTime openedAt;

  void open(){
    this.openedAt = DateTime.now();
  }

  String? _cachedReport;


  void report(){
    this._cachedReport ??= this._buildReport();
  }

  String _buildReport() {
    final buffer = StringBuffer('Library — ${items.length} item(s)');
    for (final item in items) {
      buffer.write('\n- ${item.describe()}');
    }
    return buffer.toString();
  }
}