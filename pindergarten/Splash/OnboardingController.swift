//
//  OnboardingController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/27.
//

import UIKit

class OnboardingController: UIViewController {
    //MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    }()

    let scriptLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, scriptLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.setHeight(80)
        return stack
    }()
    
//    let titleImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFit
//        iv.setHeight(100)
//        return iv
//    }()
    
    
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelStack, imageView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 30
        stack.sizeToFit()
        return stack
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainBrown
        button.setAttributedTitle(NSAttributedString(string: "바로 시작하기", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 18)!, .foregroundColor : UIColor.mainLightYellow]), for: .normal)
        button.layer.cornerRadius = 20
        button.titleEdgeInsets = UIEdgeInsets(top: -18, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return button
    }()
    
    var first: Bool = false
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        view.backgroundColor = .mainLightYellow
    }
    
    init(titleName: String, script: String, imageName: String, last: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        
        let paragraphStyle = NSMutableParagraphStyle()
        let scriptParagraphStyle = NSMutableParagraphStyle()
        scriptParagraphStyle.lineSpacing = 3
        paragraphStyle.alignment = .center
        scriptParagraphStyle.alignment = .center
        
        self.titleLabel.attributedText = NSAttributedString(string: titleName, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .font : UIFont(name: "Roboto-Black", size: 25)!, .foregroundColor : UIColor.mainBrown])

        self.scriptLabel.attributedText = NSAttributedString(string: script, attributes: [NSAttributedString.Key.paragraphStyle : scriptParagraphStyle, .font : UIFont(name: "Roboto-Medium", size: 15)!, .foregroundColor : UIColor.mainBrown])
        
//        self.titleImageView.image = UIImage(named: titleImage)
        self.imageView.image = UIImage(named: imageName)
        self.startButton.isHidden = !last

    }
    
    
    init(imageName: String, last: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        
        let paragraphStyle = NSMutableParagraphStyle()
        let scriptParagraphStyle = NSMutableParagraphStyle()
        scriptParagraphStyle.lineSpacing = 3
        paragraphStyle.alignment = .center
        scriptParagraphStyle.alignment = .center
        
//        self.titleLabel.attributedText = NSAttributedString(string: titleName, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .font : UIFont(name: "Roboto-Black", size: 25)!, .foregroundColor : UIColor.mainBrown])
//
//        self.scriptLabel.attributedText = NSAttributedString(string: script, attributes: [NSAttributedString.Key.paragraphStyle : scriptParagraphStyle, .font : UIFont(name: "Roboto-Medium", size: 15)!, .foregroundColor : UIColor.mainBrown])
        
//        self.titleImageView.image = UIImage(named: titleImage)
        self.imageView.image = UIImage(named: imageName)
        self.startButton.isHidden = !last

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    @objc private func didTapStartButton() {
        self.changeRootViewController(UINavigationController(rootViewController: NewSplashController()))
    }
    //MARK: - Helpers
    private func configureUI() {
//        view.addSubview(titleLabel)
//        view.addSubview(scriptLabel)
//        view.addSubview(titleImageView)
//        view.addSubview(stack)
        view.addSubview(imageView)
        view.addSubview(startButton)
       

//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(view).offset(130*view.frame.size.height/812)
//            make.left.right.equalTo(view).inset(20)
//            make.height.equalTo(25)
//        }
//
//        scriptLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(10)
//            make.left.right.equalTo(view).inset(20)
//            make.height.equalTo(70)
//        }

//        stack.snp.makeConstraints { make in
//            make.top.equalTo(view).offset(30)
//            make.left.right.equalTo(view).inset(20)
////            make.height.equalTo(110)
//        }
//
        
//        titleImageView.snp.makeConstraints { make in
//            make.top.equalTo(130*view.frame.size.height/812)
//            make.centerX.equalTo(view)
//            make.height.equalTo(110)
//        }
        
        imageView.snp.makeConstraints { make in
//            make.edges.equalTo(view)
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
//            make.height.equalTo(570/812*view.frame.size.height)
        }
        
//        stack.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
//            make.left.right.equalTo(view).inset(40)
//            make.bottom.equalTo(view)
//        }
        
        startButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            if Device.isNotch {
                make.height.equalTo(66)
            } else {
                make.height.equalTo(60)
            }
           
        }
    }
}
