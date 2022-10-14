//
//  AuthPresenter.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import Foundation


protocol AuthPresentationLogic {
    func presentCheckedEmail()
}

final class AuthPresenter {
    //MARK: - Entites
    var viewController: AuthDisplayLogic?
}


// MARK: - Presentation logic
extension AuthPresenter: AuthPresentationLogic {
    func presentCheckedEmail() {
        viewController?.displayEmailResponse()
    }
    
    
}
