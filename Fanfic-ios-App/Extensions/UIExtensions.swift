//
//  UIExtensions.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 15.10.2022.
//

import UIKit


extension UIViewController {
    func showToast(message : String, font: UIFont, image: UIImage) {
        
        let mainView: UIView = navigationController?.view ?? view
        
        let toastView = ToastController(message: message, font: font, image: image)
        self.view.addSubview(toastView)
        
        toastView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.7)
            .isActive = true
        toastView.heightAnchor.constraint(equalToConstant: 45)
            .isActive = true
        toastView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 50)
            .isActive = true
        toastView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
            .isActive = true
        
        toastView.showMessage()
    }
}
