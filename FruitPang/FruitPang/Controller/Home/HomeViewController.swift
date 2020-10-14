//
//  HomeViewController.swift
//  FruitPang
//
//  Created by 윤병일 on 2020/09/22.
//

import UIKit

class HomeViewController : UIViewController {
  
  //MARK: - Properties
  private let mainImageView : UIImageView = {
    let im = UIImageView()
    im.image = UIImage(named: "Main Icon")
    return im
  }()
  
  private let titleLabel = CustomTextLabel(title: "Fruit Pang")
  
  private let gameInfoButton : HomeCustomButton = {
    let bt = HomeCustomButton()
    bt.title = "게임 설명"
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    bt.color = UIColor.link
    bt.addTarget(self, action: #selector(movtToGameInfoVC), for: .touchUpInside)
    return bt
  }()
  
  private let gameStartButton : HomeCustomButton = {
    let bt = HomeCustomButton()
    bt.title = "게임 시작"
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    bt.color = UIColor.link
    bt.addTarget(self, action: #selector(moveToGameVC), for: .touchUpInside)
    return bt
  }()
  
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    setUI()
    setConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavi()
  }
  //MARK: - setNavi()
  private func setNavi() {
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
  }
  
  //MARK: - setUI()
  private func setUI() {
    [mainImageView, titleLabel].forEach {
      view.addSubview($0)
    }
  }
  
  //MARK: - setConstraints()
  private func setConstraints() {
    mainImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).multipliedBy(3)
      $0.width.height.equalTo(view.frame.size.width / 2)
    }
    
    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(mainImageView.snp.bottom).offset(20)
      $0.height.equalTo(40)
    }
    
    let stackView = UIStackView(arrangedSubviews: [gameInfoButton, gameStartButton])
    stackView.axis = .vertical
    stackView.spacing = 20
    view.addSubview(stackView)
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).multipliedBy(1.5)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }
  }
  
  @objc func moveToGameVC() {
    let controller = MainGameViewController()
    controller.modalPresentationStyle = .fullScreen
    controller.modalTransitionStyle = .coverVertical
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func movtToGameInfoVC() {
    let controller = GameInfoViewController()
    controller.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(controller, animated: true)
  }
}
