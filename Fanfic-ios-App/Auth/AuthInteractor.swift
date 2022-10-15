//
//  AuthInteractor.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 12.10.2022.
//

import Foundation


protocol AuthInteractionLogic {
    func checkEmail(_ email: String, for authType: AuthType)
}

final class AuthInteractor {
    
    //MARK: - Entities
    var presenter: AuthPresentationLogic?
    
    //MARK: - Actions
    private func getURLForEmailChecking(email: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "clickey.dev"
        components.path = "/api/v0/user/byEmail"
        components.queryItems = [
            URLQueryItem(name: "email", value: email)
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
}


// MARK: - Interaction logic
extension AuthInteractor: AuthInteractionLogic {
    func checkEmail(_ email: String, for authType: AuthType) {
        let email = email.lowercased()
        guard let url = getURLForEmailChecking(email: email) else { return }
        let urlRequest = getURLRequstForEmailChecking(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            let statusCode = response.statusCode
            DispatchQueue.main.async { [weak self] in
                guard let data = data else { return }
                do {
                let user = try self?.getUser(by: data)
                    self?.presenter?.presentCheckedEmail(error: error, for: authType, user: user)
                } catch(let error) {
                    self?.presenter?.presentCheckedEmail(error: error, for: authType, user: nil)
                }
                
            }
        }.resume()
    }
    
    
}
