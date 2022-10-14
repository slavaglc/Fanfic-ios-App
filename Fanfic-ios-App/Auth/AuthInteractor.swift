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
            DispatchQueue.main.async {
                print("statusCode:"  ,statusCode)
                print("error:", error)
                self?.presenter?.presentCheckedEmail(statusCode: statusCode, for: authType)
            }
        }.resume()
    }
    
    
}
