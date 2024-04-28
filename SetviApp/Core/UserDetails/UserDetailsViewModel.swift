//
//  UserDetailsViewModel.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 28.4.24..
//

import SwiftUI

class UserDetailsViewModel: ObservableObject {
    private let service: UserDetailsServiceProtocol
    
    @Published var user: UserDetails?
    @Published private var isLoading = false
    
    @Published var searchUserName: String = "" {
        didSet {
            fetchUserDetails()
        }
    }
    
    // MARK: - Init
    
    init(service: UserDetailsServiceProtocol) {
        self.service = service
    }
    
    // MARK: - API
    
    func fetchUserDetails() {
        guard !searchUserName.isEmpty else {
            user = nil
            isLoading = false
            return
        }
        
        isLoading = true
        
        Task {
            do {
                let userDetails = try await service.fetchUserDetails(username: searchUserName)
                DispatchQueue.main.async {
                    print("user details fetched", userDetails)
                    self.user = userDetails
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.user = nil
                    self.isLoading = false
                }
            }
        }
    }
}
