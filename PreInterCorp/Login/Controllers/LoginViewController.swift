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

protocol LoginDelegate: AnyObject {
    func didFinishPhoneNumberVerification()
}

class LoginViewController: UIViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text =  "Login"
        label.textAlignment = .center
        return label
    }()
    
    lazy var facebookLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.5254901961, blue: 0.9333333333, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitle("Iniciar sesión con Facebook", for: .normal)
        return button
    }()

    lazy var smsLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        button.setTitle("Iniciar sesión vía SMS", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(titleLabel)
        self.view.addSubview(facebookLoginButton)
        self.view.addSubview(smsLoginButton)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        facebookLoginButton.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 20)
        facebookLoginButton.autoAlignAxis(.vertical, toSameAxisOf: titleLabel)
        facebookLoginButton.autoSetDimension(.height, toSize: 50)
        facebookLoginButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 40)
        facebookLoginButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 40)
        smsLoginButton.autoPinEdge(.top, to: .bottom, of: facebookLoginButton, withOffset: 20)
        smsLoginButton.autoAlignAxis(.vertical, toSameAxisOf: titleLabel)
        smsLoginButton.autoSetDimension(.height, toSize: 50)
        smsLoginButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 40)
        smsLoginButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 40)
        
        facebookLoginButton.addTarget(self, action: #selector(loginWithFacebook), for: .touchUpInside)
        smsLoginButton.addTarget(self, action: #selector(loginWithSMS), for: .touchUpInside)
    }

    @objc func loginWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [.email], viewController: self) { result in
            switch result {
            case .success(_,_, token: let token):
                guard let tokenString = token?.tokenString else { return }
                let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
                Auth.auth().signIn(with: credential) { [weak self] (result, error) in
                    
                    guard let self = self else {
                        return
                    }

                    self.navigateToRegistration()
                }
            case .cancelled:
                break
            case .failed(_):
                break
            }

        }
    }

    @objc func loginWithSMS() {
        let smsModal = SMSLoginViewController()
        smsModal.loginDelegate = self
        smsModal.modalTransitionStyle = .coverVertical
        self.present(smsModal, animated: true, completion: nil)
    }

    func navigateToRegistration() {
        let registrationViewController = RegistrationViewController()
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
}

extension LoginViewController: LoginDelegate {
    func didFinishPhoneNumberVerification() {
        self.navigateToRegistration()
    }
}
