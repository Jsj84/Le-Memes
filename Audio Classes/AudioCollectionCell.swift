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
    
    var select: UIButton!
    var playButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        select = UIButton(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width / 0.70, height: self.bounds.size.height))
        select.setTitle("T1", for: .normal)
        select.backgroundColor = UIColor.red
        
        playButton = UIButton(frame: CGRect(x: select.bounds.maxX + 2, y: 0, width: (self.bounds.width - select.bounds.width) - 4, height: self.bounds.size.height))
        playButton.setTitle("T2", for: .normal)
        playButton.backgroundColor = UIColor.brown

        self.backgroundColor = UIColor.green
        self.layer.cornerRadius = 8
        contentView.addSubview(select)
        contentView.addSubview(playButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
