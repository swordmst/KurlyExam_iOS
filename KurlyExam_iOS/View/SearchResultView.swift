//
//  SearchResultView.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/14/25.
//
import SwiftUI

struct SearchResultView: View {
    @EnvironmentObject var model: SearchModel
    
    var body: some View {
        VStack {
            resultCount()
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(model.searchResult.items, id: \.self) { item in
                        resultItem(item)
                        Divider()
                    }
                }
            }
        }
    }
    
    func resultCount() -> some View {
        HStack {
            Text("\(model.searchResult.count)개의 저장소")
            Spacer()
        }.foregroundStyle(.secondary)
    }
    
    func resultItem(_ item: Item) -> some View {
        //TODO: 아이템 View 작업 필요
        HStack {
            Text(item.name ?? "")
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
        }
        .background(
            Capsule().foregroundStyle(.gray.opacity(0.2))
        )
    }
}

#Preview {
    SearchResultView()
        .environmentObject(SearchModel())
}
