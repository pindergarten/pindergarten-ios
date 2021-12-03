//
//  PlusPopUpViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/25.
//

import UIKit

class PlusPopUpViewController: UIViewController {
    //MARK: - Properties
    var rootView: MeAndPetViewController?
    
    private let presentingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.applyShadow(color: .black, alpha: 0.45, x: 0, y: 4, blur: 20)
        return view
    }()
    
    private lazy var registerFeedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "게시물 등록하기", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 18)!, .foregroundColor : UIColor(hex: 0x9F5D1F)]), for: .normal)
        button.addTarget(self, action: #selector(didTapRegisterFeedButton), for: .touchUpInside)
        return button
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xFFE9A0)
        return view
    }()
    
    private lazy var registerPetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "반려견 추가하기", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 18)!, .foregroundColor : UIColor(hex: 0x9F5D1F)]), for: .normal)
        button.addTarget(self, action: #selector(didTapRegisterPetButton), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissVCWhenTappedAround()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        configureUI()
    }
  
    //MARK: - Action
    @objc func didTapRegisterFeedButton() {
        self.dismiss(animated: true) {
            let postFeedVC = PostFeedController()
            
            self.rootView?.navigationController?.pushViewController(postFeedVC, animated: true)
        }
//        self.navigationController?.popViewController(animated: true, completion: {
//                    let postFeedVC = PostFeedController()
//
//                    self.rootView?.navigationController?.pushViewController(postFeedVC, animated: true)
//                })
        
        
    }
       
    
    @objc func didTapRegisterPetButton() {

        self.dismiss(animated: true) {
            let registerPetVC = PetRegisterController()
            
            self.rootView?.navigationController?.pushViewController(registerPetVC, animated: true)
        }
    }
    
    @objc func dismissVC() {
       
        self.dismiss(animated: true, completion: nil)
        
    }

    //MARK: - Helpers
    func dismissVCWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissVC))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
    }
    
    
    private func configureUI() {
        view.addSubview(presentingView)
        presentingView.addSubview(registerFeedButton)
        presentingView.addSubview(line)
        presentingView.addSubview(registerPetButton)
        
        presentingView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(135)
        }
        
        registerFeedButton.snp.makeConstraints { make in
            make.top.equalTo(presentingView)
            make.left.right.equalTo(presentingView)
            make.bottom.equalTo(line.snp.top)
        }
        
        line.snp.makeConstraints { make in
            make.center.equalTo(presentingView)
            make.height.equalTo(2)
            make.left.right.equalTo(presentingView).inset(16)
        }
        
        registerPetButton.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom)
            make.left.right.equalTo(presentingView)
            make.bottom.equalTo(presentingView)
        }
    }
}
