//
//  PictureCollectionViewCell.swift
//  MockApp-SwipeTodo-CategoryTodo
//
//  Created by 近藤米功 on 2022/04/17.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var categoryNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView.layer.cornerRadius = 12
    }
    public func darkenPictureCollectionViewCell(image:UIImage, level:CGFloat) -> UIImage {
        // 一時的な暗くするようの黒レイヤ
        let frame = CGRect(origin:CGPoint(x:0,y:0),size:image.size)
        let tempView = UIView(frame:frame)
        tempView.backgroundColor = UIColor.black
        tempView.alpha = level

        // 画像を新しいコンテキストに描画する
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        image.draw(in: frame)

        // コンテキストに黒レイヤを乗せてレンダー
        context!.translateBy(x: 0, y: frame.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        context!.clip(to: frame, mask: image.cgImage!)
        tempView.layer.render(in: context!)

        let imageRef = context!.makeImage()
        let toReturn = UIImage(cgImage:imageRef!)
        UIGraphicsEndImageContext()
        return toReturn
    }

}
