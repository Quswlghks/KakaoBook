import SwiftUI

struct BookDetailView: View {
    @ObservedObject  var bookDetailVM = BookDetailViewModel()
    @EnvironmentObject var bookmarkVM : BookmarkObject

    var id: String
    
    var body: some View {
        ZStack{
            Color(red: 255/255, green: 250/255, blue: 205/255).ignoresSafeArea()//레몬시폰
            ScrollView {
                HStack(spacing: 5) {
                    Text(self.bookDetailVM.title)
                        .font(.system(size: 25, weight: .semibold))
                    Button(action: {
                        if self.bookmarkVM.contains(self.bookDetailVM) {
                            self.bookmarkVM.remove(self.bookDetailVM)
                        } else {
                            self.bookmarkVM.add(self.bookDetailVM)
                        }
                        },
                           label: {
                        if bookmarkVM.contains(bookDetailVM){ Image(systemName: "bookmark.fill")}
                        else{Image(systemName: "bookmark")}
                    })
                    .padding()
                    
                }
                if let url = URL(string: bookDetailVM.image) {
                    Image(systemName: "book")
                        .data(url: url)
                        .scaledToFit()
                }
                VStack(alignment: .leading){
                    Group{
                        HStack(alignment: .firstTextBaseline){
                            Text("Author: ")
                                .bold()
                            Text(self.bookDetailVM.authors)
                        }.padding()
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("Subtitle: ")
                                .bold()
                            Text(self.bookDetailVM.subtitle)
                        }.padding()
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("isbn10: ")
                                .bold()
                            Text(self.bookDetailVM.isbn10)
                        }.padding()
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("isbn13: ")
                                .bold()
                            Text(self.bookDetailVM.isbn13)
                        }.padding()
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("Price: ")
                                .bold()
                            Text(self.bookDetailVM.price)
                        }.padding()
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("Publisher: ")
                                .bold()
                            Text(self.bookDetailVM.publisher)
                        }.padding()
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("Pages: ")
                                .bold()
                            Text(self.bookDetailVM.pages)
                        }.padding()
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("Descritpion: ")
                                .bold()
                            Text(self.bookDetailVM.desc)
                        }.padding()
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("rating: ")
                                .bold()
                            Text(self.bookDetailVM.rating)
                        }.padding()
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("year: ")
                                .bold()
                            Text(self.bookDetailVM.year)
                        }.padding()}
                                            
                        HStack(alignment: .firstTextBaseline){
                            Text("URL: ")
                                .bold()
                            Text(self.bookDetailVM.url)
                        }.padding()
                    
                }
            }.onAppear{self.bookDetailVM.getBookInfo(isbn: self.id) }
        }
    }
}

struct DetailTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

