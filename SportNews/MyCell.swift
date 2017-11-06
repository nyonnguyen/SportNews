//
//  MyCell.swift
//  SportNews
//
//  Created by Nyon Nguyen on 11/3/17.
//  Copyright © 2017 Nyon Nguyen. All rights reserved.
//

import UIKit

class MyCell: UICollectionViewCell {
    
    var avatar: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let cellView: UIView = {
        let view  = UIView()
        //view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(white: 0, alpha: 0.7)
        text.font = UIFont.boldSystemFont(ofSize: 23)
        //text.backgroundColor = UIColor.gray
        text.text = "Player Name"
        text.numberOfLines = 2
        text.lineBreakMode = .byTruncatingTail
        text.baselineAdjustment = .alignBaselines
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let numberLabel: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(white: 0, alpha: 0.3)
        text.font = UIFont.boldSystemFont(ofSize: 72)
        //text.backgroundColor = UIColor.gray
        text.text = "0"
        text.numberOfLines = 1
        text.baselineAdjustment = .alignBaselines
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        cellView.addSubview(nameLabel)
        cellView.addSubview(numberLabel)
        cellView.addSubview(avatar)
        cellView.frame = self.frame
        self.addSubview(cellView)
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cellView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cellView]))
        
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v1(tw)]-[v0(aw)]-0-|", options: NSLayoutFormatOptions(), metrics: ["aw": self.frame.width * 0.75, "tw": self.frame.width * 0.4], views: ["v0": avatar, "v1": nameLabel]))
        
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(h)]|", options: NSLayoutFormatOptions(), metrics: ["h": self.frame.height], views: ["v0": avatar]))
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(th)]-0-[v1(th)]-rh-|", options: NSLayoutFormatOptions(), metrics: ["th": self.frame.height * 0.35, "rh": self.frame.height * 0.3], views: ["v0": nameLabel, "v1": numberLabel]))
        
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v1(tw)]-[v0(aw)]-0-|", options: NSLayoutFormatOptions(), metrics: ["aw": self.frame.width * 0.75, "tw": self.frame.width * 0.4], views: ["v0": avatar, "v1": numberLabel]))
    }
    
}
