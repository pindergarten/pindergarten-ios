//
//  PostFeedController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/16.
//

import UIKit
import BSImagePicker
import Photos

class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"
    
    let imageView = UIImageView()
    let deleteBtn = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        deleteBtn.setImage(UIImage(named: "deleteBtn"), for: .normal)
        contentView.addSubview(imageView)
        contentView.addSubview(deleteBtn)
        
        imageView.snp.makeConstraints { make in
            make.left.equalTo(contentView)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(95)
        }
        deleteBtn.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.top).offset(2)
            make.centerX.equalTo(imageView.snp.right).offset(-2)
            make.width.height.equalTo(30)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class PostFeedController: BaseViewController {
    
    deinit {
            print("deinit")
    }
    //MARK: - Properties
    var myImages = [Data]()
    
    var selectedAssets = [PHAsset]()
    var photoArray = [UIImage]()
    
    var imagePicker: ImagePickerController?
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        label.text = "게시물 올리기"
        label.textColor = .mainTextColor
        return label
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "등록", attributes: [.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)!]), for: .normal)
        button.tintColor = UIColor(hex: 0xABABAB)
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        return button
    }()
    
    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private let imageCntlabel = UILabel()
    
    private lazy var cameraStack: UIStackView = {
        let cameraImg = UIImageView()
        let stack = UIStackView(arrangedSubviews: [cameraImg, imageCntlabel])
        
        cameraImg.image = UIImage(named: "camera")
        imageCntlabel.attributedText = NSAttributedString(string: "0/10", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 12)!, .foregroundColor : UIColor(hex: 0x9F5D1F)])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }()

    private lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainLightYellow
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapCameraButton), for: .touchUpInside)
        button.addSubview(cameraStack)
        cameraStack.snp.makeConstraints { make in
            make.center.equalTo(button)
        }
        
        return button
    }()
    
    private let separateImageLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE9E9E9)
        return view
    }()
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        return tv
    }()

    private let imageCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .white
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        return cv
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        configureUI()
        placeholderSetting()
        
    }
    //MARK: - Action
    @objc private func didTapPostButton() {
        if selectedAssets.count < 1 {
            self.presentAlert(title: "게시물 등록시 1개 이상의\n사진이 필요합니다.")
        }

    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapCameraButton() {
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 10 - selectedAssets.count
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]

//        let vc = self

        presentImagePicker(imagePicker, select: { (asset) in

                // User selected an asset. Do something with it. Perhaps begin processing/upload?

        }, deselect: { (asset) in
                // User deselected an asset. Cancel whatever you did when asset was selected.

        }, cancel: { (assets) in
                // User canceled selection.

        }, finish: { (assets) in
                // User finished selection assets.

            for i in 0..<assets.count {
                self.selectedAssets.append(assets[i])
                self.imageCntlabel.text = "\(self.selectedAssets.count)/10"
             }
             self.convertAssetToImages()
         })
    }
    
    @objc private func didTapDeleteBtn(_ sender: UIButton) {
        print(sender.tag)
        myImages.remove(at: sender.tag)
        photoArray.remove(at: sender.tag)
        selectedAssets.remove(at: sender.tag)
        
        imageCntlabel.text = "\(selectedAssets.count)/10"
        imageCollectionView.reloadData()
    }
    //MARK: - Helpers
    private func setCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
    }
    
    private func convertAssetToImages() {

            if selectedAssets.count != 0 {
                
                myImages.removeAll()
                photoArray.removeAll()

                for i in 0..<selectedAssets.count {

                    let manager = PHImageManager.default()
                    let option = PHImageRequestOptions()
                    option.isSynchronous = true
                    var thumbnail = UIImage()

                    manager.requestImage(for: selectedAssets[i],
                                              targetSize: CGSize(width: 95, height: 95),
                                              contentMode: .aspectFit,
                                              options: option) { (result, info) in
                        thumbnail = result!
                    }

                    let data = thumbnail.jpegData(compressionQuality: 0.7)
                    let newImage = UIImage(data: data!)

                    self.photoArray.append(newImage! as UIImage)
                    self.myImages.append(data!)
                }
                
                DispatchQueue.main.async {
                    self.imageCollectionView.reloadData()
                }
            }
        }

    private func placeholderSetting() {
        textView.delegate = self // txtvReview가 유저가 선언한 outlet
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28

        textView.attributedText = NSMutableAttributedString(string: "내용은 최소 10자 이상, 사진은 최소 1장 이상 등록해주세요:)\n(본문 최대 2,000자까지, 사진 최대 10장까지)", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .font : UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, .foregroundColor : UIColor(hex: 0xC6C6C6)])
        
    }
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(finishButton)
        view.addSubview(separateLine)
        view.addSubview(cameraButton)
        view.addSubview(imageCollectionView)
        view.addSubview(separateImageLine)
        view.addSubview(textView)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalTo(view)
        }
        
        finishButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.right.equalTo(view).offset(-20)
            make.width.height.equalTo(26)
        }
        
        separateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.width.height.equalTo(95)
            make.top.equalTo(separateLine.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom)
            make.left.equalTo(cameraButton.snp.right).offset(20)
            make.right.equalTo(view)
            make.bottom.equalTo(separateImageLine.snp.top)
        }
        
        separateImageLine.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(20)
            make.top.equalTo(cameraButton.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(separateImageLine.snp.bottom).offset(14)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
}

//MARK: - Extension
extension PostFeedController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.deleteBtn.tag = indexPath.item
        cell.imageView.image = photoArray[indexPath.item]
        cell.deleteBtn.addTarget(self, action: #selector(didTapDeleteBtn), for: .touchUpInside)
        cell.imageView.layer.cornerRadius = 10
        cell.imageView.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
}

extension PostFeedController: UITextViewDelegate {
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(hex: 0xC6C6C6) {
            textView.text = nil
            textView.textColor = UIColor(hex: 0x3D3D3D)
        }
        
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.28
            textView.attributedText = NSMutableAttributedString(string: "내용은 최소 10자 이상, 사진은 최소 1장 이상 등록해주세요:)\n(본문 최대 2,000자까지, 사진 최대 10장까지)", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .font : UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, .foregroundColor : UIColor(hex: 0xC6C6C6)])

        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count >= 10 {
            finishButton.isUserInteractionEnabled = true
            finishButton.tintColor = UIColor.mainBrown
        } else {
            finishButton.isUserInteractionEnabled = false
            finishButton.tintColor = UIColor(hex: 0xABABAB)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard let text = textView.text else {return false}
        
        // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
        if text.count >= 2000 && range.length == 0 && range.location < 2000 {
            return false
        }
        
        return true
    }

}
