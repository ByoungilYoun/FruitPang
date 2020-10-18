//
//  GameInfoViewController.swift
//  FruitPang
//
//  Created by 윤병일 on 2020/10/14.
//

import UIKit

class GameInfoViewController : UIViewController {
  
  //MARK: - Properties
  private let firstInfo : UILabel = {
    let lb = UILabel()
    lb.text = "1. 남녀노소 누구나 즐길수 있는\n   심플 카드 매치 게임!🍎"
    lb.textColor = .white
    lb.font = UIFont.systemFont(ofSize: 20)
    lb.numberOfLines = 2
    return lb
  }()
  
  private let secondInfo : UILabel = {
    let lb = UILabel()
    lb.text = "2. 게임 모드는 총 3가지!\n   Easy, Normal, Hard 난이도에 따라 \n   게임을 즐기세요!🍌"
    lb.textColor = .white
    lb.font = UIFont.systemFont(ofSize: 20)
    lb.numberOfLines = 3
    return lb
  }()
  
  private let thirdInfo : UILabel = {
    let lb = UILabel()
    lb.text = "3. Easy 모드는 30초, Normal 모드는 40초,\n    Hard 모드는 50초 제한!🍇"
    lb.textColor = .white
    lb.font = UIFont.systemFont(ofSize: 20)
    lb.numberOfLines = 2
    return lb
  }()
  
  private let fourthInfo : UILabel = {
    let lb = UILabel()
    lb.text = "4. 게임시작 버튼을 누르면 기록 시작!🥝"
    lb.textColor = .white
    lb.font = UIFont.systemFont(ofSize: 20)
    lb.numberOfLines = 2
    return lb
  }()
  
  private let fifthInfo : UILabel = {
    let lb = UILabel()
    lb.text = "5. 게임을 통해 기억력을 향상시켜보세요!🍑"
    lb.textColor = .white
    lb.font = UIFont.systemFont(ofSize: 20)
    lb.numberOfLines = 2
    return lb
  }()
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavi()
  }
  
  //MARK: - setNavi()
  private func setNavi() {
    navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "게임 설명"
    
    let image = UIImage(systemName: "arrow.left")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(moveBack))
    navigationItem.leftBarButtonItem?.tintColor = .white
  }
  
  //MARK: - configureUI()
  private func configureUI() {
    
    let stackView = UIStackView(arrangedSubviews: [firstInfo, secondInfo, thirdInfo, fourthInfo, fifthInfo])
    stackView.axis = .vertical
    stackView.spacing = 20
    view.addSubview(stackView)
    
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-5)
    }
  }
  
  
  //MARK: - @objc func
  @objc func moveBack() {
    navigationController?.popViewController(animated: true)
  }
}
