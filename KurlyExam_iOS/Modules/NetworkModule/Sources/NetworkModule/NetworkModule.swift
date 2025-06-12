// The Swift Programming Language
// https://docs.swift.org/swift-book

import Alamofire
import Foundation

public final class NetworkModule: Sendable {
    public init() {}
    public func request<T: Decodable & Sendable>(
        _ endpoint: NetworkEndpoint,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        guard let urlRequest = endpoint.urlRequest else {
            throw AFError.invalidURL(url: endpoint.urlRequest?.url ?? URL(fileURLWithPath: ""))
        }
        
        let request = AF.request(urlRequest)
        
        do {
            let (data, response) = try await withCheckedThrowingContinuation { continuation in
                request.responseData { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: (data, response.response))
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
            guard let response = response else { throw AFError.responseValidationFailed(reason: .dataFileNil) }

            guard 200..<300 ~= response.statusCode else { throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: response.statusCode)) }
            
            if data is T { return data as! T }
            
            if T.self is String.Type { return (String(data: data, encoding: .utf8) ?? "") as! T }

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error))
            }
        } catch {
            throw error
        }
    }
}
