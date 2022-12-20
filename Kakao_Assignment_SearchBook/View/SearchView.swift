
import SwiftUI
import Foundation

struct SearchView: View {
    
    @EnvironmentObject var bookListVM : BookListModel
    
    @State var keyword: String = ""
    @State var Historykeyword: String = ""
    @FocusState var isEditing : Bool
    @State var isHistory : Bool = false
    
    var body: some View {
        ZStack{
            Color(red:249/255, green:224/255, blue: 0/255).ignoresSafeArea()//#F9E000
            VStack {
                VStack(alignment: .center, spacing: 5) {
                    
                    HStack(spacing: 5) { //SearchBar
                        TextField("책 정보를 입력해주세요.",
                                  text: $keyword,
                                  onCommit: {
                                    self.performSearch(keyword: keyword)
                                    isEditing = false
                                }
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isEditing)
                        .onTapGesture {
                            self.isEditing = true
                            isHistory=false
                        }
                        .padding()
                        
                        Button(action: {
                            self.performSearch(keyword: keyword)
                            isEditing = false
                            UIApplication.shared.endEditing()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    }
                    
                    if isHistory{ // 히스토리 클릭한 상태
                        BookListObject(bookListVM: bookListVM, keyword: Historykeyword)
                        .onAppear { self.performSearch(keyword: Historykeyword) }
                    }
                    
                    if (keyword == ""){ // 입력 안했거나 입력 중인 상태
                        VStack(alignment: .center) {
                            Text("검색 기록")
                                .bold()
                                .padding()
                            
                            ScrollView {
                                ForEach(bookListVM.booksSearched, id: \.self) { element in
                                    VStack{
                                        Divider()
                                        HStack{
                                            Button {
                                                Historykeyword=element
                                                keyword=Historykeyword
                                                isHistory=true
                                                self.performSearch(keyword: Historykeyword)
                                            } label: { Text(element) }
                                            Spacer()
                                            Image(systemName: "arrow.right")
                                                .scaledToFit()
                                        }.padding(9)
                                    }
                                }
                            }
                        }
                    }else if keyword != "" && !isHistory { //입력 완료 (히스토리 아닌 상태)
                        BookListObject(bookListVM: bookListVM, keyword: keyword)
                    }
                }
            }.frame(height: 650).onTapGesture{UIApplication.shared.endEditing()}.adaptsToKeyboard()// 화면 터치 시 키보드 내림
        }
    }
    func performSearch(keyword: String) {
        bookListVM.fetchBooks(keyword: keyword)
        if !bookListVM.booksSearched.contains(keyword){
            if(keyword != "") {bookListVM.booksSearched.append(keyword)}
        }
    
        if bookListVM.booksSearched.count > 10 {
            bookListVM.booksSearched = bookListVM.booksSearched.suffix(10)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

