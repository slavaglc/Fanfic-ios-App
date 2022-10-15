//
//  AuthModels.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import Foundation



enum AuthType {
    case signIn, registration
}

enum SignInStage: CaseIterable {
    case emailInput
    case passwordInput
}

enum RegistrationStage: CaseIterable {
    case emailInput
    case usernameInput
    case passwordInput
    case confirmPasswordInput
}

struct User: Decodable {
    let id: String
    let email: String
    let username: String
    let about: String
    let isBanned: Bool
    let isAdmin: Bool
    let isVerifed: Bool
}

