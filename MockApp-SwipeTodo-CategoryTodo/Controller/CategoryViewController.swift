//
//  ViewController.swift
//  MockApp-SwipeTodo-CategoryTodo
//
//  Created by 近藤米功 on 2022/04/12.
//

import UIKit

class CategoryViewController: UIViewController{
    @IBOutlet weak var categoryTableView: UITableView!
    var categoryTodoArray: [CategoryInfo] = [
        CategoryInfo(categoryName: "仕事", categoryPhoto: UIImage(named: "work")),
        CategoryInfo(categoryName: "買い物", categoryPhoto: UIImage(named: "shopping")),
        CategoryInfo(categoryName: "読書", categoryPhoto: UIImage(named: "book")),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategoryTableView()
    }
    @IBAction func tappedAddCategoryTodoButton(_ sender: Any) {
        performSegue(withIdentifier: "AddTodoCategoryNameVCSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTodoCategoryNameVCSegue" {
            let addTodoCategoryNameViewController = segue.destination as! AddTodoCategoryNameViewController
            addTodoCategoryNameViewController.delegate = self
        }
    }
    private func setCategoryTableView(){
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(UINib(nibName: "CategoryTodoTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTodoID")
        // categoryTableView.rowHeight = view.frame.size.height/6
        categoryTableView.rowHeight = 100
    }
}
extension CategoryViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryTodoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTodoID", for: indexPath) as! CategoryTodoTableViewCell
            cell.categoryTodoLabel.text = categoryTodoArray[indexPath.row].categoryName
            cell.categoryTodoImageView.image = categoryTodoArray[indexPath.row].categoryPhoto
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                categoryTodoArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
}
extension CategoryViewController: AddTodoCategoryNameViewControllerDelegate {
    // AddTodoCategoryNameViewControllerDelegateのデリゲートメソッド
    func catchCategoryInfo(categoryInfo: CategoryInfo) {
        categoryTodoArray.append(categoryInfo)
        print(categoryTodoArray)
        categoryTableView.reloadData()
    }
}

