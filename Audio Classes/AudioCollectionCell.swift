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
    
//    var select: UIButton!
//    var playButton: UIButton!
       var lable = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      lable = UILabel(frame: CGRect(x: 5, y: 5, width: self.bounds.width - 10, height: self.bounds.height / 2))
        self.backgroundColor = UIColor.blue
        lable.text = "Test"
        lable.textColor = UIColor.red
       contentView.addSubview(lable)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
