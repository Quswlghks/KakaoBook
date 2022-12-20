import SwiftUI
import Foundation

struct BookListObject: View {
    @ObservedObject var bookListVM: BookListModel
    
    var keyword: String
    
    var body: some View {
        Text("<\(keyword)>를 포함하는 책 검색").bold()
        
        if(bookListVM.books.isEmpty){
            VStack{
                Image("noBook").resizable().scaledToFit().frame(width: 100, height: 150)
                Text("검색결과가 없습니다.").font(.system(size: 20, weight: .bold))
            }.padding()
        }else {
            ZStack{
                Color(red: 255/255, green: 250/255, blue: 205/255)//레몬시폰
                ScrollView {
                    ForEach(bookListVM.books, id: \.id) { bookVM in
                        NavigationLink(
                            destination: BookDetailView(id: bookVM.id),
                            label: {
                                VStack{
                                    Divider()
                                    HStack {
                                        Text("\(bookVM.title)")
                                            .foregroundColor(.black)
                                        Spacer()
                                        Image(systemName: "arrow.right")
                                            .scaledToFit()
                                    }
                                    .padding(8)
                                }
                            }
                        )
                    }
                }.frame(height: 555)
            }
        }
    }
    
    
}

struct BookListObject_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
   }
}
