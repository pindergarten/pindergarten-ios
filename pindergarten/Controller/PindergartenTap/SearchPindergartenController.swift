//
//  SearchPindergartenController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/14.
//

import UIKit

class SearchPindergartenController: BaseViewController {
    //MARK: - Properties
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private let searchTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.attributedPlaceholder = NSAttributedString(string: "검색하실 내용을 입력해주세요.", attributes: [.foregroundColor:UIColor(hex: 0xC1C1C1), .font:UIFont(name: "AppleSDGothicNeo-Regular", size: 16)!])
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    private lazy var xButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "searchCancel"), for: .normal)
        button.addTarget(self, action: #selector(didTapXButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    private let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(hex: 0xF3F4F6)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldDidChange(_ sender: Any?) {
        if searchTextField.text?.count ?? 0 > 0 {
            xButton.isHidden = false
        } else {
            xButton.isHidden = true
        }
    }
    
    @objc private func didTapXButton() {
        searchTextField.text = ""
        xButton.isHidden = true
    }
    //MARK: - Helpers
    private func setUpTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchPindergartenCell.self, forCellReuseIdentifier: SearchPindergartenCell.identifier)
    }
    
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(searchTextField)
        view.addSubview(xButton)
        view.addSubview(separateLine)
        view.addSubview(searchTableView)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.left.equalTo(backButton.snp.right).offset(20)
            make.right.equalTo(view).offset(-47)
        }
        
        xButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchTextField)
            make.right.equalTo(view).offset(-20)
            make.width.height.equalTo(22)
        }
        
        separateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }

        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
}


extension SearchPindergartenController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchPindergartenCell.identifier, for: indexPath) as! SearchPindergartenCell
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
