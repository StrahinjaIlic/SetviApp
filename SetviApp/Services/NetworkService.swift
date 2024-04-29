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
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension NetworkService {
    
    func fetchImage(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

