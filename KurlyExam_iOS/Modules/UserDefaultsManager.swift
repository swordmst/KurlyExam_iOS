//
//  UserDefaultsManager.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/10/25.
//

import Foundation

class UserDefaultsManager {
    let defaults = UserDefaults.standard
    
    func set<T: Encodable>(value: T, key: String) throws {
        let data = try JSONEncoder().encode(value)
        defaults.set(data, forKey: key)
    }
    
    func get<T: Decodable>(key: String) throws -> T? {
        guard let data = defaults.object(forKey: key) as? Data else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func remove(key: String) {
        defaults.removeObject(forKey: key)
    }
}
