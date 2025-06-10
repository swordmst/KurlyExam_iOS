//
//  SearchModel.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/10/25.
//

import Foundation
import SwiftUI

class SearchModel: ObservableObject {
    @ObservedObject var recentModel = RecentSearchTextModel()
    @Published var searchText: String = ""
    
    func search() {
        //TODO: Enpoint API연동
        recentModel.add(searchText)
    }
    
    @MainActor
    func recentList() -> [RecentSearchTextItem] {
        let sorted = recentModel.list.prefix(10)
        return Array(sorted)
    }
}
