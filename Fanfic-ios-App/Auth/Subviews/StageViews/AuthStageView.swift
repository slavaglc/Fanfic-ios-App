//
//  AuthStageView.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import UIKit


final class AuthStageView: UIView {
    
    public var signInAction: ()->() = {}
    public var signUpAction: ()->() = {}
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти в аккаунт", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.tag = 0
        button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Создать аккаунт", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.tag = 1
        button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setPrimarySettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(button: UIButton) {
        if button.tag == 0 {
            signInAction()
        } else {
            signUpAction()
        }
    }
    
    private func setPrimarySettings() {
        stackView.addArrangedSubview(signInButton)
        stackView.addArrangedSubview(signUpButton)
        addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        stackView.widthAnchor.constraint(equalTo: widthAnchor)
            .isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor)
            .isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            .isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
            .isActive = true
    }
}
