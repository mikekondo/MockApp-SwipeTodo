//
//  AddTodoCategoryNameViewController.swift
//  MockApp-SwipeTodo-CategoryTodo
//
//  Created by 近藤米功 on 2022/04/12.
//

import UIKit
protocol AddTodoCategoryNameViewControllerDelegate{
    func catchCategoryInfo(categoryInfo: CategoryInfo)
}
class AddTodoCategoryNameViewController: UIViewController {

    @IBOutlet var horizontalCollectionView: UICollectionView!
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var albumButton: UIButton!

    var checkPermission = CheckPermission()
    var categoryInfo = CategoryInfo()
    var delegate: AddTodoCategoryNameViewControllerDelegate?

    // PictureCollectionView関連
    private var photoArray: [String] = ["programming","cooking","imac","manran","mtg","coffee"]
    private var categoryNameArray: [String] = ["プログラミング","料理","PC作業","運動","打ち合わせ","勉強"]
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    private var cellWidth: CGFloat!
    private var cellHeight: CGFloat!
    private var cellOffset: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        categoryNameTextField.delegate = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        // アルバムボタンを押せなくする（テキストフィールドに値が入ってないため）
        albumButton.isEnabled = false
        albumButton.alpha = 0.1
        checkPermission.checkAlbum()
        let nib = UINib(nibName: "PictureCollectionViewCell", bundle: .main)
        horizontalCollectionView.register(nib, forCellWithReuseIdentifier: "PictureCollectionViewID")
    }

    @IBAction func tappedAlbumButton(_ sender: Any) {
        let sourceType: UIImagePickerController.SourceType = .photoLibrary
        createImagePicker(sourceType: sourceType)
    }

    private func createImagePicker(sourceType: UIImagePickerController.SourceType){
        let albumImagePicker = UIImagePickerController()
        albumImagePicker.sourceType = sourceType
        albumImagePicker.delegate = self
        albumImagePicker.allowsEditing = true
        present(albumImagePicker,animated: true,completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
extension AddTodoCategoryNameViewController: UITextFieldDelegate{
    // テキストを編集するたびに呼ばれるデリゲートメソッド
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // カテゴリ名がテキストフィールドに入力されるとアルバムボタンを押せるようにする
        albumButton.isEnabled = true
        albumButton.alpha = 1
        return true
    }
    // キーボードのReturnを押した時に発動するデリゲートメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

extension AddTodoCategoryNameViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    // アルバムのキャンセルボタンがタップされた時に呼ばれるデリゲートメソッド
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }

    // アルバムで画像を選択した時に呼ばれるデリゲートメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage = info[.editedImage] as? UIImage{
            let categoryName: String = categoryNameTextField.text ?? ""
            let categoryPhoto: UIImage = pickerImage
            categoryInfo.categoryName = categoryName
            categoryInfo.categoryPhoto = categoryPhoto
            print(categoryInfo)
            delegate?.catchCategoryInfo(categoryInfo: categoryInfo)
            picker.dismiss(animated: true,completion: nil)
            dismiss(animated: true)
        }
    }
}
extension AddTodoCategoryNameViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionViewID", for: indexPath) as! PictureCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 12 // セルを角丸にする
        cell.layer.shadowOpacity = 0.4 // セルの影の濃さを調整する
        cell.layer.shadowRadius = 12 // セルの影のぼかし量を調整する
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 10, height: 10) // 影の方向
        cell.layer.masksToBounds = false
        cell.categoryNameLabel.text = categoryNameArray[indexPath.row]
        cell.backgroundImageView.image = UIImage(named: photoArray[indexPath.row])
        cell.backgroundImageView.image = cell.darkenPictureCollectionViewCell(image: UIImage(named: photoArray[indexPath.row])!, level: 0.5)
        return cell
    }
    // セル同士の間隔を決めるデリゲートメソッド
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    // セルのサイズを決めるデリゲートメソッド
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellWidth = viewWidth - 75
        cellHeight = viewHeight - 300
        cellOffset = viewWidth - cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }

    // 余白の調整
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,left: cellOffset / 2,bottom: 0,right: cellOffset / 2)
    }

    //セルをタップしたら呼ばれるメソッド
}
