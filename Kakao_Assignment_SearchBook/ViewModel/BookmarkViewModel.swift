
import Foundation

class BookmarkObject: ObservableObject, Identifiable {
    
    var books: [BookmarkViewModel]
    
    init() {
        self.books = []
    }

    func contains(_ book: BookDetailViewModel) -> Bool {
        for bookVM in books {
            if bookVM.id == book.isbn13 {
                return true
            }
        }
        return false
    }
    
    func add(_ book: BookDetailViewModel) {
        objectWillChange.send()
        books.append(BookmarkViewModel(id: book.isbn13, title: book.title))
    }
    
    func remove(_ book: BookDetailViewModel) {
        objectWillChange.send()
        books = books.filter{ ($0.id != book.isbn13) }
    }
}


struct BookmarkViewModel {
    var id: String = ""
    var title: String = ""
}



