//
//  UserDetails.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 28.4.24..
//

import Foundation

struct UserDetails: Codable {
    let name: String?
    let avatarURL: URL?
    let company: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case avatarURL = "avatar_url"
        case company
    }
    
    static let dummyUser = UserDetails(name: "Petar Petrovic",
                                       avatarURL: URL(string: "www.apple.com"),
                                       company: "Apple")
}


import Foundation

struct Repository: Codable {
    let name: String
    let description: String?

    enum CodingKeys: String, CodingKey {
        case name
        case description
    }
}
