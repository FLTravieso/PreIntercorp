//
//  SMSLoginViewController.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 15/06/2021.
//

import UIKit
import FirebaseAuth

class SMSLoginViewController: UIViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text =  "Phone Number Login"
        label.textAlignment = .center
        return label
    }()
    
    lazy var phoneNumber: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.placeholder = "Phone Number"
        return textField
    }()

    lazy var verificationCode: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.isHidden = true
        textField.placeholder = "Verification Code"
        return textField
    }()

    lazy var authButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        button.setTitle("Sent SMS", for: .normal)
        return button
    }()

    var messageSent: Bool = false {
        didSet {
            verificationCode.isHidden = !messageSent
            authButton.setTitle(messageSent ? "Validate" : "Send SMS", for: .normal)
            authButton.tag = messageSent ? 1 : 0
        }
    }

    var verificationId: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "authVerificationID")
        }

        get {
            return UserDefaults.standard.string(forKey: "authVerificationID") ?? nil
        }
    }

    weak var loginDelegate: LoginDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(phoneNumber)
        self.view.addSubview(verificationCode)
        self.view.addSubview(authButton)

        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        phoneNumber.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 20)
        phoneNumber.autoAlignAxis(.vertical, toSameAxisOf: titleLabel)
        phoneNumber.autoSetDimension(.height, toSize: 50)
        phoneNumber.autoPinEdge(toSuperviewEdge: .leading, withInset: 40)
        phoneNumber.autoPinEdge(toSuperviewEdge: .trailing, withInset: 40)

        verificationCode.autoPinEdge(.top, to: .bottom, of: phoneNumber, withOffset: 20)
        verificationCode.autoAlignAxis(.vertical, toSameAxisOf: titleLabel)
        verificationCode.autoSetDimension(.height, toSize: 50)
        verificationCode.autoPinEdge(toSuperviewEdge: .leading, withInset: 40)
        verificationCode.autoPinEdge(toSuperviewEdge: .trailing, withInset: 40)

        authButton.autoPinEdge(.top, to: .bottom, of: verificationCode, withOffset: 20)
        authButton.autoAlignAxis(.vertical, toSameAxisOf: titleLabel)
        authButton.autoSetDimension(.height, toSize: 50)
        authButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 40)
        authButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 40)

        authButton.addTarget(self, action: #selector(authenticate), for: .touchUpInside)
    }

    @objc func authenticate() {
        switch authButton.tag {
        case 0:
            sendMessage()
        case 1:
            validateCode()
        default:
            break
        }
    }

    func sendMessage() {
        if let phoneNumber = phoneNumber.text,
           !phoneNumber.isEmpty {
            Auth.auth().settings?.isAppVerificationDisabledForTesting = true
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
                guard let self = self,
                      error == nil else {
                    // Show error message
                    return
                }

                self.verificationId = verificationId
                self.messageSent = true
            }
        }
    }

    func validateCode() {
        guard let verificationId = self.verificationId,
              let verificationCode = self.verificationCode.text else {
            return
        }

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { [weak self] (result, error) in
            guard let self = self,
                  error == nil else {
                //Show error message
                return
            }

            self.dismiss(animated: true, completion: nil)
            self.loginDelegate?.didFinishPhoneNumberVerification()
            
        }
    }
}
