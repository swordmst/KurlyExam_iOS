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
    let action: @MainActor (String?) -> Void
    var body: some View {
        VStack {
            if model.searchResult.count > 0 {
                resultCount()
            }
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(model.searchResult.items, id: \.self) { item in
                        resultItem(item)
                    }
                    if model.isLoading {
                        loadingView().frame(height: 52)
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
            Spacer()
        }
        .padding()
        .background(Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
            action(item.htmlURL)
        }
        .onAppear {
            model.checkListUpdate(item)
        }
    }
    
    func loadingView() -> some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

#Preview {
    SearchResultView() { _ in }
        .environmentObject(SearchModel())
}
