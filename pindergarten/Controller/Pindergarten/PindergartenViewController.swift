//
//  PindergartenViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/31.
//

import UIKit

let imageList: [UIImage] = [#imageLiteral(resourceName: "backgroundImage"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "backgroundImage"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "3") , #imageLiteral(resourceName: "backgroundImage"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "3")  ,#imageLiteral(resourceName: "backgroundImage"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "3")]

class PindergartenViewController: BaseViewController {
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainTextColor
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        label.attributedText = NSAttributedString(
            string: "펫 유치원, 이제 핀더가든 앱으로 편리하게 보내세요",
            attributes: [.font : UIFont(name: "AppleSDGothicNeoEB00", size: 18)!, .paragraphStyle : paragraphStyle])
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
       
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plusButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var eventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "eventButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapEventButton), for: .touchUpInside)
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PinterestLayout())
        collectionView.backgroundColor = .white
        return collectionView
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 40, right: 12)
        
        
        // Set the PinterestLayout delegate
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Action
    @objc func didTapPlusButton() {
        
    }
    
    @objc func didTapEventButton() {
        navigationController?.pushViewController(EventViewController(), animated: true)
    }
    //MARK: - Helpers
    func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(plusButton)
        view.addSubview(eventButton)
        view.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(plusButton.snp.left).offset(-40)
        }
        
        plusButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.topMargin)
            make.right.equalTo(eventButton.snp.left).offset(-25)
            make.height.width.equalTo(20)
        }
        
        eventButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.topMargin)
            make.right.equalTo(view).offset(-20)
            make.height.width.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view)
//            make.right.equalTo(view)
//            make.bottom.equalTo(view)
        }
    }
}

//MARK: - Extenseion
extension PindergartenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
 
        cell.delegate = self
        cell.imageView.image = imageList[indexPath.row]

        
        return cell
    }
    
    
}

extension PindergartenViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cellWidth: CGFloat = (view.bounds.width - 4) / 2 // 셀 가로 크기
        let imageHeight = imageList[indexPath.item].size.height
        let imageWidth = imageList[indexPath.item].size.width
        // 이미지 비율
        let imageRatio = imageHeight/imageWidth


        return imageRatio * cellWidth
    }
}

extension PindergartenViewController: HomeCellDelegate {
    func didTapHeartButton() {
        

    }
    
    
}

//#if DEBUG
//import SwiftUI
//struct PindergartenViewControllerRepresentable: UIViewControllerRepresentable {
//
//func updateUIViewController(_ uiView: UIViewController,context: Context) {
//        // leave this empty
//}
//@available(iOS 13.0.0, *)
//func makeUIViewController(context: Context) -> UIViewController{
//    PindergartenViewController()
//    }
//}
//@available(iOS 13.0, *)
//struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Group {
//            if #available(iOS 14.0, *) {
//                PindergartenViewControllerRepresentable()
//                    .ignoresSafeArea()
//                    .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
//                    .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//            } else {
//                PindergartenViewControllerRepresentable()
////                    .ignoresSafeArea()
//                    .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
//                    .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//            }
//        }
//
//    }
//} #endif
