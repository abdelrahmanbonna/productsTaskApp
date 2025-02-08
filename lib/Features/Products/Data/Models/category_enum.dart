enum Category {
    electronics,
    jewelery,
    mensClothing,
    womensClothing
}

extension CategoryExtension on Category {
    String get name {
        switch (this) {
            case Category.electronics:
                return 'electronics';
            case Category.jewelery:
                return 'jewelery';
            case Category.mensClothing:
                return 'men\'s clothing';
            case Category.womensClothing:
                return 'women\'s clothing';
        }
    }
}

Category getCategoryEnum(String category) {
        switch (category) {
            case 'electronics':
                return Category.electronics;
            case 'jewelery':
                return Category.jewelery;
            case 'men\'s clothing':
                return Category.mensClothing;
            case 'women\'s clothing':
                return Category.womensClothing;
            default:
                return Category.electronics;
        }
    }