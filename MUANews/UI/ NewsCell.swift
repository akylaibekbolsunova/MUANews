//
//   NewsCell.swift
//  MUANews
//
//  Created by Акылай Бекболсунова on 22.04.2022.
//

import Foundation
import UIKit
import Kingfisher

class NewsCell: UITableViewCell {
    
    private lazy var newsImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        view.numberOfLines = 2
        view.text = ""
        view.textAlignment = .left
        return view
    }()
    
    private lazy var date: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        view.textColor = .black
        view.text = "13.05.2002"
        view.textAlignment = .left
        return view
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    override func layoutSubviews() {
        addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(newsImage.snp.height)
        }
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.left.equalTo(newsImage.snp.right).offset(10)
        }
        
        addSubview(date)
        date.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-10)
            make.left.equalTo(newsImage.snp.right).offset(10)
        }
        
        addSubview(separator)
        separator.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func fill(model: NewsModel) {
        date.text = model.date
        title.text = model.title
        
        print("http://alatoo.edu.kg\(model.image[10..<(model.image.count - 2)])")
        
        newsImage.kf.setImage(with: URL(string: "http://alatoo.edu.kg\(model.image[10..<(model.image.count - 2)])"))
    }
}
