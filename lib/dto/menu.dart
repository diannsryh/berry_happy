class Menu {
  final int idMenu;
  final String menuName;
  final String descMenu;
  final int menuPrice;
  final String kategori;
  final String imageUrl;
   // Menambahkan properti kategori

  Menu({
    required this.idMenu,
    required this.menuName,
    required this.descMenu,
    required this.menuPrice,
    required this.kategori, // Menambahkan kategori ke konstruktor
    required this.imageUrl,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        idMenu: json['id_menu'] as int,
        menuName: json['nama_menu'] as String,
        descMenu: json['desc_menu'] as String,
        menuPrice: json['harga_menu'] as int,
        kategori: json['kategori'] as String, // Parsing kategori dari JSON
        imageUrl: json['img'] as String,
      );
}
