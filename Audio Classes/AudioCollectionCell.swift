//
//  AudioCollectionCell.swift
//  Le Meme
//
//  Created by Jesse on 8/7/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import Foundation
import UIKit

class AudioCollectionCell: UICollectionViewCell {
    
    var button: UIButton!
    var useButton: UIButton!
    var deleteButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        
        deleteButton = UIButton(frame: CGRect(x: self.bounds.maxX - 30, y: 5, width: 25, height: 25))
        deleteButton.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        
        button = UIButton(frame: CGRect(x: 5, y: 35, width: self.bounds.width - 10, height: 65))
        button.setTitle("Listen", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(UIColor.white, for: .normal)
        
        useButton = UIButton(frame: CGRect(x: 5, y: button.bounds.maxY + 40, width: self.bounds.width - 10, height: 35))
        useButton.setTitle("Use", for: .normal)
        useButton.backgroundColor = UIColor.green
        useButton.layer.borderWidth = 1
        useButton.layer.borderColor = UIColor.white.cgColor
        useButton.layer.cornerRadius = 5
        useButton.setTitleColor(UIColor.white, for: .normal)
        
        
        contentView.addSubview(deleteButton)
        contentView.addSubview(button)
        contentView.addSubview(useButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
