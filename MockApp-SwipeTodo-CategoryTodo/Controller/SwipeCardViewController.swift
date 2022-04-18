//
//  SwipeCardViewController.swift
//  MockApp-SwipeTodo-CategoryTodo
//
//  Created by 近藤米功 on 2022/04/15.
//

import UIKit
import VerticalCardSwiper
class SwipeCardViewController: UIViewController {

    @IBOutlet weak var cardSwiper: VerticalCardSwiper!
    var cardInfoArray: [CardInfo] = [CardInfo(categoryName: "仕事", categoryPhoto: UIImage(named: "work"), todo: "朝のメールチェック"),CardInfo(categoryName: "買い物", categoryPhoto: UIImage(named: "shopping"), todo: "大根かう"),CardInfo(categoryName: "読書", categoryPhoto: UIImage(named: "book"), todo: "裸足のゲンを読む")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        cardSwiper.delegate = self
        cardSwiper.datasource = self
        cardSwiper.register(nib: UINib(nibName: "CardViewCell", bundle: nil), forCellWithReuseIdentifier: "CardViewID")
        cardSwiper.reloadData()
    }

    @IBAction func tappedSwipeRightButton(_ sender: Any) {
        // ライブラリのコードコピペ
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.swipeCardAwayProgrammatically(at: currentIndex, to: .Right)
        }
    }

    @IBAction func tappedSwipeLeftButton(_ sender: Any) {
        // ライブラリのコードコピペ
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.swipeCardAwayProgrammatically(at: currentIndex, to: .Left)
        }
    }
}

extension SwipeCardViewController: VerticalCardSwiperDelegate,VerticalCardSwiperDatasource{
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return cardInfoArray.count
    }

    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "CardViewID", for: index) as? CardViewCell {
            cardCell.setRandomBackgroundColor()
            // verticalCardSwiperView.backgroundColor = UIColor.random()
            verticalCardSwiperView.backgroundColor = .white
            cardCell.categoryNameLabel.text = cardInfoArray[index].categoryName
            cardCell.categoryPhotoImageView.image = cardInfoArray[index].categoryPhoto
            cardCell.categoryPhotoImageView.image = cardCell.darkenCardViewCell(image: cardInfoArray[index].categoryPhoto!, level: 0.5)
            cardCell.todoLabel.text = cardInfoArray[index].todo
            return cardCell
        }
        return CardCell()
    }
    // デフォルトが(width: 375, height: 600)
    //    func sizeForItem(verticalCardSwiperView: VerticalCardSwiperView, index: Int) -> CGSize {
    //        return CGSize(width: 400, height: 465)
    //    }
}

extension UIColor {
    // ランダムカラー関数
    // TODO: 使用するカラーを決める
    static func random() -> UIColor {
        let red: CGFloat = CGFloat.random(in: 0.5...1)
        let green: CGFloat = CGFloat.random(in: 0.5...1)
        let blue: CGFloat = CGFloat.random(in: 0.5...1)
        return UIColor.init(red: red, green: green, blue: blue, alpha: 0.5)
    }
}
