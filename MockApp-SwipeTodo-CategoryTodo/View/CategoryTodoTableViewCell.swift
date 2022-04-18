//
//  CategoryTodoTableViewCell.swift
//  MockApp-SwipeTodo-CategoryTodo
//
//  Created by 近藤米功 on 2022/04/12.
//

import UIKit

class CategoryTodoTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryTodoImageView: UIImageView!
    @IBOutlet weak var categoryTodoLabel: UILabel!
    @IBOutlet weak var categoryTodoCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCircleImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setCircleImageView(){
        // ImageViewを円形にする
        categoryTodoImageView.layer.cornerRadius = categoryTodoImageView.frame.width/2
        categoryTodoImageView.clipsToBounds = true
    }
    
}
