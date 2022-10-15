//
//  AuthPresenter.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import Foundation


protocol AuthPresentationLogic {
    func presentCheckedEmail(error: Error?, for authType: AuthType, user: User?)
}

final class AuthPresenter {
    //MARK: - Entites
    var viewController: AuthDisplayLogic?
}


// MARK: - Presentation logic
extension AuthPresenter: AuthPresentationLogic {
    func presentCheckedEmail(error: Error?, for authType: AuthType, user: User?) {
        switch authType {
        case .signIn:
            if user == nil {
                viewController?.displayEmailError(response: "Данный email не найден")
            } else {
                viewController?.displayEmailIsExist()
            }
        case .registration:
            guard let error = error as? NSError else {
                if user != nil {
                    viewController?.displayEmailError(response: "Данный email занят")
                } else {
                viewController?.displayEmailError(response: "Неизвестная ошибка")
                }
                return
            }
            guard error.code == 3 else {
                viewController?.displayEmailError(response: "Неизвестная ошибка")
                return
            }
            viewController?.displayEmailIsVacant(response: "Email свободен")
        }
    }
}
