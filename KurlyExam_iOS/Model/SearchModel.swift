//
//  SearchModel.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/10/25.
//

import Foundation

class SearchModel: ObservableObject {
    @Published var searchText: String = ""
    
    func search() {
        //TODO: Enpoint API연동
    }
}
