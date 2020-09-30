//
//  Extension.swift
//  FruitPang
//
//  Created by 윤병일 on 2020/09/23.
//

import UIKit

extension UIViewController {
  func configureGradientBackground() {
    let upperColor = UIColor(red: 205/255.0, green: 53/255.0, blue: 134/255.0, alpha: 1.0)
    let lowerColor = UIColor(red: 233/255.0, green: 171/255.0, blue: 67/255.0, alpha: 1.0)
    let gradient = CAGradientLayer()
    gradient.colors = [upperColor.cgColor, lowerColor.cgColor]
    gradient.locations = [0, 1]
    gradient.frame = view.frame
    view.layer.addSublayer(gradient)
  }
  
  func showAlert(_ title : String, _ message : String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
    alert.addAction(alertAction)
    present(alert, animated: true, completion: nil)
  }
}
