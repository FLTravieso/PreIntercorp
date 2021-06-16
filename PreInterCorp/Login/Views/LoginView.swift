//
//  LoginView.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 15/06/2021.
//

import UIKit

enum LoginType {
    case facebook
    case SMS
}

protocol LoginDelegate: AnyObject {
    func didTapLoginButton(for type: LoginType)
}

class LoginView: IntercorpChallengeView {

    weak var delegate: LoginDelegate?

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

    override func setViews() {
        super.setViews()

        addSubview(titleLabel)
        addSubview(facebookLoginButton)
        addSubview(smsLoginButton)

        facebookLoginButton.addTarget(self, action: #selector(loginWithFacebook), for: .touchUpInside)
        smsLoginButton.addTarget(self, action: #selector(loginWithSMS), for: .touchUpInside)
    }

    override func layoutViews() {
        super.layoutViews()

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
        
    }

    @objc func loginWithFacebook() {
        delegate?.didTapLoginButton(for: .facebook)
    }

    @objc func loginWithSMS() {
        delegate?.didTapLoginButton(for: .SMS)
    }
}
