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
}
