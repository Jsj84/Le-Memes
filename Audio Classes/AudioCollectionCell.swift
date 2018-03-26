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
        select.setImage(#imageLiteral(resourceName: "select"), for: .normal)
        select.contentEdgeInsets.top = 5
        select.contentEdgeInsets.bottom = 5
        select.contentEdgeInsets.left = 5
        select.contentEdgeInsets.right = 15
 
        
        playButton = UIButton(frame: CGRect(x: select.bounds.maxX + 2, y: 0, width: (self.bounds.width - select.bounds.width) - 4, height: self.bounds.size.height))
        playButton.setImage(#imageLiteral(resourceName: "playPic"), for: .normal)
        playButton.contentEdgeInsets.right = 5
        playButton.contentEdgeInsets.top = 5
        playButton.contentEdgeInsets.bottom = 5

        
        self.backgroundColor = UIColor.black
        contentView.addSubview(select)
        contentView.addSubview(playButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
