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
    case emailInput, passwordInput
}

enum RegistrationStage: CaseIterable {
    case emailInput, usernameInput, passwordInput, confirmPasswordInput
}

enum UserFindMethod {
    case email(_ email: String), username(_ username: String)
}

struct AuthSession {
    var email: String, username: String, password: String
}



