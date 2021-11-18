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
  
    lazy var getDetailPindergartenDataManager: GetDetailPindergartenDataManager = GetDetailPindergartenDataManager()
    lazy var getBlogReviewDataManager: GetBlogReviewDataManager = GetBlogReviewDataManager()
    lazy var pindergartenLikeDataManager: PindergartenLikeDataManager = PindergartenLikeDataManager()
    
    
    var detailResult: GetDetailPindergartenResult? {
        didSet {
            totalTableVeiw.reloadData()
        }
    }
    
    var blogReviewResult: [GetBlogReviewResult]? {
        didSet {
            totalTableVeiw.reloadData()
        }
    }
    
    var pindergartenID: Int = 0
    
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
    let blogCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.textColor = UIColor(hex: 0x535353)
        label.text = "0개 블로그 리뷰 더보기"
        return label
    }()
    
    lazy var defaultFooter: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Device.width, height: 180))
        let imageView = UIImageView(image: UIImage(named: "8"))
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-20)
        }
        return view
    }()
    
    lazy var blogFooter: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Device.width, height: 60))
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapMoreReviewButton), for: .touchUpInside)
        button.backgroundColor = UIColor(hex: 0xF3F3F3)
        button.layer.cornerRadius = 20
        view.addSubview(button)
        button.addSubview(blogCountLabel)
        button.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.bottom.right.equalTo(view).offset(-20)
            make.height.equalTo(40)
        }
        
        blogCountLabel.snp.makeConstraints { make in
            make.center.equalTo(button)
        }
        
        return view
    }()
    
    var imageInput: [InputSource] = [] {
        didSet {
            totalTableVeiw.reloadData()
        }
    }
    
    var num: String = ""
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(pindergartenID)
 
        getDetailPindergartenDataManager.getDetailPindergarten(pindergartenId: pindergartenID, delegate: self)
        getBlogReviewDataManager.getBlogReviewPindergarten(pindergartenId: pindergartenID, delegate: self)
        tableViewSetup()
        configureUI()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Action
    
    @objc func didTapMoreReviewButton() {
        let blogVC = BlogReviewController()
        blogVC.review = blogReviewResult
        navigationController?.pushViewController(blogVC, animated: true)
    }
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

//MARK: - Extension

extension DetailPindergartenController: BasicInfoCellDelegate {
    func didTapPhonLabel() {
        print("DEBUG: TAPPED PHONE LABEL")
    }
    
    func didTapWebsiteLabel() {
        print("DEBUG: TAPPED WEBSITE LABEL")
    }
    
    
}

extension DetailPindergartenController: DetailPindergartenHeaderCellDelegate {
    func didTapCallButton() {
        
        let number = Int(num.replacingOccurrences(of: "-", with: "") ) ?? 0
        print(number)
        if let url = NSURL(string: num.first == "0" ? "tel://0\(number)" : "tel://\(number)"),
           //canOpenURL(_:) 메소드를 통해서 URL 체계를 처리하는 데 앱을 사용할 수 있는지 여부를 확인
           UIApplication.shared.canOpenURL(url as URL) {

           //사용가능한 URLScheme이라면 open(_:options:completionHandler:) 메소드를 호출해서
           //만들어둔 URL 인스턴스를 열어줍니다.
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func didTapHeartButton() {
        pindergartenLikeDataManager.likePindergarten(pindergartenId: pindergartenID, delegate: self)
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
            if blogReviewResult?.count ?? 0 > 2 {
                return 2
            }
            return blogReviewResult?.count ?? 0
        }
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if blogReviewResult?.count ?? 0 == 0 {
            
            totalTableVeiw.tableFooterView = defaultFooter
        } else if blogReviewResult?.count ?? 0 < 3 {
            totalTableVeiw.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: Device.width, height: 20))
        }
        else {
            totalTableVeiw.tableFooterView = blogFooter
        }
        
        if indexPath == [0,0] {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPindergartenHeaderCell.identifier, for: indexPath) as! DetailPindergartenHeaderCell
            cell.selectionStyle = .none
            cell.delegate = self
            
            cell.nameLabel.text = detailResult?.name
            cell.pindergartenAddressLabel.text = detailResult?.address
//            let str = String(format: "%.2f", detailResult?.rating ?? 0)
            cell.scoreLabel.text = "\(Int(detailResult?.rating ?? 0))/5"
            cell.starView.rating = detailResult?.rating ?? 0
     
            if imageInput.count == 1 || imageInput.count == 0 {
                cell.labelBackView.isHidden = true
            } else {
                cell.labelBackView.isHidden = false
            }
            
            cell.imageSlide.setImageInputs(imageInput)
            if detailResult?.isLiked == 1 {
                cell.heartButton.setImage(UIImage(named: "detailFillHeart"), for: .normal)
            } else {
                cell.heartButton.setImage(UIImage(named: "detailHeart"), for: .normal)
            }
            return cell
        }
        
        if indexPath == [0,1] {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPindergartenInfoCell.identifier, for: indexPath) as! DetailPindergartenInfoCell
            cell.selectionStyle = .none
            cell.infoLabel.text = detailResult?.openingHours == "" ? "-" : detailResult?.openingHours
            
            return cell
        }
        
        if indexPath == [0,2] {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPindergartenInfoCell.identifier, for: indexPath) as! DetailPindergartenInfoCell
            cell.selectionStyle = .none
            cell.titleLabel.text = "이용안내"
            cell.infoLabel.text = detailResult?.accessGuide == "" ? "-" : detailResult?.accessGuide
            return cell
        }
        
        if indexPath == [0,3]  {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPindergartenBasicInfoCell.identifier, for: indexPath) as! DetailPindergartenBasicInfoCell
            cell.selectionStyle = .none
            cell.delegate = self

            cell.callInfoLabel.text = detailResult?.phone == "" ? "-" : detailResult?.phone
            num = cell.callInfoLabel.text?.replacingOccurrences(of: "-", with: "") ?? "0"
          
            cell.addressInfoLabel.text = detailResult?.address == "" ? "-" : detailResult?.address
            
           
            if detailResult?.website == "" {
                cell.homepageInfoLabel.text = "-"
            } else {
                cell.homepageInfoLabel.text = detailResult?.website
            }
            

            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPindergartenBlogReviewCell.identifier, for: indexPath) as! DetailPindergartenBlogReviewCell
            cell.selectionStyle = .none
            
            let title = blogReviewResult?[indexPath.item].title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "") ?? ""
            let content = blogReviewResult?[indexPath.item].content.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "") ?? ""
            cell.blogTitleLabel.text = title
            cell.contentLabel.text = content
            cell.dateLabel.text = blogReviewResult?[indexPath.item].date ?? ""

            return cell
        }
        else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            print(indexPath.item)
            
        }
        
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

// 네트워크 함수
extension DetailPindergartenController {
    
    func didSuccessGetDetailPindergarten(_ result: GetDetailPindergartenResult) {
        detailResult = result
        
        if result.imgUrls?.count == 0 {
            imageInput = [ImageSource(image: UIImage(named: "1")!)]
            
        } else {
            for image in result.imgUrls ?? [] {
                imageInput.append(AlamofireSource(urlString: "\(image.imageUrl)", placeholder: UIImage())!)
            }
        }
        
    }
    
    func failedToGetDetailPindergarten(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessGetBlogReviewPindergarten(_ result: [GetBlogReviewResult]) {
        blogReviewResult = result
        blogCountLabel.text = "\(String(describing: result.count - 2))개 블로그 리뷰 더보기"
    }
    
    func failedToGetBlogReviewPindergarten(message: String) {
        self.presentAlert(title: message)
    }
    
    func didSuccessLikePindergarten(_ result: PindergartenLikeResult) {
        print(result.isSet)
    }
    
    func failedToLikePindergarten(message: String) {
        self.presentAlert(title: message)
    }
}
