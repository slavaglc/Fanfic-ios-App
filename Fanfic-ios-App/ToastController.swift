//
//  ToastController.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 15.10.2022.
//

import UIKit


final class ToastController: UIView {
    
    var message: String!
    var image: UIImage!
    var font: UIFont!
    
    private lazy var toastImageView = UIImageView()
    private lazy var toastLabel = UILabel()
    
    convenience init(message: String, font: UIFont, image: UIImage) {
        self.init()
        self.message = message
        self.image = image
        self.font = font
        setPrimarySettings()
    }
    
    @objc func hideToast(sender: UIGestureRecognizer) {
        animateMoveOut()
    }
    
    public func showMessage() {
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideToast(sender:)))
        addGestureRecognizer(gestureRecognizer)
        
        
        alpha = 0.0
        UIView.animate(withDuration: 0.5, delay: .zero, options: .allowUserInteraction) {
            self.alpha = 0.8
        } completion: { isFinished in
            if isFinished {
                let seconds = 4.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.animateMoveOut()
                }
                
            }
        }
    }
    
    private func animateMoveOut() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
            self.alpha = 0.0
        }, completion: {(isCompleted) in
            self.removeFromSuperview()
        })
    }
    
    private func setPrimarySettings() {
        toastImageView.frame.size = CGSize(width: 50, height: 50)
        toastImageView.translatesAutoresizingMaskIntoConstraints = false
        toastImageView.image = image
        
        backgroundColor = .white.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.black
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.adjustsFontSizeToFitWidth = true
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.isUserInteractionEnabled = true
        
       alpha = 1.0
       layer.cornerRadius = 19;
       layer.borderWidth = 1
       layer.borderColor = UIColor.black.cgColor
       translatesAutoresizingMaskIntoConstraints = false
       clipsToBounds = true
        
        addSubview(toastImageView)
        addSubview(toastLabel)
        isUserInteractionEnabled = true
       
        
        
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        toastImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            .isActive = true
        toastImageView.centerYAnchor.constraint(equalTo: toastLabel.centerYAnchor)
            .isActive = true
        toastImageView.widthAnchor.constraint(equalToConstant: 50)
            .isActive = true
        toastImageView.heightAnchor.constraint(equalTo: toastImageView.widthAnchor)
            .isActive = true
        toastLabel.leadingAnchor.constraint(equalTo: toastImageView.trailingAnchor, constant: 10)
            .isActive = true
        toastLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            .isActive = true
        toastLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 10)
            .isActive = true
    }
}

