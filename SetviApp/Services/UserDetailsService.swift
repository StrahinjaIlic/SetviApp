//
//  UserDetailsService.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 28.4.24..
//

import Foundation

protocol UserDetailsServiceProtocol {
    func fetchUserDetails(username: String) async throws -> UserDetails
    func fetchRepos(username: String) async throws -> [Repository] 
}

class UserDetailsService: UserDetailsServiceProtocol {
    private let apiManager: NetworkServiceProtocol
    
    init(apiManager: NetworkServiceProtocol = NetworkService.shared) {
        self.apiManager = apiManager
    }
    
    func fetchUserDetails(username: String) async throws -> UserDetails {
        return try await apiManager.fetch(endpoint: .userDetails(username: username))
    }
    
    func fetchRepos(username: String) async throws -> [Repository] {
        return try await apiManager.fetch(endpoint: .userRepositories(username: username))
    }
}
