//
//  ReportController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/05.
//

import UIKit
import DropDown

class ReportController: BaseViewController {
    deinit {
            print("deinit")
    }
    //MARK: - Properties
    var postId: Int = 0
    var type: Int = 0
    
    lazy var reportDataManager: ReportDataManager = ReportDataManager()
    
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
        label.text = "신고하기"
        label.textColor = .mainTextColor
        return label
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "완료", attributes: [.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)!]), for: .normal)
        button.tintColor = UIColor(hex: 0xABABAB)
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(didTapReportButton), for: .touchUpInside)
        return button
    }()
    
    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private let reportTypeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "신고 유형", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!, .foregroundColor : UIColor(hex: 0x3D3D3D)])
        return label
    }()
    
    private lazy var reportTypeButton: UIButton = {
        let button  = UIButton(type: .system)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: 0xDADADA).cgColor
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0)
        button.setAttributedTitle(NSAttributedString(string: "신고 유형을 선택하세요", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!, .foregroundColor : UIColor(hex: 0xC6C6C6)]), for: .normal)
        button.addTarget(self, action: #selector(openDropDownMenu), for: .touchUpInside)
        return button
    }()
    
    private let dropDownImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dropDownButton"))
        return imageView
    }()
    
    private let reportSeparateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE9E9E9, alpha: 0.5)
        return view
    }()
    
    private let reportTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "신고 제목", attributes: [.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!, .foregroundColor : UIColor(hex: 0x3D3D3D)])
        return label
    }()
    
    private lazy var reportTitleTextFeild: UITextField = {
        let tf  = UITextField()
        tf.borderStyle = .none
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(hex: 0xDADADA).cgColor
        tf.layer.cornerRadius = 10
        tf.attributedPlaceholder = NSAttributedString(string: "신고 제목을 입력하세요(최대 40자)", attributes: [.foregroundColor:UIColor(hex: 0xC6C6C6), .font:UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!])
        let spacer = UIView()
        spacer.setDimensions(height: 35, width: 13)
        tf.leftView = spacer
        tf.leftViewMode = .always
        tf.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        tf.textColor = UIColor(hex: 0x3D3D3D)
        tf.addTarget(self, action: #selector(checkTextFeildLength), for: .editingChanged)
        return tf
    }()

    private let reportTitleSeparateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE9E9E9, alpha: 0.5)
        return view
    }()
    
    private let dropDown = DropDown()
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        return tv
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportTitleTextFeild.delegate = self
        
        setUpDropDown()
        configureUI()
        placeholderSetting()
    }
    //MARK: - Action
    @objc private func didTapReportButton(type: Int) {
        print("DEBUG: TAPPED REPORT BUTTON")
        print("\(Constant.BASE_URL)/api/posts/\(postId)/declaration?type=\(self.type)")
        reportDataManager.reportFeed(postId: postId, type: self.type, ReportRequest(title: reportTitleTextFeild.text ?? "", content: textView.text ?? ""), delegate: self)
    }
    
    @objc private func openDropDownMenu() {
        dropDown.show()
    
    }
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func checkTextFeildLength() {
        if reportTitleTextFeild.text?.count ?? 0 > 40 {
            reportTitleTextFeild.deleteBackward()
        }
        
        if textView.text.count >= 10 && reportTitleTextFeild.text?.count ?? 0 > 0 {
            finishButton.isUserInteractionEnabled = true
            finishButton.tintColor = UIColor.mainBrown
        } else {
            finishButton.isUserInteractionEnabled = false
            finishButton.tintColor = UIColor(hex: 0xABABAB)
        }
    }
    //MARK: - Helpers
    private func setUpDropDown() {
        dropDown.anchorView = reportTypeButton
        dropDown.dataSource = ["광고성 글", "스팸 컨텐츠", "욕설/비방/혐오", "노골적인 폭력 묘사"]
        dropDown.textColor = UIColor(hex: 0x3D3D3D)
        dropDown.backgroundColor = .white
        dropDown.textFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)!
        dropDown.selectionBackgroundColor = .white
        dropDown.cornerRadius = 10
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.type = index + 1
            print(self.type)
            reportTypeButton.setAttributedTitle(NSAttributedString(string: item, attributes: [.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!, .foregroundColor : UIColor(hex: 0x3D3D3D)]), for: .normal)
            
            if textView.text.count >= 10 && reportTitleTextFeild.text?.count ?? 0 > 0 {
                finishButton.isUserInteractionEnabled = true
                finishButton.tintColor = UIColor.mainBrown
            } else {
                finishButton.isUserInteractionEnabled = false
                finishButton.tintColor = UIColor(hex: 0xABABAB)
            }
            
        }
        
    }
    
    private func placeholderSetting() {
        textView.delegate = self // txtvReview가 유저가 선언한 outlet
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2

        textView.attributedText = NSMutableAttributedString(string: "신고하실 내용을 설명해주세요.(최소 10자, 최대 500자 입력 가능)", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .font : UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, .foregroundColor : UIColor(hex: 0xC6C6C6)])
        
    }
    
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(finishButton)
        view.addSubview(separateLine)
        view.addSubview(reportTypeLabel)
        view.addSubview(reportTypeButton)
        reportTypeButton.addSubview(dropDownImageView)
        view.addSubview(reportSeparateLine)
        view.addSubview(reportTitleLabel)
        view.addSubview(reportTitleTextFeild)
        view.addSubview(reportTitleSeparateLine)
        view.addSubview(textView)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton).offset(2)
            make.centerX.equalTo(view)
        }
        
        finishButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(view).offset(-20)
            make.width.height.equalTo(26)
        }
        
        separateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        reportTypeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(reportTypeButton)
            make.left.equalTo(view).offset(20)
            make.width.equalTo(60)
        }
        
        reportTypeButton.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom).offset(20)
            make.left.equalTo(reportTypeLabel.snp.right).offset(26)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(35)
        }
        
        dropDownImageView.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.top.equalTo(reportTypeButton).offset(5)
            make.right.equalTo(reportTypeButton).offset(-8)
        }
        
        reportSeparateLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(reportTypeButton.snp.bottom).offset(14)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        reportTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(reportTitleTextFeild)
            make.left.equalTo(view).offset(20)
            make.width.equalTo(60)
        }
        
        reportTitleTextFeild.snp.makeConstraints { make in
            make.top.equalTo(reportSeparateLine.snp.bottom).offset(14)
            make.left.equalTo(reportTitleLabel.snp.right).offset(26)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(35)
        }
        
        reportTitleSeparateLine.snp.makeConstraints { make in
            make.top.equalTo(reportTitleTextFeild.snp.bottom).offset(14)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(1)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(reportTitleSeparateLine.snp.bottom).offset(14)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
}

//MARK: - Extension
extension ReportController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = reportTitleTextFeild.text else {return false}
            
            // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
            if text.count >= 40 && range.length == 0 && range.location < 40 {
                return false
            }
            
            return true
        }
}

extension ReportController: UITextViewDelegate {
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
            textView.attributedText = NSMutableAttributedString(string: "신고하실 내용을 설명해주세요.(최소 10자, 최대 500자 입력 가능)", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .font : UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, .foregroundColor : UIColor(hex: 0xC6C6C6)])

        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count >= 10 && reportTitleTextFeild.text?.count ?? 0 > 0 {
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
        if text.count >= 500 && range.length == 0 && range.location < 500 {
            return false
        }
        
        return true
    }

}

// 네트워크 함수
extension ReportController {
    func didSuccessReportFeed() {
        self.presentAlert(title: "신고접수 되었습니다.") { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func failedToReportFeed(message: String) {
        self.presentAlert(title: message)
    }
}
