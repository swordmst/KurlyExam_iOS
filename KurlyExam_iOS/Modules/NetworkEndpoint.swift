//
//  NetworkEndpoint.swift
//  NetworkModule
//
//  Created by 허성연 on 4/18/25.
//

import Foundation
import Alamofire

public enum ContentType: Sendable {
    case json
    case none
    case custom(String)
    
    var value: String {
        switch self {
        case .json:
            return "application/json"
        case .none:
            return ""
        case .custom(let value):
            return value
        }
    }
}

public enum NetworkMethod: String, Sendable {
    case GET
    case POST
}

public typealias NetworkParameters = [String: any Any & Sendable]
public typealias NetworkHeaders = [String: String]

public struct NetworkEndpoint: Sendable {
    var method: NetworkMethod
    var baseURL: String?
    var path: String

    var headers: NetworkHeaders
    var parameters: NetworkParameters?
    var contentType: ContentType
    
    public init(method: NetworkMethod,
                baseURL: String? = nil,
                path: String,
                headers: NetworkHeaders? = nil,
                contentType: ContentType = .json,
                parameters: NetworkParameters? = nil) {

        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers ?? [:]
        self.parameters = parameters
        self.contentType = contentType
    }
}

extension NetworkEndpoint {
    var urlRequest: URLRequest? {
        let urlStr = "\(baseURL ?? "")\(path)"
        guard let url = URL(string: urlStr) else { return nil }
        var request = URLRequest(url: url)
        
        request.method = HTTPMethod(rawValue: method.rawValue)
        request.headers = HTTPHeaders(headers)
        
        if let parameters = parameters {
            return try? JSONEncoding(options: [.withoutEscapingSlashes]).encode(request, with: parameters)
        }
        
        return request
    }
}
