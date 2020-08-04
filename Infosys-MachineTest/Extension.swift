//
//  Extension.swift
//  Infosys-MachineTest
//
//  Created by Augment Deck Technologies on 05/08/20.
//  Copyright © 2020 Augment Deck Technologies. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func presentSingleButtonDialog() {
        // create the alert
        let alert = UIAlertController(title: Constants.messageTitle, message: Constants.messageBody, preferredStyle: UIAlertController.Style.alert)
         // add an action (button)
        alert.addAction(UIAlertAction(title: Constants.alertOk, style: UIAlertAction.Style.default) { _ in
            self.removeSpinnerView()
        }
        )
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    func loadSpinnerView() {
        // add the spinner view controller
        addChild(child)
        child.view.frame = UIScreen.main.bounds
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func removeSpinnerView() {
        // remove the spinner view controller
        self.child.willMove(toParent: nil)
        self.child.view.removeFromSuperview()
        self.child.removeFromParent()
    }
}
