import Foundation
import Combine
import SwiftUI


struct APIExtension{
    enum Error: LocalizedError, Identifiable {
        var id: String {localizedDescription }
        
        case addressUnreachable(URL)
        case invalidResponse
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Invalid Response."
            case .addressUnreachable(_): return "Address is unreachable."
            }
        }
    }
    enum EndPoint {

        static let baseURL = URL(string: "https://api.itbook.store/1.0/")!
        
        case books(String)
        case book(String)
        
        var url: URL {
            switch self {
            case .books(let keyword):
                return EndPoint.baseURL.appendingPathComponent("search/\(keyword))")
            case .book(let isbn):
                return EndPoint.baseURL.appendingPathComponent("books/\(isbn)")
            }
        }
    }

    func getSearchBooks(keyword: String) -> AnyPublisher<[Book], Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.books(keyword).url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: BooksData.self, decoder: JSONDecoder())
            .map{$0.books}
            .catch { _ in Empty<[Book], Error>()}
            .eraseToAnyPublisher()
    }
    
    func getBookById(bookId: String) -> AnyPublisher<BookDetail, Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.book(bookId).url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: BookDetail.self, decoder: JSONDecoder())
            .catch { _ in Empty<BookDetail, Error>() }
            .eraseToAnyPublisher()
    }
    
}
