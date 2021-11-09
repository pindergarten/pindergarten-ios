////
////  EventHeaderView.swift
////  pindergarten
////
////  Created by MIN SEONG KIM on 2021/11/10.
////
//
//import UIKit
//
//class EventImageCell: UITableViewCell {
//    static let identifier = "EventImageCell"
//
//
//}
//
//class EventHeaderView: UIView {
//    //MARK: - Properties
//
//    let eventNameLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
//        label.numberOfLines = 0
//        label.textColor = .mainTextColor
//        label.text = "이벤트 제목"
//        return label
//    }()
//
//    let eventImage: UIImageView = {
//        let image = UIImageView()
//        image.image = #imageLiteral(resourceName: "2")
//        image.contentMode = .scaleToFill
//        image.layer.cornerRadius = 10
//        image.clipsToBounds = true
//        return image
//    }()
//
//    private let eventImageTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .white
//        tableView.separatorStyle = .none
//        return tableView
//    }()
//
//    private let dDayView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.alpha = 0.95
//        view.layer.applyShadow(color: .black, alpha: 0.4, x: 1, y: 3, blur: 7)
//        view.clipsToBounds = true
//        view.layer.masksToBounds = false
//        view.layer.cornerRadius = 25
//        return view
//    }()
//
//    let dDayLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
//        label.textColor = UIColor(hex: 0x3D3D3D)
//        label.text = "D-23"
//        return label
//    }()
//
//    lazy var heartButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "feedHeartImage"), for: .normal)
//        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
//        return button
//    }()
//
//    let heartLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
//        label.textColor = UIColor(hex: 0x858585)
//        label.text = "294"
//        return label
//    }()
//
//    private lazy var commentButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "commentImage"), for: .normal)
//        button.addTarget(self, action: #selector(goToCommentVC), for: .touchUpInside)
//        return button
//    }()
//
//    let commentLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
//        label.textColor = UIColor(hex: 0x858585)
//        label.text = "294"
//        return label
//    }()
//    //MARK: - Lifecycle
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
