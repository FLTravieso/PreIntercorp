//
//  SMSLoginView.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 15/06/2021.
//

import UIKit

protocol SMSLoginVerificationDelegate: AnyObject {
    func didTapButton()
}

class SMSLoginView: IntercorpChallengeView {

    weak var delegate: SMSLoginVerificationDelegate?

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

    override func setViews() {
        super.setViews()
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(phoneNumber)
        addSubview(verificationCode)
        addSubview(authButton)
    }

    override func layoutViews() {
        super.layoutViews()

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

        authButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc func didTapButton() {
        delegate?.didTapButton()
    }
}
