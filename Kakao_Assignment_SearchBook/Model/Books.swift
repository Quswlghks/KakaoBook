
import Foundation


struct BooksData: Codable {
    let books: [Book]
}

struct Book: Codable {
    let title: String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String
    let url: String
}

struct BookDetail: Codable {
    let title: String
    let subtitle: String
    let authors: String
    let publisher: String
    let isbn10: String
    let isbn13: String
    let pages: String
    let year: String
    let rating: String
    let desc: String
    let price: String
    let image: String
    let url: String
    
    static func placeholder() -> BookDetail {
        return BookDetail(title: "", subtitle: "", authors: "", publisher: "", isbn10: "", isbn13: "", pages: "", year: "", rating: "", desc:"", price: "", image: "", url: "")
    }
}
