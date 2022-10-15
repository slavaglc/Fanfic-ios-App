//
//  AuthViewController.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import UIKit


protocol AuthDisplayLogic {
    func displayEmailIsVacant(response: String)
    func displayEmailIsExist()
    func displayEmailError(response: String)
}

final class AuthViewController: UIViewController {
    
    //    MARK: - Entities
    var interactor: AuthInteractionLogic?
    
    //  MARK: - UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "FanficApp"
        label.textColor = UIColor(named: "MainTitleColors")
        label.font = UIFont(name: "Ubuntu-Medium", size: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.font = UIFont(name: "Ubuntu-Regular", size: 16)
        label.textColor = UIColor(named: "SubtitleColors")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewFrame: AuthViewFrame = {
        let view = AuthViewFrame()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setGUISettings()
        viewFrame.setStartStageView()
        setActions()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let configurator = AuthConfigurator()
        configurator.configure(for: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    private func setActions() {
        viewFrame.setStartAction(for: .signIn, action: startSignIn)
        viewFrame.setStartAction(for: .registration, action: startSignUp)
        viewFrame.setSignInAction(for: .emailInput, checkEmailForSignIn(textField:))
        viewFrame.setSignInAction(for: .passwordInput, checkPassword(textField:))
        viewFrame.setSignUpAction(for: .emailInput, checkEmailForSignUp(textField:))
    }
    
    private func startSignIn() {
        subtitleLabel.text = "Вход в аккаунт"
    }
    
    private func startSignUp() {
        subtitleLabel.text = "Создание нового пользователя"
    }
    
    private func checkUserName(textField: UITextField) {
        
    }
    
    private func checkEmailForSignUp(textField: UITextField) {
        interactor?.checkEmail(textField.text ?? "", for: .registration)
    }
    
    private func checkEmailForSignIn(textField: UITextField) {
        interactor?.checkEmail(textField.text ?? "", for: .signIn)
    }
    
    private func checkPassword(textField: UITextField) {
        print("password works!")
    }
    
    private func confirmPassword(textField: UITextField) {
        
    }
    
    
    // MARK: - GUI
    private func setGUISettings() {
        view.backgroundColor = UIColor(named: "ScreenBackgroundColors")
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(viewFrame)
        setupConstraints()
    }
    
    private func setupConstraints() {
       titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            .isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            .isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
            .isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
            .isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor)
            .isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor)
            .isActive = true
        
        viewFrame.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30)
            .isActive = true
        viewFrame.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            .isActive = true
        viewFrame.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            .isActive = true
        viewFrame.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
            .isActive = true
    }
}



// MARK: - Display logic
extension AuthViewController: AuthDisplayLogic {
    
    func displayEmailIsExist() {
        viewFrame.nextStage(for: .signIn)
    }
    
    func displayEmailIsVacant(response: String) {
        viewFrame.nextStage(for: .registration)
    }
    
    func displayEmailError(response: String) {
        guard let font = UIFont(name: "Ubuntu-Medium", size: 16) else { return }
        guard let image = UIImage(named: "error_icon") else { return }
        showToast(message: response, font: font, image: image)
    }

}
