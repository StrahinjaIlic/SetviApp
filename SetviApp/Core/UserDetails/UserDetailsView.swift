//
//  UserDetailsView.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 28.4.24..
//

import SwiftUI

struct UserDetailsView: View {
    @ObservedObject private var viewModel: UserDetailsViewModel
    @StateObject private var colorSchemeManager = ColorSchemeManager.shared
    
    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter GitHub Username", 
                          text: $viewModel.searchUserName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                loadUserButton
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
                
                if let user = viewModel.user {
                    ProfileView(user: user)
                }
            }
            .background(Color.theme.background)
            .navigationTitle("User Profile")
            .navigationBarTitleDisplayMode(.large)
            .padding()
        }
        .onAppear {
            // Load existing user initially to show smth
            viewModel.searchUserName = "radianttap"
        }
    }
}

// I always separate things like this in extensions

extension UserDetailsView {
    
    private var loadUserButton: some View {
        Button("Load User") {
            viewModel.fetchUserDetails()
            
            UIApplication.shared.endEditing()
        }
        .frame(width: 120, height: 50)
        .background(Color.theme.myGreen)
        .foregroundStyle(.white)
        .clipShape(Capsule())
        .padding()
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(viewModel: UserDetailsViewModel(service: UserDetailsService()))
            .preferredColorScheme(ColorSchemeManager.shared.getPreferredColorScheme())
    }
}


