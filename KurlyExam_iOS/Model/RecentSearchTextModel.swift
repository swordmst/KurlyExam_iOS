//
//  RecentSearchTextModel.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/10/25.
//
import Foundation

struct RecentSearchTextItem: Sendable, Codable, Hashable, Equatable {
    var text: String
    var date = Date()
    
    mutating func updateDate() {
        date = Date()
    }
}

class RecentSearchTextModel: ObservableObject {
    private(set) var list: [RecentSearchTextItem] = [] {
        didSet {
            update()
        }
    }
    
    private let userDefaults = UserDefaultsManager()
    private let key = "recentSearchText"
    
    init() {
        load()
    }
    
    private func load() {
        list = (try? userDefaults.get(key: key)) ?? []
    }
    
    @discardableResult
    func add(_ text: String) -> [RecentSearchTextItem] {
        if let index = list.firstIndex(where: { $0.text == text }) {
            list.remove(at: index)
        }
        list.insert(RecentSearchTextItem(text: text), at: 0)
        return list
    }

    @discardableResult
    func remove(_ text: String) -> [RecentSearchTextItem] {
        list = list.filter({ $0.text != text })
        return list
    }
    
    @discardableResult
    func removeAll() -> [RecentSearchTextItem] {
        list = []
        return list
    }
    
    private func update() {
        try? userDefaults.set(value: list, key: key)
    }
}
