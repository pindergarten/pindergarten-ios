//
//  DetailPindergartenController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/14.
//

import UIKit
import ImageSlideshow
import Cosmos



class DetailPindergartenController: BaseViewController {

    
    //MARK: - Properties
  
    let totalTableVeiw: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.separatorStyle = .singleLine
        tv.separatorColor = UIColor(hex: 0xE9E9E9)
        tv.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        return tv
    }()

    let blogHeader: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "블로그 리뷰", attributes: [.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)!, .foregroundColor : UIColor.mainTextColor])
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.left.equalTo(view).offset(20)
            make.bottom.equalTo(view).offset(0)
        }
        return view
    }()
    
    let blogFooter: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Device.width, height: 60))
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "48개 블로그 리뷰 더보기", attributes: [.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)!, .foregroundColor : UIColor(hex: 0x535353)]), for: .normal)
//        button.addTarget(self, action: #selector(didTapMoreReviewButton), for: .touchUpInside)
        button.backgroundColor = UIColor(hex: 0xF3F3F3)
        button.layer.cornerRadius = 20
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.bottom.right.equalTo(view).offset(-20)
            make.height.equalTo(40)
        }
        return view
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableViewSetup()
        configureUI()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Action

    //MARK: - Helpers
    private func tableViewSetup() {
        
        totalTableVeiw.delegate = self
        totalTableVeiw.dataSource = self
        totalTableVeiw.register(DetailPindergartenInfoCell.self, forCellReuseIdentifier: DetailPindergartenInfoCell.identifier)
        totalTableVeiw.register(DetailPindergartenBasicInfoCell.self, forCellReuseIdentifier: DetailPindergartenBasicInfoCell.identifier)
        totalTableVeiw.register(DetailPindergartenBlogReviewCell.self, forCellReuseIdentifier: DetailPindergartenBlogReviewCell.identifier)
        totalTableVeiw.register(DetailPindergartenHeaderCell.self, forCellReuseIdentifier: DetailPindergartenHeaderCell.identifier)
        
        totalTableVeiw.tableFooterView = blogFooter
    
        
    }
    
    private func configureUI() {
        view.addSubview(totalTableVeiw)
        
        totalTableVeiw.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension DetailPindergartenController: DetailPindergartenHeaderCellDelegate {
    func didTapCallButton() {
        
    }
    
    func didTapHeartButton() {
        
    }
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapImage(imageSlide: ImageSlideshow) {
        imageSlide.presentFullScreenController(from: self)
    }
    
    
}

extension DetailPindergartenController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 2
        }
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        if indexPath == [0,0] {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPindergartenHeaderCell.identifier, for: indexPath) as! DetailPindergartenHeaderCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
        
        if indexPath == [0,1] {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPindergartenInfoCell.identifier, for: indexPath) as! DetailPindergartenInfoCell
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath == [0,2] {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPindergartenInfoCell.identifier, for: indexPath) as! DetailPindergartenInfoCell
            cell.selectionStyle = .none
            cell.titleLabel.text = "이용안내"
            cell.infoLabel.text = "주차, 무선 인터넷, 반려동물 동반, 남/녀 화장실 구분 "
            return cell
        }
        
        if indexPath == [0,3]  {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPindergartenBasicInfoCell.identifier, for: indexPath) as! DetailPindergartenBasicInfoCell
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPindergartenBlogReviewCell.identifier, for: indexPath) as! DetailPindergartenBlogReviewCell
            cell.selectionStyle = .none
            
        
            return cell
        }
        else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return blogHeader
        }
        return UIView()
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 30
        }
        return 0
    }
    
    
}
