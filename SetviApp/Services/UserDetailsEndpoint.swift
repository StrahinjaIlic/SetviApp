//
//  UserDetailsEndpoint.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 28.4.24..
//

import Foundation

private let baseURL = "https://api.github.com"

enum Endpoint {
    
    case userDetails(username: String)
    
    var path: String {
        switch self {
        case .userDetails(let username):
            return baseURL + "/users/\(username)"
        }
    }
}
