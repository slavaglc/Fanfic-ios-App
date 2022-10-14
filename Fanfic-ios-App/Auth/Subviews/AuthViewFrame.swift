//
//  AuthViewFrame.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import UIKit


final class AuthViewFrame: UIView {
    
    var currentSignInStage = SignInStage.allCases.first
    var currentSignUpStage = RegistrationStage.allCases.first
    
    private var signInActions: [SignInStage: (_ textfield: UITextField)->()] = [:]
    private var signUpActions: [RegistrationStage: (_ textfield: UITextField)->()] = [:]
    
    private lazy var authStageView: AuthStageView = {
        let view = AuthStageView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fieldStageView: FieldStageView = {
        let view = FieldStageView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(authStageView)
        addSubview(fieldStageView)
        authStageView.signInAction = startSignIn
        authStageView.signUpAction = startSignUp
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setStartStageView() {
        authStageView.isHidden = false
    }
    
    public func startSignIn() {
        authStageView.isHidden = true
        fieldStageView.isHidden = false
        
        setSignInStage(currentSignInStage ?? SignInStage.emailInput)
    }
    
    public func startSignUp() {
        authStageView.isHidden = true
        fieldStageView.isHidden = false
        
        setSignUpStage(currentSignUpStage ?? RegistrationStage.emailInput)
    }
    
    public func setSignUpStage(_ stage: RegistrationStage) {
        switch stage {
        case .usernameInput:
            fieldStageView.setValues(buttonTitle: "Далее", textFieldPlaceholder: "Имя пользователя", buttonAction: signUpActions[stage])
        case .emailInput:
            fieldStageView.setValues(buttonTitle: "Далее", textFieldPlaceholder: "Адрес электронной почты", buttonAction: signUpActions[stage])
        case .passwordInput:
            fieldStageView.setValues(buttonTitle: "Далее", textFieldPlaceholder: "Придумайте пароль", buttonAction: signUpActions[stage])
        case .confirmPasswordInput:
            fieldStageView.setValues(buttonTitle: "Завершить", textFieldPlaceholder: "Подтвердите пароль", buttonAction: signUpActions[stage])
        }
    }
    
    public func setSignInStage(_ stage: SignInStage) {
        switch stage {
        case .emailInput:
            fieldStageView.setValues(buttonTitle: "Далее", textFieldPlaceholder: "Адрес электронной почты", buttonAction: signInActions[stage])
        case .passwordInput:
            fieldStageView.setValues(buttonTitle: "Ввести", textFieldPlaceholder: "Введите ваш пароль", buttonAction: signInActions[stage])
        }
    }
    
    public func nextStage(for authType: AuthType) {
        fieldStageView.clearText()
        if authType == .signIn {
            guard let currentSignInStage = currentSignInStage else { return }
            guard let index = SignInStage.allCases.firstIndex(of: currentSignInStage) else { return }
            let nextIndex = SignInStage.allCases.index(after: index)
            setSignInStage(SignInStage.allCases[nextIndex])
        } else {
            guard let currentSignUpStage = currentSignUpStage else { return }
            guard let index = RegistrationStage.allCases.firstIndex(of: currentSignUpStage) else { return }
            let nextIndex = RegistrationStage.allCases.index(after: index)
            setSignUpStage(RegistrationStage.allCases[nextIndex])
        }
    }
    
    public func setSignInAction(for stage: SignInStage, _ action: @escaping (_ textField: UITextField)->()) {
        signInActions[stage] = action
    }
    
    public func setSignUpAction(for stage: RegistrationStage, _ action: @escaping (_ textField: UITextField)->()) {
        signUpActions[stage] = action
    }
    
    public func previousStage() {
        
    }
    
   
    
    private func setupConstraints() {
        authStageView.widthAnchor.constraint(equalTo: widthAnchor)
            .isActive = true
        authStageView.centerXAnchor.constraint(equalTo: centerXAnchor)
            .isActive = true
        authStageView.topAnchor.constraint(equalTo: topAnchor)
            .isActive = true
        authStageView.heightAnchor.constraint(equalToConstant: 150)
            .isActive = true
        
        fieldStageView.widthAnchor.constraint(equalTo: widthAnchor)
            .isActive = true
        fieldStageView.centerXAnchor.constraint(equalTo: centerXAnchor)
            .isActive = true
        fieldStageView.topAnchor.constraint(equalTo: topAnchor)
            .isActive = true
        fieldStageView.heightAnchor.constraint(equalToConstant: 150)
            .isActive = true
    }
    
    
}
