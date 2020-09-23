//
//  HomeCustomButton.swift
//  FruitPang
//
//  Created by 윤병일 on 2020/09/23.
//

import UIKit

class HomeCustomButton : UIButton {
  
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
    layer.cornerRadius = 15
    setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
    setHeight()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - setHeight()
  private func setHeight() {
    self.snp.makeConstraints {
      $0.height.equalTo(80)
    }
  }
}
