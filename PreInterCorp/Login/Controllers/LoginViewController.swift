//
//  ViewController.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 14/06/2021.
//

import UIKit
import PureLayout
import FirebaseAuth
import FBSDKLoginKit

class LoginViewController: IntercorpChallengeViewController<LoginView> {

    let authProvider = AuthenticatorProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
    }

    func loginWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [.email], viewController: self) { [weak self] result in
            switch result {
            case .success(_,_, token: let token):
                guard let self = self,
                      let tokenString = token?.tokenString
                else {
                    return
                }

                let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
                self.authenticate(with: credential)
            case .cancelled:
                break
            case .failed(_):
                break
            }
        }
    }

    func loginWithSMS() {
        let smsModal = SMSLoginViewController()
        smsModal.loginDelegate = self
        smsModal.modalTransitionStyle = .coverVertical
        self.present(smsModal, animated: true, completion: nil)
    }

    func authenticate(with credential: AuthCredential) {
        authProvider.authenticate(with: credential) { [weak self] error in
            guard let self = self,
                  error == nil else {
                //Show Error Message
                return
            }

            self.navigateToRegistration()
        }
    }

    func navigateToRegistration() {
        let registrationViewController = RegistrationViewController()
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
}

extension LoginViewController: LoginDelegate {
    func didTapLoginButton(for type: LoginType) {
        switch type {
        case .facebook:
            loginWithFacebook()
        case .SMS:
            loginWithSMS()
        }
    }
}

extension LoginViewController: SMSLoginDelegate {
    func didFinishPhoneNumberVerification(with credential: AuthCredential) {
        authenticate(with: credential)
    }
}
