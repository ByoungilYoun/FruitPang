//
//  MainCustomButton.swift
//  FruitPang
//
//  Created by 윤병일 on 2020/09/25.
//

import UIKit

class MainCustomButton : UIButton {
  
  //MARK: - Properties
  var title : String? {
    didSet {
      setTitle(title, for: .normal)
    }
  }
  
  var color : UIColor? {
    didSet {
      backgroundColor = color
    }
  }
  
  //MARK: - init
  override init(frame: CGRect) {
    super.init(frame: .zero)
    layer.cornerRadius = 20
    setTitleColor(UIColor(white: 1, alpha: 0.87), for: .normal)
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
    setHeight()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - setHeight()
  private func setHeight() {
    self.snp.makeConstraints {
      $0.height.equalTo(100)
    }
  }
  
}
