import Foundation
import Combine


class BookDetailViewModel: ObservableObject {
    var title: String {
        return self.book.title
    }
    var subtitle: String {
        return self.book.subtitle
    }
    var authors: String {
        return self.book.authors
    }
    var publisher: String {
        return self.book.publisher
    }
    var isbn10: String{
        return self.book.isbn10
    }
    var isbn13: String {
        return self.book.isbn13
    }
    var pages: String {
        return self.book.pages
    }
    var year: String{
        return self.book.year
    }
    var rating: String {
        return self.book.rating
    }
    var desc: String {
        return self.book.desc
    }
    var price: String {
        return self.book.price
    }
    var image: String {
        return self.book.image
    }
    var url: String {
        return self.book.url
    }
    
    private var cancellable: AnyCancellable?
    
    @Published private var book = BookDetail.placeholder()
    
    func getBookInfo(isbn: String) {
        self.cancellable =
            APIExtension().getBookById(bookId: isbn)
            .catch { _ in Just(BookDetail.placeholder()) }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { book in
                    self.book = book
                  })
    }
}
