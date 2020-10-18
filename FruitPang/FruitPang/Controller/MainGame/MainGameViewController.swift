//
//  MainGameViewController.swift
//  FruitPang
//
//  Created by 윤병일 on 2020/09/24.
//

import UIKit

class MainGameViewController : UIViewController {
  
  //MARK: - Properties
  
  private let welcomeLabel : UILabel = {
    let lb = UILabel()
    let attributeTitle = NSMutableAttributedString(string: "환영합니다!🙌🏻\n", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 24)!,  .foregroundColor : UIColor.white])
    attributeTitle.append(NSAttributedString(string: "기억력을 향상시켜보세요!🤔", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!, .foregroundColor : UIColor.white]))
    lb.attributedText = attributeTitle
    lb.numberOfLines = 2
    return lb
  }()
  
  private let easyButton : MainCustomButton = {
    let bt = MainCustomButton()
    bt.title = "Easy"
    bt.color = UIColor.systemGreen
    bt.addTarget(self, action: #selector(goToEasyMode), for: .touchUpInside)
    return bt
  }()
  
  private let normalButton : MainCustomButton = {
    let bt = MainCustomButton()
    bt.title = "Normal"
    bt.color = UIColor.systemIndigo
    bt.addTarget(self, action: #selector(goToNormalMode), for: .touchUpInside)
    return bt
  }()
  
  private let hardButton : MainCustomButton = {
    let bt = MainCustomButton()
    bt.title = "Hard"
    bt.color = UIColor.systemRed
    bt.addTarget(self, action: #selector(goToHardMode), for: .touchUpInside)
    return bt
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    setNavi()
    configureUI()
  }
  
  //MARK: - setNavi()
  private func setNavi() {
    navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.barStyle = .black
    navigationItem.title = "Fruit Pang"
    
    let image = UIImage(systemName: "arrow.left")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(moveBack))
    navigationItem.leftBarButtonItem?.tintColor = .white
  }
  
  //MARK: - setConstraints()
  private func configureUI() {
    view.addSubview(welcomeLabel)
    
    let height = view.frame.size.height
    
    welcomeLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(height / 15)
      $0.leading.equalToSuperview().offset(20)
    }
    
    let stackView = UIStackView(arrangedSubviews: [easyButton, normalButton, hardButton])
    stackView.axis = .vertical
    stackView.spacing = 30
    view.addSubview(stackView)
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).multipliedBy(2)
      $0.leading.equalToSuperview().offset(100)
      $0.trailing.equalToSuperview().offset(-100)
    }
  }
  
  //MARK: - @objc func
  @objc func moveBack() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func goToEasyMode() {
    let controller = EasyModeViewController()
    controller.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func goToNormalMode() {
    let controller = NormalModeController()
    controller.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func goToHardMode() {
    let controller = HardModeController()
    controller.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(controller, animated: true)
  }
}
