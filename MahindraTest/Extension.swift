//
//  Extension.swift

import Foundation
import UIKit

extension ViewController {
    
    func presentSingleButtonDialog() {
        let alert = UIAlertController(title: Constants.messageTitle, message: Constants.messageBody, preferredStyle: UIAlertController.Style.alert)
         
        alert.addAction(UIAlertAction(title: Constants.alertOk, style: UIAlertAction.Style.default) { _ in
            self.removeSpinnerView()
        }
        )
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    func loadSpinnerView() {
        addChild(child)
        child.view.frame = UIScreen.main.bounds
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func removeSpinnerView() {
        self.child.willMove(toParent: nil)
        self.child.view.removeFromSuperview()
        self.child.removeFromParent()
    }
}
