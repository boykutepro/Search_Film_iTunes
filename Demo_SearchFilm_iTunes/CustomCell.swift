//
//  CustomCell.swift
//  Demo_SearchFilm_iTunes
//
//  Created by Thien Tung on 5/26/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import UIKit
import Kingfisher

class CustomCell: UICollectionViewCell {
    // khởi tạo containerView
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    // khởi tạo imageView
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "")
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let labelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    // khởi tạo title
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 2
        label.textColor = .red
        label.backgroundColor = .lightGray
//        label.backgroundColor = .green
        return label
    }()
    
    var item: Itune?{
        // câu lệnh bên trong didSet chỉ được gọi khi biến food đã được gán giá trị
        didSet{
            if let item = item {
                photoImageView.kf.setImage(with: URL(string: item.imageURL ?? ""))
                titleLabel.text = item.filmName
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
    }
    
    func setupLayout(){
        
        self.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        containerView.addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: -30).isActive = true
        
        containerView.addSubview(labelView)
        labelView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0).isActive = true
        labelView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        labelView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        labelView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        
        labelView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: labelView.leftAnchor, constant: 0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: labelView.rightAnchor, constant: 0).isActive = true
        let bottomAnchor = titleLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 8)
        bottomAnchor.priority = UILayoutPriority(rawValue: 250)
        bottomAnchor.isActive = true
        let heightConstraint = titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 200)
        heightConstraint.isActive = true
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

