//
//  RegistrationViewController.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 15/06/2021.
//

import UIKit
import FirebaseDatabase

class RegistrationViewController: IntercorpChallengeViewController<RegistrationView> {

    var dataBaseRef = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.delegate = self
    }

    func saveUser() {
        guard let firstName = self.customView.firstNameInput.text, !firstName.isEmpty,
              let lastName = self.customView.lastNameInput.text, !lastName.isEmpty,
              let birthday = self.customView.birthdayInput.text, !birthday.isEmpty else {
            //Show complete all fields messages
            return
        }

        let user = User(firstName: firstName, lastName: lastName, birthday: self.customView.birthdayPicker.date.timeIntervalSince1970)
        dataBaseRef.child("users").childByAutoId().setValue(user.userRegister) { error,_ in
            let resultMessage: String
            if error != nil {
                resultMessage = "Error Ocurred"
            } else {
                resultMessage = "User Register Successful"
            }

            let alert = UIAlertController(title: resultMessage, message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension RegistrationViewController: RegistrationDelegate {
    func didTapSaveButton() {
        saveUser()
    }
}
