//
//  SearchResultView.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/14/25.
//
import SwiftUI
import Kingfisher

struct SearchResultView: View {
    @EnvironmentObject var model: SearchModel
    
    var body: some View {
        VStack {
            resultCount()
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(model.searchResult.items, id: \.self) { item in
                        resultItem(item)
                    }
                }
            }
        }
    }
    
    func resultCount() -> some View {
        HStack {
            Text("\(model.searchResult.count)개의 저장소")
            Spacer()
        }
        .foregroundStyle(.secondary).padding()
    }
    
    func resultItem(_ item: Item) -> some View {
        HStack(spacing: 20) {
            KFImage(URL(string: item.owner?.avatarURL ?? ""))
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name ?? "")
                    .font(.system(size: 16, weight: .bold))
                Text(item.owner?.login ?? "")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

#Preview {
    SearchResultView()
        .environmentObject(SearchModel())
}
