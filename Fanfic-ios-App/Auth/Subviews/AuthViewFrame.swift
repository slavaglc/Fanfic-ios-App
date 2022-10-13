//
//  AuthViewFrame.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import UIKit


final class AuthViewFrame: UIView {
    
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
    }
    
    public func startSignUp() {
        
    }
    
    public func setStage() {
        
    }
    
    public func nextStage() {
        
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
