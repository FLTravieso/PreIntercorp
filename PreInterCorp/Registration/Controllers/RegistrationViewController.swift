//
//  RegistrationViewController.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 15/06/2021.
//

import UIKit
import FirebaseDatabase

class RegistrationViewController: UIViewController {

    var dataBaseRef = Database.database().reference()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text =  "Create User"
        label.textAlignment = .center
        return label
    }()
    
    lazy var firstNameInput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.placeholder = "First Name"
        return textField
    }()

    lazy var lastNameInput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.placeholder = "Last Name"
        return textField
    }()

    lazy var ageInput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.keyboardType = .numberPad
        textField.placeholder = "Age"
        return textField
    }()

    lazy var birthdayInput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.keyboardType = .numberPad
        textField.inputView = birthdayPicker
        textField.placeholder = "Birthday"
        textField.inputAccessoryView = {
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didSelectDate))
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            toolbar.setItems([doneButton], animated: true)
            return toolbar
        }()
        return textField
    }()

    lazy var birthdayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        return picker
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        button.setTitle("Save", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.addSubview(titleLabel)
        self.view.addSubview(firstNameInput)
        self.view.addSubview(lastNameInput)
        self.view.addSubview(ageInput)
        self.view.addSubview(birthdayInput)
        self.view.addSubview(saveButton)

        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)

        firstNameInput.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 20)
        firstNameInput.autoSetDimension(.height, toSize: 30)
        firstNameInput.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        firstNameInput.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)

        lastNameInput.autoPinEdge(.top, to: .bottom, of: firstNameInput, withOffset: 20)
        lastNameInput.autoSetDimension(.height, toSize: 30)
        lastNameInput.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        lastNameInput.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)

        ageInput.autoPinEdge(.top, to: .bottom, of: lastNameInput, withOffset: 20)
        ageInput.autoAlignAxis(.vertical, toSameAxisOf: firstNameInput)
        ageInput.autoSetDimension(.height, toSize: 30)
        ageInput.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        ageInput.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)
        
        birthdayInput.autoPinEdge(.top, to: .bottom, of: ageInput, withOffset: 20)
        birthdayInput.autoAlignAxis(.vertical, toSameAxisOf: firstNameInput)
        birthdayInput.autoSetDimension(.height, toSize: 30)
        birthdayInput.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        birthdayInput.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)

        saveButton.autoPinEdge(.top, to: .bottom, of: birthdayInput, withOffset: 20)
        saveButton.autoAlignAxis(.vertical, toSameAxisOf: titleLabel)
        saveButton.autoSetDimension(.height, toSize: 50)
        saveButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 40)
        saveButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 40)

        saveButton.addTarget(self, action: #selector(saveUser), for: .touchUpInside)

    }

    @objc func didSelectDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        self.birthdayInput.text = dateFormatter.string(from: birthdayPicker.date)
        self.view.endEditing(true)
    }

    @objc func saveUser() {
        guard let firstName = self.firstNameInput.text, !firstName.isEmpty,
              let lastName = self.lastNameInput.text, !lastName.isEmpty,
              let birthday = self.birthdayInput.text, !birthday.isEmpty else {
            //Show complete all fields messages
            return
        }

        let user = User(firstName: firstName, lastName: lastName, birthday: self.birthdayPicker.date.timeIntervalSince1970)
        dataBaseRef.child("users").childByAutoId().setValue(user.userRegister) { error,_ in
            if error != nil {
                // Show error message
            } else {
                let alert = UIAlertController(title: "User Register Successful", message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}



struct User {
    let firstName: String
    let lastName: String
    let birthday: Double

    var userRegister: [String : Any] {
        return ["firstName" : self.firstName,
                "lastName"  : self.lastName,
                "birthday"  : self.birthday]
    }
    
}
