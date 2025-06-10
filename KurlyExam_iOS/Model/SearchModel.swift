//
//  SearchModel.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/10/25.
//

import Foundation
import SwiftUI

class SearchModel: ObservableObject {
    private let recentModel = RecentSearchTextModel()
    
    @Published private(set) var list: [RecentSearchTextItem] = []
    @Published var searchText: String = ""
    
    init() {
        updateRecentList(recentModel.list)
    }
    
    @MainActor
    func search() {
        //TODO: Enpoint API연동
        updateRecentList(recentModel.add(searchText))
    }
    
    @MainActor
    func removeRecentItem(_ item: RecentSearchTextItem) {
        updateRecentList(recentModel.remove(item.text))
    }
    
    @MainActor
    func removeAllRecentItem() {
        updateRecentList(recentModel.removeAll())
    }
    
    func updateRecentList(_ items: [RecentSearchTextItem]) {
        list = Array(items.prefix(10))
    }
}
