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
  var model = CardModel()
  var cardArray = [Card]()
  var firstFlippedCardIndex : IndexPath?
  var buttonClicked : Bool = false
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    setNavi()
    configureUI()
    cardArray = model.getHardCards()
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
    collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
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
    buttonClicked = true
    
    timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
    checkGameEnded()
  }
  
  @objc private func timerElapsed() {
    miliseconds -= 1
    
    let seconds = String(format: "%.2f", miliseconds / 1000)
    secondLabel.text = "\(seconds)"
    
    if miliseconds <= 0 {
      timer?.invalidate()
      secondLabel.textColor = .red
      checkGameEnded()
    }
  }
}

//MARK: - UICollectionViewDataSource
extension HardModeController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cardArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
    let card = cardArray[indexPath.row]
    cell.setCard(card)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      if self.buttonClicked {
        cell.flip()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          cell.flipBack()
        }
      }
    }
    return cell
  }
}
//MARK: - UICollectionViewDelegate
extension HardModeController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if miliseconds <= 0 {
      return
    }
    
    let cell = collectionView.cellForItem(at: indexPath) as! CardCell
    
    let card = cardArray[indexPath.row]
    if card.isFlipped == false && card.isMatched == false {
      cell.flip()
      card.isFlipped = true
      
      if firstFlippedCardIndex == nil {
        firstFlippedCardIndex = indexPath
      } else {
        checkForMatches(indexPath)
      }
    }
  }
  
  func checkForMatches(_ secondFlippedCardIndex : IndexPath) {
    let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCell
    let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCell
    
    let cardOne = cardArray[firstFlippedCardIndex!.row]
    let cardTwo = cardArray[secondFlippedCardIndex.row]
    
    if cardOne.imageName == cardTwo.imageName {
      cardOne.isMatched = true
      cardTwo.isMatched = true
      cardOneCell?.remove()
      cardTwoCell?.remove()
      checkGameEnded()
    } else {
      cardOne.isFlipped = false
      cardTwo.isFlipped = false
      cardOneCell?.flipBack()
      cardTwoCell?.flipBack()
    }
    
    if cardOneCell == nil {
      collectionView.reloadItems(at: [firstFlippedCardIndex!])
    }
    firstFlippedCardIndex = nil
  }
  
  func checkGameEnded() {
    var isWon = true
    
    for card in cardArray {
      if card.isMatched == false {
        isWon = false
        break
      }
    }
    
    var title = ""
    var message = ""
    
    if isWon == true {
      if miliseconds > 0 {
        timer?.invalidate()
      }
      title = "축하합니다"
      message = "모두 맞추셨어요!"
    } else {
      if miliseconds > 0 {
        return
      }
      title = "아쉬워요"
      message = "모두 못맞추셨네요"
    }
    showAlert(title, message)
  }
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

