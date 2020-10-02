//
//  HardModeController.swift
//  FruitPang
//
//  Created by 윤병일 on 2020/09/25.
//

import UIKit

class HardModeController : UIViewController {
  
  //MARK: - Properties
  private let collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  private let timeLabel : UILabel = {
    let lb = UILabel()
    lb.text = "남은 시간: "
    lb.font = UIFont.boldSystemFont(ofSize: 20)
    lb.textColor = .white
    lb.textAlignment = .center
    return lb
  }()
  
  private let secondLabel : UILabel = {
    let lb = UILabel()
    lb.text = "00.00"
    lb.font = UIFont.boldSystemFont(ofSize: 20)
    lb.textColor = .white
    return lb
  }()
  
  var timer : Timer?
  var miliseconds : Float = 50 * 1000
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    setNavi()
    configureUI()
  }
  
  //MARK: - Standard
  struct Standard {
    static let standard : CGFloat = 10
    static let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
  
  //MARK: - setNavi()
  private func setNavi() {
    let image = UIImage(systemName: "arrow.left")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(moveBack))
    navigationItem.leftBarButtonItem?.tintColor = .white
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "게임 시작", style: .plain, target: self, action: #selector(gameStart))
    navigationItem.rightBarButtonItem?.tintColor = .white
  }
  
  //MARK: - configureUI()
  private func configureUI() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .clear
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.isScrollEnabled = false
    
    [timeLabel, secondLabel ,collectionView].forEach{
      view.addSubview($0)
    }
    
    timeLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(view.frame.size.height / 15)
      $0.leading.equalToSuperview().offset(view.frame.size.width / 3.5)
    }
    
    secondLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(view.frame.size.height / 15)
      $0.leading.equalTo(timeLabel.snp.trailing).offset(5)
    }
  
    collectionView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.8)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }

  //MARK: - @objc func
  @objc private func moveBack() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func gameStart() {
    guard ((timer?.isValid) == nil) else {return}
    timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
  }
  
  @objc private func timerElapsed() {
    miliseconds -= 1
    
    let seconds = String(format: "%.2f", miliseconds / 1000)
    secondLabel.text = "\(seconds)"
    
    if miliseconds <= 0 {
      timer?.invalidate()
      secondLabel.textColor = .red
    }
  }
}

//MARK: - UICollectionViewDataSource
extension HardModeController : UICollectionViewDataSource {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  return 20
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
  cell.backgroundColor = .link
  return cell
}
}
//MARK: - UICollectionViewDelegate
extension HardModeController : UICollectionViewDelegate {

}

extension HardModeController : UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
  return Standard.standard
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
  return Standard.standard
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
  return Standard.inset
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  let width = view.frame.size.width - Standard.inset.left - Standard.inset.right - (Standard.standard * 3)
  let realWidth = width / 4
  return CGSize(width: realWidth, height: 100)
  }
}

