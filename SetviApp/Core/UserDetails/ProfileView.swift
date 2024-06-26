//
//  ProfileView.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 29.4.24..
//

import SwiftUI

// Just add properties like this instead use some viewModel for this etc for the sake of time and simplicity

struct ProfileView: View {
    @State var image: UIImage? = nil
    @State private var isRepoListPresented = false
    @ObservedObject var viewModel: UserDetailsViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 12) {
                
                userDetailsLabel
                
                vStackLabels
                
                if let avatarURL = viewModel.user?.avatarURL {
                    AsyncImage(url: avatarURL) { image in
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                    .overlay(
                        Circle()
                            .stroke(Color.theme.myRed, lineWidth: 2)
                    )
                }
                
                seeReposButton
            }
            .padding()
            .background(Color.background)
            .cornerRadius(8)
            .onAppear {
                Task {
                    await downloadUserImage()
                }
            }
            .navigationDestination(isPresented: $isRepoListPresented) {
                if !viewModel.searchUserName.isEmpty, viewModel.searchUserName.count > 3 {
                    let viewModel = ReposViewModel(service: UserDetailsService(), username: viewModel.searchUserName)
                    RepoListView(viewModel: viewModel)
                }
            }
        }
    }
    
    private func downloadUserImage() async {
        guard let url = viewModel.user?.avatarURL else { return }
        
        do {
            let imageData = try await NetworkService.shared.fetchImage(from: url)
            self.image = UIImage(data: imageData)
        } catch {
            print("Error fetching image:", error.localizedDescription)
            self.image = UIImage(systemName: "person.fill")
        }
    }
    
    private var userDetailsLabel: some View {
        Text("User Details")
            .font(.title)
            .fontWeight(.medium)
            .foregroundStyle(Color.theme.secondaryText)
            .padding(.top)
    }
    
    private var vStackLabels: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let name = viewModel.user?.name {
                Text("Name: \(name)")
                    .padding(.horizontal)
            }
            
            if let company = viewModel.user?.company {
                Text("Company: \(company)")
                    .padding(.horizontal)
            }
        }
    }
    
    private var seeReposButton: some View {
        Button("See repos") {
            isRepoListPresented = true
        }
        .frame(width: 100, height: 40)
        .background(Color.theme.myRed)
        .foregroundStyle(.white)
        .font(.subheadline)
        .clipShape(Capsule())
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: UserDetailsViewModel(service: UserDetailsService()))
    }
}
