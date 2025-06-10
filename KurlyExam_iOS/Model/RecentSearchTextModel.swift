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
    @Published private(set) var list: [RecentSearchTextItem] = [] {
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
    
    func add(_ text: String) {
        if let index = list.firstIndex(where: { $0.text == text }) {
            list[index].updateDate()
        } else {
            list.append(RecentSearchTextItem(text: text))
        }
    }
    
    func remove(_ text: String) {
        list = list.filter({ $0.text != text })
    }
    
    func removeAll() {
        list = []
    }
    
    private func update() {
        try? userDefaults.set(value: list, key: key)
    }
}
