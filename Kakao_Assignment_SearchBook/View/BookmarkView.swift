
import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var bookmarkVM : BookmarkObject
    
    
    var body: some View {
        ZStack{
            Color(red:249/255, green:224/255, blue: 0/255).ignoresSafeArea()//#F9E000
            ZStack{
                Color(red: 255/255, green: 250/255, blue: 205/255)//레몬시폰
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(bookmarkVM.books, id:\.id) { bookmark in
                            NavigationLink(
                                destination: BookDetailView(id: bookmark.id),
                                label: {
                                    VStack{
                                        HStack(spacing: 10) {
                                            
                                            Text("\(bookmark.title)")
                                                .font(.system(size: 18))
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.right")
                                                .scaledToFit()
                                        }.padding(9)
                                        Divider()
                                    }
                                })
                            
                            
                        }
                    }.padding(.top, 5)
                    
                }
            }.frame(maxHeight: 630)
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
