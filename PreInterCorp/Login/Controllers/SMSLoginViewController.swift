//
//  SMSLoginViewController.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 15/06/2021.
//

import UIKit
import FirebaseAuth

protocol SMSLoginDelegate: AnyObject {
    func didFinishPhoneNumberVerification(with credential: AuthCredential)
}

enum SMSLoginStep {
    case sendMessage
    case validateCode
}

class SMSLoginViewController: IntercorpChallengeViewController<SMSLoginView> {

    var messageSent: Bool = false {
        didSet {
            customView.verificationCode.isHidden = !messageSent
            customView.authButton.setTitle(messageSent ? "Validate" : "Send SMS", for: .normal)
            customView.authButton.tag = messageSent ? 1 : 0
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

    weak var loginDelegate: SMSLoginDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self

    }

    func sendMessage() {
        if let phoneNumber = self.customView.phoneNumber.text,
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
              let verificationCode = self.customView.verificationCode.text else {
            return
        }

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: verificationCode)
        self.dismiss(animated: true, completion: nil)
        self.loginDelegate?.didFinishPhoneNumberVerification(with: credential)
    }
}

extension SMSLoginViewController: SMSLoginVerificationDelegate {
    func didTapButton() {
        messageSent ? validateCode() : sendMessage()
    }
}
