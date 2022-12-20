import Foundation
import Combine

class BookListModel: ObservableObject {
    
    @Published var books: [BookModel] = []
    var booksSearched : [String] = []
    private var cancellable: AnyCancellable?
    
    func fetchBooks(keyword: String) {
        
        let keywordList = keyword.components(separatedBy: ",")
        if(keywordList.count == 2){ // 멀티서치
            MultisetBooks(keyword1: keywordList[0], keyword2: keywordList[1])
        }else{// 일반 서치
            setBooks(keyword: keyword)
        }
    }
    func setBooks(keyword: String){
        self.cancellable = APIExtension().getSearchBooks(keyword: keyword).map { books in
            books.map { BookModel(book: $0) }
        }
        .sink(receiveCompletion: { completion in
            if case .failure(let err) = completion {
                print("Retrieving data failed with error \(err)")
            }
        }, receiveValue: { BookModel in
            self.books = BookModel
        })
    }

    func MultisetBooks(keyword1: String, keyword2: String) {
        self.cancellable = APIExtension().getSearchBooks(keyword: keyword1)
        .map { books in
            books.map { BookModel(book: $0) }
        }
        .sink(receiveCompletion: { completion in
            if case .failure(let err) = completion {
                print("Retrieving data failed with error \(err)")
            }
        }, receiveValue: { BookModel in
            print("키워드 첫번째!!!!!!!\n\n")
            self.books.append(contentsOf: BookModel)
            print(self.books)
        })
        self.cancellable = APIExtension().getSearchBooks(keyword: keyword2).map { books in
            books.map { BookModel(book: $0) }
        }
        .sink(receiveCompletion: { completion in
            if case .failure(let err) = completion {
                print("Retrieving data failed with error \(err)")
            }
        }, receiveValue: { BookModel in
            print("키워드 2번째!!!!!!!\n\n")
            self.books.append(contentsOf: BookModel)
            print(self.books)
        })
    }}

struct BookModel {
    let book: Book
    
    var id: String {
        return self.book.isbn13
    }
    var title: String{
        return self.book.title
    }
}
