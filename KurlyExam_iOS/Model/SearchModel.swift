//
//  SearchModel.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/10/25.
//

import Foundation
import SwiftUI

struct SearchResult {
    let text: String
    let count: Int
    let page: Int
    let items: [Item]
    
    init(text: String, count: Int = 0, page: Int = 1, items: [Item] = []) {
        self.text = text
        self.count = count
        self.page = page
        self.items = items
    }
}

class SearchModel: ObservableObject {
    private let recentModel = RecentSearchTextModel()
    private let network = NetworkModule()
    
    @Published private(set) var list: [RecentSearchTextItem] = []
    @Published var searchText: String = "" {
        didSet {
            isSearching = searchText != ""
            updateAutoCompleteList(searchText)
        }
    }
    @Published var isSearching: Bool = false
    @Published var autoCompleteList: [RecentSearchTextItem] = []
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var searchResult = SearchResult(text: "")
    
    init() {
        updateRecentList(recentModel.list)
    }
    
    @MainActor
    func search() {
        isSearching = false
        searchResult = SearchResult(text: searchText)
        updateSearchResult()
        updateRecentList(recentModel.add(searchText))
    }
    
    @MainActor
    func updateSearchResult() {
        Task {
            let path = "https://api.github.com/search/repositories?q=\(searchResult.text)&page=\(searchResult.page)"
            let endpoint = NetworkEndpoint(method: .GET, path: path)
            
            do {
                isLoading = true
                let result: GithubRepoModel = try await network.request(endpoint)
                isLoading = false
                
                searchResult = SearchResult(text: searchResult.text,
                                            count: result.totalCount ?? 0,
                                            page: searchResult.page + 1,
                                            items: searchResult.items + (result.items ?? []))
            } catch {
                isLoading = false
                //TODO: Error 처리
            }
        }
    }
    
    @MainActor
    func removeRecentItem(_ item: RecentSearchTextItem) {
        updateRecentList(recentModel.remove(item.text))
    }
    
    @MainActor
    func removeAllRecentItem() {
        updateRecentList(recentModel.removeAll())
    }
    
    @MainActor
    func checkListUpdate(_ item: Item) {
        guard searchResult.items.count > 0 else { return }
        let remainCount = 10
        let index = searchResult.items.count > remainCount ? searchResult.items.count - remainCount : 0
        if searchResult.items[index] == item {
            updateSearchResult()
        }
    }
    
    private func updateRecentList(_ items: [RecentSearchTextItem]) {
        list = Array(items.prefix(10))
    }
    
    private func updateAutoCompleteList(_ text: String) {
        autoCompleteList = recentModel.list.filter { $0.text.contains(text) }
    }
}
