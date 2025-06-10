//
//  RecentItemView.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/10/25.
//
import SwiftUI

struct RecentItemView: View {
    @EnvironmentObject var model: SearchModel
    
    var body: some View {
        VStack {
            ChipLayout(verticalSpacing: 8, horizontalSpacing: 8) {
                ForEach(model.list, id: \.self) { item in
                    chipItem(item)
                }
            }
            removeAllView()
        }
    }
    
    func chipItem(_ item: RecentSearchTextItem) -> some View {
        HStack {
            Text(item.text)
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                
            Button {
                model.removeRecentItem(item)
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 15, height: 15)
                    .padding(.trailing, 8)
                    .foregroundColor(.gray)
            }
        }
        .background(
            Capsule().foregroundStyle(.gray.opacity(0.2))
        )
    }
    func removeAllView() -> some View {
        HStack {
            Spacer()
            Button {
                model.removeAllRecentItem()
            } label: {
                Text("전체 삭제")
                    .foregroundColor(.red)
            }
        }
    }
}
