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
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
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
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //MARK: - Properties
    
    var selectedAssets = [PHAsset]()
    var photoArray = [UIImage]()
    var allPhotos:PHFetchResult<PHAsset>? = nil
    var keyboardHeight: CGFloat = 0
    
//    var imagePicker: UIImagePickerController?
    
    lazy var postFeedDataManager: PostFeedDataManager = PostFeedDataManager()
    
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
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
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
        

        let cameraStackGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCameraButton))
    
        cameraStack.isUserInteractionEnabled = true
        cameraStack.addGestureRecognizer(cameraStackGestureRecognizer)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)



        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: - Action
    @objc func keyboardWillShow(_ sender: Notification) {

        let userInfo:NSDictionary = sender.userInfo! as NSDictionary;
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        keyboardHeight = keyboardRectangle.size.height

        textView.snp.remakeConstraints { remake in
            remake.top.equalTo(separateImageLine.snp.bottom).offset(5)
            remake.left.equalTo(view).offset(20)
            remake.right.equalTo(view).offset(-20)
            remake.bottom.equalTo(view.snp.bottomMargin).offset(-keyboardHeight)
        }
        
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        textView.snp.remakeConstraints { remake in
            remake.top.equalTo(separateImageLine.snp.bottom).offset(5)
            remake.left.equalTo(view).offset(20)
            remake.right.equalTo(view).offset(-20)
            remake.bottom.equalTo(view.snp.bottomMargin)
        }
    
    }
    
    @objc private func didTapPostButton() {
        if selectedAssets.count < 1 {
            self.presentAlert(title: "게시물 등록시 1개 이상의\n사진이 필요합니다.")
        } else {
            finishButton.isUserInteractionEnabled = false
            finishButton.tintColor = UIColor(hex: 0xABABAB)
            postFeedDataManager.postFeed(images: photoArray, content: textView.text ?? "", delegate: self) { _ in
                
            }
        }

    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapCameraButton() {
        checkAlbumPermission()
    }
    
    @objc private func didTapDeleteBtn(_ sender: UIButton) {
//        myImages.remove(at: sender.tag)
        photoArray.remove(at: sender.tag)
        selectedAssets.remove(at: sender.tag)
        
        imageCntlabel.text = "\(selectedAssets.count)/10"
        imageCollectionView.reloadData()
    }
    //MARK: - Helpers
    func setAuthAlertAction() {
        let authAlertController: UIAlertController
        authAlertController = UIAlertController(title: "사진첩 권한 요청", message: "사진첩 권한을 허용해야만 게시물을 등록하실 수 있습니다.\n환경설정으로 이동하시겠습니까?", preferredStyle: .alert)
        
        let getAuthAction: UIAlertAction
        getAuthAction = UIAlertAction(title: "예", style: .default, handler: { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        authAlertController.addAction(getAuthAction)
        authAlertController.addAction(cancelAction)
        
        self.present(authAlertController, animated: true, completion: nil)
    }
    private func getAlbum() {
        let imagePicker = ImagePickerController()
        imagePicker.settings.theme.selectionStyle = .numbered
       
        imagePicker.settings.theme.selectionFillColor = .mainYellow
//        imagePicker.cancelButton.tintColor = .mainBrown
//        imagePicker.doneButton.tintColor = .mainBrown
//        imagePicker.albumButton.tintColor = .mainBrown
        
        let options = imagePicker.settings.fetch.album.options
              imagePicker.settings.fetch.album.fetchResults = [
                  PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: options),
                PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: options),
                PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumRecentlyAdded , options: options),
                PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumSelfPortraits , options: options),
                PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumTimelapses , options: options),
                PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumScreenshots , options: options),
                PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular , options: options)
       
              ]
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
    
    func checkAlbumPermission(){
        PHPhotoLibrary.requestAuthorization( { status in
            switch status{
            case .authorized:
                print("Album: 권한 허용")
                DispatchQueue.main.async {
                    self.getAlbum()
                }
            case .denied:
                print("Album: 권한 거부")
                DispatchQueue.main.async {
                    self.setAuthAlertAction()
                }
            case .restricted, .notDetermined:
                print("Album: 선택하지 않음")
            default:
                break
            }
        })
    }
    private func setCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
    }
    
    private func assetToImage(asset: PHAsset) -> UIImage {
        var image = UIImage()
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
//        option.deliveryMode = .highQualityFormat
        option.resizeMode = .exact
       
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            
            let isDegraded = (info?[PHImageResultIsDegradedKey] as? Bool) ?? false
            if isDegraded {
                return
            } else {
                image = result!
            }
        })
     
        return image
    }
    
    private func convertAssetToImages() {

            if selectedAssets.count != 0 {
                
              
                photoArray.removeAll()

                for i in 0..<selectedAssets.count {

                    let fetchOptions = PHFetchOptions()
    
                    allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                    let image = assetToImage(asset: selectedAssets[i])
 
                    self.photoArray.append(image)
                }
                
                DispatchQueue.main.async {
//                    for i in self.photoArray {
//                        print("높이: \(i.size.height), 가로: \(i.size.width)")
//                    }
                  
                    self.imageCollectionView.reloadData()
                }
            }
        }


    
    private func placeholderSetting() {
        textView.delegate = self // txtvReview가 유저가 선언한 outlet
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28

        textView.attributedText = NSMutableAttributedString(string: "내용은 최소 1자 이상, 사진은 최소 1장 이상 등록해주세요:)\n(본문 최대 2,000자까지, 사진 최대 10장까지)", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .font : UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, .foregroundColor : UIColor(hex: 0xC6C6C6)])
        
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
            make.top.equalTo(backButton.snp.bottom).offset(10)
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
            make.top.equalTo(separateImageLine.snp.bottom).offset(5)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
}

//MARK: - Extension
extension PostFeedController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
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
            paragraphStyle.lineSpacing = 2
            textView.attributedText = NSMutableAttributedString(string: "내용은 최소 1자 이상, 사진은 최소 1장 이상 등록해주세요:)\n(본문 최대 2,000자까지, 사진 최대 10장까지)", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .font : UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, .foregroundColor : UIColor(hex: 0xC6C6C6)])
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count >= 1 {
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

// 네트워크 함수
extension PostFeedController {
    func didSuccessPostFeed() {
        self.presentAlert(title: "게시물 등록이 완료되었습니다.") {[weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func failedToPostFeed(message: String) {
        finishButton.isUserInteractionEnabled = true
        finishButton.tintColor = UIColor.mainBrown
        self.presentAlert(title: message)
    }
}
