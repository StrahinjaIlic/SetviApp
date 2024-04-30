//
//  NetworkService.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 28.4.24..
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case failedRequest
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "[🔥] Bad response from URL"
        case .failedRequest:
            return "[⚠️] Unknown error occurred"
        }
    }
}

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T
}

class NetworkService {

    static let shared = NetworkService()
    
    private init() {}
}

extension NetworkService: NetworkServiceProtocol {
    
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = URL(string: endpoint.path) else {
            throw NetworkError.invalidURL
        }
        // I lost some time to check why suddenly i got bad response, seems i reached some limit with API calls
        // I had to print response in order to understand what suddenly went wrong
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
//            print(response)
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as NSError {
            if error.code == NSURLErrorCancelled {
                try await Task.sleep(nanoseconds: 5 * 1000)
                return try await fetch(endpoint: endpoint)
            } else {
                throw error
            }
        }
    }
}

extension NetworkService {
    
    func fetchImage(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

