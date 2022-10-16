//
//  AuthInteractor.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import Foundation


protocol AuthInteractionLogic {
    func checkUser(by findMethod: UserFindMethod, for authType: AuthType)
    func checkPassword(_ password: String)
    
    func createPassword(_ password: String)
    func confirmPassword(_ password: String)
}

final class AuthInteractor {
    
    //MARK: - Entities
    var presenter: AuthPresentationLogic?
    
    //MARK: - Properties
    
    var authSession = AuthSession(email: "", username: "", password: "")
    
    //MARK: - Actions
    private func getURLForUserChecking(findMethod: UserFindMethod) -> URL? {
        var pathMethod = ""
        var queryItem = URLQueryItem(name: "", value: "")
        switch findMethod {
        case .email(let email):
            pathMethod = "byEmail"
            queryItem = URLQueryItem(name: "email", value: email)
        case .username(let username):
            pathMethod = "byUsername"
            queryItem = URLQueryItem(name: "username", value: username)
        }
        var components = URLComponents()
        components.scheme = "https"
        components.host = "clickey.dev"
        components.path = "/api/user/\(pathMethod)"
        components.queryItems = [
            queryItem
        ]
        guard let url = components.url else { return nil}
        return url
    }
    
    private func getURLRequstForEmailChecking(url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
    private func getUser(by data: Data) throws -> User  {
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            print("user:", user)
            return user
        } catch(let error) {
            let error = error as NSError
            guard error.code == 4865 else { throw error }
        }
        
        do {
            let authError = try JSONDecoder().decode(AuthError.self, from: data)
            throw authError.getError()
        } catch(let error) {
            throw error
        }
    }
    
    
    private func finishAuth(for authType: AuthType) {
        let json = getJSONBodyForAuth(for: authType)
        print("JSON BODY:", json)
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "clickey.dev"
        components.path = "/api/account/\(authType == .registration ? "register" : "login")"
        
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            print("data:", data.base64EncodedString())
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let jsonResponseDict = jsonResponse as? [String: Any] else { return }
                print("token:", jsonResponseDict["token"])
                
    
//                self?.presenter?.presentFinishAuth(for: authType)
                
            } catch(let error) {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self?.presenter?.presentAuthError(error: error)
                }
            }
        }.resume()
    }
    
    private func showAuthError(from data: Data) {
        do {
            let authError = try JSONDecoder().decode(AuthError.self, from: data)
            DispatchQueue.main.async {
                self.presenter?.presentAuthError(error: authError.getError())
            }
        }
        catch(let error) {
            DispatchQueue.main.async {
                self.presenter?.presentAuthError(error: error)
            }
        }
    }
    
    private func getJSONBodyForAuth(for authType: AuthType) -> [String: String] {
        authType == .registration ? ["email": authSession.email, "username": authSession.username, "password": authSession.password] : ["email": authSession.email, "password": authSession.password]
    }
    
    
    // MARK: - Validation methods
    
    private func passwordIsCorrect(_ password: String) -> Bool {
        password.count >= 6 && password.count < 32
    }
    
    private func usernameIsCorrect(_ username: String) -> Bool {
        username.allowedCharactersOnly && (3...20).contains(username.count)
    }
    
    private func emailIsCorrect(_ email: String) -> Bool {
        email.allowedCharactersOnly
    }
    
}




// MARK: - Interaction logic
extension AuthInteractor: AuthInteractionLogic {
    
    
    func checkUser(by findMethod: UserFindMethod, for authType: AuthType) {
        print("Current findMethod:", findMethod)
        switch findMethod {
        case .email(let email):
            guard emailIsCorrect(email) else { presenter?.presentIncorrectEmail(); return }
        case .username(let username):
            print("username for checking:", username)
            guard usernameIsCorrect(username) else { presenter?.presentIncorrectUsernameForSignIn(); return }
            print("complete!")
        }
        
        guard let url = getURLForUserChecking(findMethod: findMethod) else { return }
        let urlRequest = getURLRequstForEmailChecking(url: url)
        print("CURRENT URL:", url)
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let data = data else { return }
            
            DispatchQueue.main.async { [weak self] in
                do {
                    let user = try self?.getUser(by: data)
                    print("user is checked")
                    self?.presenter?.presentCheckedUser(findMethod: findMethod, error: error, for: authType, user: user)
                } catch(let error) {
                    self?.presenter?.presentCheckedUser(findMethod: findMethod, error: error, for: authType, user: nil)
                }
                switch findMethod {
                case .email(let email):
                    self?.authSession.email = email
                case .username(let username):
                    self?.authSession.username = username
                }
            }
        }.resume()
    }
    
    func checkPassword(_ password: String) {
        authSession.password = password
        finishAuth(for: .signIn)
    }
    
    func createPassword(_ password: String) {
        guard passwordIsCorrect(password) else { presenter?.presentIncorrectPasswordForSignUp(); return }
        authSession.password = password
        presenter?.presentCorrectPasswordForSignUp()
    }
    
    func confirmPassword(_ password: String) {
        guard authSession.password == password else { presenter?.presentIncorrectConfirmPassword(); return }
        finishAuth(for: .registration)
    }
    
    
}
