//
//  FieldStageView.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import UIKit


final class FieldStageView: UIView {
    
    
    var currentSignInStage = SignInStage.allCases.first
    var currentSignUpStage = RegistrationStage.allCases.first
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "TextField"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.setTitle("Дальше", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setPrimarySettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPrimarySettings() {
        stackView.addArrangedSubview(textField)
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
