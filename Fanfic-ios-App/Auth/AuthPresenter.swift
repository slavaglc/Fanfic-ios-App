//
//  AuthPresenter.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import Foundation


protocol AuthPresentationLogic {
    func presentCheckedUser(findMethod: UserFindMethod ,error: Error?, for authType: AuthType, user: User?)
    func presentIncorrectEmail()
    
    func presentCorrectPasswordForSignUp()
    func presentIncorrectPasswordForSignUp()
    
    func presentCorrectPasswordForSignIn()
    func presentIncorrectPasswordForSignIn()
    
    func presentCorrectConfirmPassword()
    func presentFinishAuth(for authType: AuthType, token: String)
    func presentIncorrectConfirmPassword()
    
    func presentCorrectUsernameForSignUp()
    func presentIncorrectUsername()
    func presentIncorrectUsernameForSignIn()
    
    
    func presentAuthError(error: Error)
}

final class AuthPresenter {
    //MARK: - Entites
    var viewController: AuthDisplayLogic?
}

// MARK: - Presentation logic
extension AuthPresenter: AuthPresentationLogic {
    func presentAuthError(error: Error) {
        viewController?.displayError(response: error.localizedDescription)
    }
    
    
    func presentIncorrectEmail() {
        viewController?.displayError(response: "Неправильный формат Email")
    }
    
    func presentIncorrectEmailForSign() {
        viewController?.displayError(response: "Неправильный ввод email")
    }
    
    
    func presentCheckedUser(findMethod: UserFindMethod, error: Error?, for authType: AuthType, user: User?) {
        var freeMessage = ""
        var busyMessage = ""
        
        switch findMethod {
        case .email(_):
            freeMessage = "Данный email не найден"
            busyMessage = "Данный email занят"
        case .username(_):
            freeMessage = "Данное имя не найдено"
            busyMessage = "Данное имя занято"
        }
        
        switch authType {
        case .signIn:
            if user == nil {
                viewController?.displayError(response: freeMessage)
            } else {
                viewController?.nextStage(for: .signIn)
            }
        case .registration:
            guard let error = error as? NSError else {
                if user != nil {
                    viewController?.displayError(response: busyMessage)
                } else {
                viewController?.displayError(response: "Ошибка ввода")
                }
                return
            }
            guard (3...4).contains(error.code) else {
                viewController?.displayError(response: "Неизвестная ошибка")
                return
            }
            viewController?.nextStage(for: .registration)
        }
    }
    
    func presentCorrectPasswordForSignUp() {
        viewController?.nextStage(for: .registration)
    }
    
    func presentIncorrectPasswordForSignUp() {
        viewController?.displayError(response: "Пароль должен содержать от 6-ти символов")
    }
    
    func presentCorrectPasswordForSignIn() {
        
    }
    
    func presentIncorrectPasswordForSignIn() {
        viewController?.displayError(response: "Неверный пароль")
    }
    
    func presentCorrectUsernameForSignUp() {
        viewController?.nextStage(for: .registration)
    }
    
    func presentIncorrectUsername() {
        viewController?.displayError(response: " Имя может содержать только латиницу и цифры, от 3 до 20-ти символов ")
    }
    
    func presentIncorrectUsernameForSignIn() {
        
    }
    
    func presentCorrectConfirmPassword() {
        
    }
    
    func presentIncorrectConfirmPassword() {
        viewController?.displayError(response: "Пароли не совпадают")
    }
    
    func presentFinishAuth(for authType: AuthType, token: String) {
        viewController?.routeToMainVC(by: authType, token: token)
    }
}
