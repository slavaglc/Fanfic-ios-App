//
//  User.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 04.02.2023.
//

import Foundation


struct User: Decodable {
    let id: String, email: String, username: String, about: String
    let isBanned: Bool, isAdmin: Bool, isVerifed: Bool
}
