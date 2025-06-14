//
//  ContentView.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/9/25.
//

import SwiftUI

enum NavigationContent: Hashable {
    case weblink(String?)
}

struct ContentView: View {
    @EnvironmentObject var model: SearchModel
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if model.searchText.isEmpty {
                    RecentItemView() {
                        model.searchText = $0
                        model.search()
                    }
                    .environmentObject(model)
                    Spacer()
                } else if model.isSearching {
                    
                } else {
                    SearchResultView() {
                        path.append(NavigationContent.weblink($0))
                    }
                    .environmentObject(model)
                }
            }
            .navigationTitle("Search")
            .navigationDestination(for: NavigationContent.self) { destination in
                switch destination {
                case .weblink(let link):
                    WebView(link)
                        .navigationTitle("Repo Detail")
                }
            }
        }
        .searchable(
            text: $model.searchText,
            placement: .navigationBarDrawer,
            prompt: "Search..."
          )
        .onSubmit(of: .search) {
            model.search()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SearchModel())
}
