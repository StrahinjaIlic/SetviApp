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
            Text(viewModel.user?.name ?? "")
        }
        .onAppear {
            // test existing user as check
            viewModel.searchUserName = "radianttap"
        }
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(viewModel: UserDetailsViewModel(service: UserDetailsService()))
            .preferredColorScheme(ColorSchemeManager.shared.getPreferredColorScheme())
    }
}

