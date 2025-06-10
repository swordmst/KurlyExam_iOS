//
//  SearchModel.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/10/25.
//

import Foundation
import SwiftUI

class SearchModel: ObservableObject {
    @Published private(set) var list: [RecentSearchTextItem] = []
    @ObservedObject var recentModel = RecentSearchTextModel()
    @Published var searchText: String = ""
    
    init() {
        list = recentModel.list
    }
    
    @MainActor
    func search() {
        //TODO: Enpoint API연동
        list = recentModel.add(searchText)
    }
    
    @MainActor
    func removeRecentItem(_ item: RecentSearchTextItem) {
        list = recentModel.remove(item.text)
    }
    
    @MainActor
    func removeAllRecentItem() {
        list = recentModel.removeAll()
    }
}
