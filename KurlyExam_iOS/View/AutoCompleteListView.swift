//
//  AutoCompleteListView.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/14/25.
//
import SwiftUI

struct AutoCompleteListView: View {
    @EnvironmentObject var model: SearchModel
    
    let action: @MainActor (String) -> Void
    
    var body: some View {
        VStack {
            ForEach(model.autoCompleteList, id: \.self) { item in
                autoCompleteItem(item)
            }
            Spacer()
        }.padding()
    }
    
    func autoCompleteItem(_ item: RecentSearchTextItem) -> some View {
        HStack {
            Text(item.text)
            Spacer()
            Text("\(item.date.MMDotdd)")
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
        }
        .padding(6)
        .onTapGesture {
            action(item.text)
        }
    }
}

extension Date {
    var MMDotdd: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd" // 원하는 포맷 지정
        return formatter.string(from: self)
    }
}
