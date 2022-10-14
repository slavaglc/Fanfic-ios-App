//
//  AuthInteractor.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import Foundation


protocol AuthInteractionLogic {
    func checkEmail(_ email: String)
}

final class AuthInteractor {
    
    //MARK: - Entities
    var presenter: AuthPresentationLogic?
    
}


// MARK: - Interaction logic
extension AuthInteractor: AuthInteractionLogic {
    func checkEmail(_ email: String) {
        presenter?.presentCheckedEmail()
    }
    
    
}
