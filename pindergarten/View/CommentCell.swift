//
//  CommentCell.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/03.
//

import UIKit

class CommentCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "CommentCell"
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    
    //MARK: - Helpers
}
