//
//  UIApplication+Ext.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 29.4.24..
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
