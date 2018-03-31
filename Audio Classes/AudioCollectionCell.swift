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
    
       var button = UIButton()
       var lable = UILabel()
    let colectView = AudioCollectionViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
          self.backgroundColor = UIColor.black
        
      lable = UILabel(frame: CGRect(x: 5, y: 5, width: self.bounds.width - 5, height: 20))
        lable.textColor = UIColor.white
        
        button = UIButton(frame: CGRect(x: 5, y: 30, width: self.bounds.width - 10, height: (self.bounds.height / 1) - 35))
        button.setTitle("Listen", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(UIColor.white, for: .normal)
        
        
       contentView.addSubview(lable)
        contentView.addSubview(button)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
