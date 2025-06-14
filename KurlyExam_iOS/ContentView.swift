//
//  ContentView.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/9/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: SearchModel
    
    var body: some View {
        NavigationView {
            VStack {
                if model.searchText.isEmpty, model.searchResult.count == 0 {
                    RecentItemView()
                        .environmentObject(model)
                    Spacer()
                } else {
                    SearchResultView()
                        .environmentObject(model)
                }
            }
            .navigationTitle("Search")
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
