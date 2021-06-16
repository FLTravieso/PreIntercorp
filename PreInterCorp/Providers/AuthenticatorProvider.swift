//
//  AuthenticatorProvider.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 15/06/2021.
//

import Foundation
import FirebaseAuth

class AuthenticatorProvider {
    var authenticator: Auth {
        return Auth.auth()
    }

    func authenticate(with credential: AuthCredential, completion: @escaping (Error?) -> Void) {
        authenticator.signIn(with: credential) { (_, error) in
            completion(error)
        }
    }
}
