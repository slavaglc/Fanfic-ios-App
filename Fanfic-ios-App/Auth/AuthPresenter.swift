//
//  AuthPresenter.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import Foundation


protocol AuthPresentationLogic {
    func presentCheckedEmail(statusCode: Int, for authType: AuthType)
}

final class AuthPresenter {
    //MARK: - Entites
    var viewController: AuthDisplayLogic?
}


// MARK: - Presentation logic
extension AuthPresenter: AuthPresentationLogic {
    func presentCheckedEmail(statusCode: Int, for authType: AuthType) {
        let isVacant = statusCode != 200 && statusCode < 500
        if isVacant {
            viewController?.displayEmailIsVacant(response: "Email свободен")
        } else {
            viewController?.displayEmailError(response: authType == .registration ? "Email занят" : "Данный email не зарегистрирован")
        }
    }
    
    
}
