//
//  ColorSchemeManager.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 28.4.24..
//

import SwiftUI

class ColorSchemeManager: ObservableObject {
    static let shared = ColorSchemeManager()
    @AppStorage("colorScheme") var selectedColorScheme: String = "system"
    
    func getPreferredColorScheme() -> ColorScheme? {
        switch selectedColorScheme {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil
        }
    }
}
