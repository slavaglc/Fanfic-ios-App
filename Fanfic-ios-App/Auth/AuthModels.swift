//
//  AuthModels.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import Foundation



enum AuthType {
    case signIn, registration, unknow
}

enum SignInStage: CaseIterable {
    case emailInput
    case passwordInput
}

enum RegistrationStage: CaseIterable {
    case usernameInput
    case emailInput
    case passwordInput
    case confirmPasswordInput
}

