//
//  RegistrationView.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 15/06/2021.
//

import UIKit

protocol RegistrationDelegate: AnyObject {
    func didTapSaveButton()
}

class RegistrationView: IntercorpChallengeView {

    weak var delegate: RegistrationDelegate?

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

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

    override func setViews() {
        super.setViews()

        addSubview(titleLabel)
        addSubview(firstNameInput)
        addSubview(lastNameInput)
        addSubview(ageInput)
        addSubview(birthdayInput)
        addSubview(saveButton)
    }

    override func layoutViews() {
        super.layoutViews()

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

        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc func saveButtonTapped() {
        delegate?.didTapSaveButton()
    }

    @objc func didSelectDate() {
        self.birthdayInput.text = dateFormatter.string(from: birthdayPicker.date)
        endEditing(true)
    }
}
