//
//  Auth.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import Foundation


final class AuthConfigurator {
    
    
    public func configure(for viewController: AuthViewController) {
        let interactor = AuthInteractor()
        let presenter = AuthPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
     
    }
}
