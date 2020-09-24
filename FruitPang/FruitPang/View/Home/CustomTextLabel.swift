//
//  CustomTextLabel.swift
//  FruitPang
//
//  Created by 윤병일 on 2020/09/23.
//

import UIKit

class CustomTextLabel : UILabel {
  
  init(title : String) {
    super.init(frame: .zero)
    text = title
    textColor = UIColor.white
    textAlignment = .center
    font = UIFont.boldSystemFont(ofSize: 40)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
