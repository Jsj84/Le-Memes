//
//  CollectionViewCell.swift
//  Le Meme
//
//  Created by Jesse on 8/6/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(imageView)
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
