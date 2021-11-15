//
//  ContentViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/12.
//

import UIKit

class ContentViewController: BaseViewController {
    
    //MARK: - Properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PindergartenCell.self, forCellReuseIdentifier: PindergartenCell.identifier)
        configureUI()
    }
    
    //MARK: - Action
    
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}


//MARK: - Extension
extension ContentViewController: PindergartenCellDelegate {
    func didTapCellHeartButton(index: Int) {
        print("DEBUG: TAPPED HEART BUTTON")
    }
    
    
}

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PindergartenCell.identifier, for: indexPath) as! PindergartenCell
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailPindergartenController()
        navigationController?.pushViewController(detailVC, animated: true)
        print(indexPath.item)
    }
}
