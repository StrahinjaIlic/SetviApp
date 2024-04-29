//
//  ProfileView.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 29.4.24..
//

import SwiftUI

// Just add properties like this instead use some viewModel for this etc for the sake of time and simplicity

struct ProfileView: View {
    let user: UserDetails
    @State var image: UIImage? = nil
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            
            userDetailsLabel
            
            vStackLabels
            
            if let avatarURL = user.avatarURL {
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
        }
        .padding()
        .background(Color.background)
        .cornerRadius(8)
        .onAppear {
            Task {
                await downloadCoinImage()
            }
        }
    }
}

extension ProfileView {
    
    private func downloadCoinImage() async {
        guard let url = user.avatarURL else { return }
        
        do {
            let imageData = try await NetworkService.shared.fetchImage(from: url)
            self.image = UIImage(data: imageData)
        } catch {
            print("Error fetching image:", error.localizedDescription)
            self.image = UIImage(systemName: "person.fill")
        }
    }
}

extension ProfileView {
    
    private var userDetailsLabel: some View {
        Text("User Details")
            .font(.title)
            .fontWeight(.medium)
            .foregroundStyle(Color.theme.secondaryText)
            .padding(.top)
    }
    
    private var vStackLabels: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let name = user.name {
                Text("Name: \(name)")
                    .padding(.horizontal)
            }
            
            if let company = user.company {
                Text("Company: \(company)")
                    .padding(.horizontal)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: UserDetails.dummyUser)
    }
}
