//
//  StringExtensions.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 15.10.2022.
//

import Foundation


extension String {
    var latinCharactersOnly: Bool {
        return self.range(of: "\\P{Latin}", options: .regularExpression) == nil
    }
    
    var allowedCharactersOnly: Bool {
        for character in self {
            guard "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_@.".contains(character) else { return false }
        }
        return true
    }
}
