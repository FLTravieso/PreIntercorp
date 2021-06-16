//
//  IntercorpChallengeViewController.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 15/06/2021.
//

import UIKit

class IntercorpChallengeViewController<V: IntercorpChallengeView>: UIViewController {

    override func loadView() {
        view = V()
    }

    var customView: V {
        return view as! V
    }
}
