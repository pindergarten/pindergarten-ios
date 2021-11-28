//
//  BlogReviewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/15.
//

import UIKit


class BlogReviewController: BaseViewController {
    deinit {
            print("deinit")
    }
    //MARK: - Properties
    var review: [GetBlogReviewResult]?
    
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
        label.text = "블로그 리뷰"
        label.textColor = .mainTextColor
        return label
    }()

    private let seperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private let reviewTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetup()
        configureUI()
    }
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Helpers
    private func tableViewSetup() {
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(DetailPindergartenBlogReviewCell.self, forCellReuseIdentifier: DetailPindergartenBlogReviewCell.identifier)
    }
    
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(seperateLine)
        view.addSubview(reviewTableView)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalTo(view)
        }

        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        reviewTableView.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
}


extension BlogReviewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return review?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailPindergartenBlogReviewCell.identifier, for: indexPath) as! DetailPindergartenBlogReviewCell
        cell.selectionStyle = .none
        
        let blog = review?[indexPath.item]
        cell.blogTitleLabel.text = blog?.title?.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "") ?? ""
        cell.contentLabel.text = blog?.content?.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "") ?? ""
        cell.dateLabel.text = blog?.date
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webView = BlogWebViewController()
        
        webView.blogUrl = review?[indexPath.item].link ?? ""
        navigationController?.pushViewController(webView, animated: true)
    }
}
