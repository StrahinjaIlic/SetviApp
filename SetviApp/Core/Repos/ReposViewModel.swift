//
//  ReposViewModel.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 30.4.24..
//

import Foundation

final class ReposViewModel: ObservableObject {
    
    private let service: UserDetailsServiceProtocol
    private let username: String
    private var repos: Variable<[Repository]> = Variable([])
    var isLoading: Variable<Bool> = Variable(false)
    
    // MARK: - Init
    
    init(service: UserDetailsServiceProtocol, username: String) {
        self.service = service
        self.username = username
    }
    
    func fetchRepos() {
        isLoading.value = true
        
        Task {
            do {
                let repos = try await service.fetchRepos(username: username)
                DispatchQueue.main.async {
                    print("Repos fetched", repos)
                    self.repos.value = repos
                    self.isLoading.value = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading.value = false
                }
            }
        }
    }
    
    func getRepoCount() -> Int {
        return repos.value.count
    }
    
    func getRepo(for indexPath: IndexPath) -> Repository {
        return repos.value[indexPath.row]
    }
}
