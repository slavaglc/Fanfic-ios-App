//
//  AuthError.swift
//  Fanfic-ios-App
//
//  Created by Вячеслав Макаров on 15.10.2022.
//

import Foundation



struct AuthError: Decodable {
    let code: Int
    let message: String
    
    ///Returns AuthError as Error type
    public func getError() -> Error {
        NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
