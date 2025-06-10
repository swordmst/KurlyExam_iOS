//
//  KurlyExam_iOSApp.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/9/25.
//

import SwiftUI

@main
struct KurlyExam_iOSApp: App {
    let model = SearchModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
