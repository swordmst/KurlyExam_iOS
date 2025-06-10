//
//  KurlyExam_iOSTests.swift
//  KurlyExam_iOSTests
//
//  Created by 허성연 on 6/9/25.
//

import Testing
@testable import KurlyExam_iOS

struct KurlyExam_iOSTests {
    @Test("Add From RecentSearchTextModel") func addRecentSearchText() async throws {
        let model = RecentSearchTextModel()
        model.add("test")
        
        #expect(model.list.count == 1 && model.list.first?.text == "test")
        
        let date = model.list.first?.date
        model.add("test")
        #expect(model.list.count == 1 && model.list.first?.date != date)
    }
    
    @Test("Remove, RemoveAll From RecentSearchTextModel") func removeRecentSearchText() async throws {
        let model = RecentSearchTextModel()
        model.add("test")
        model.add("test1")
        model.add("test2")
        model.add("test3")
        
        #expect(model.list.count == 4)
        
        model.remove("test5")
        #expect(model.list.count == 4)
        
        model.remove("test")
        #expect(model.list.first(where: { $0.text == "test"}) == nil)
        
        model.removeAll()
        #expect(model.list.count == 0)
    }
}
