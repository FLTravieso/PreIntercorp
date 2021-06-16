//
//  IntercorpChallengeView.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 15/06/2021.
//

import UIKit

class IntercorpChallengeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViews()
        layoutViews()
    }

    /// Set your view and its subviews here.
    func setViews() {
        backgroundColor = .white
    }

    /// Layout your subviews here.
    func layoutViews() {}

}
