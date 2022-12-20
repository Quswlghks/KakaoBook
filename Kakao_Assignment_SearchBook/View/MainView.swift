

import SwiftUI

struct MainView: View {
    
    @State private var tabIndex = 0
    @StateObject var bookmark = BookmarkObject()
    @StateObject var history = BookListModel()
    
        
    var tabTitle: String {
        if tabIndex == 0 {return "카카오북"}
        if tabIndex == 1 {return "북마크"}
        return ""
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabIndex) {
                SearchView()
                    .onTapGesture { tabIndex = 0 }
                    .tabItem { Image(systemName: "magnifyingglass") }
                    .tag(0)
                    
                BookmarkView()
                    .onTapGesture { tabIndex = 1 }
                    .tabItem { Image(systemName: "bookmark") }
                    .tag(1)
            }.navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                            Text(tabTitle)
                            .font(.system(size: 30, weight: .bold))
                    }
                }
                .background()
        }
        .environmentObject(bookmark)
        .environmentObject(history)
    }
}

struct MainViewPreView: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
