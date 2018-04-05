//
//  AudioCollectionCell.swift
//  Le Meme
//
//  Created by Jesse on 8/7/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import Foundation
import UIKit

protocol AudioCollectionCellDelegate: class {
    func deleteButtonTapped(cell: AudioCollectionCell)
    func useButtonTapped(cell: AudioCollectionCell)
    func previewButtonTapped(cell: AudioCollectionCell)
}
class AudioCollectionCell: UICollectionViewCell {
    
    var delegate: AudioCollectionCellDelegate?
    var button: UIButton!
    var useButton: UIButton!
    var deleteButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5
        
        button = UIButton(frame: CGRect(x: 5, y: 5, width: self.bounds.width - 10, height: 50))
        button.setTitle("Preview", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        
        useButton = UIButton(frame: CGRect(x: 5, y: button.bounds.maxY + 10, width: self.bounds.width - 10, height: 50))
        useButton.setTitle("Use", for: .normal)
        useButton.backgroundColor = UIColor.green
        useButton.layer.borderWidth = 1
        useButton.layer.borderColor = UIColor.black.cgColor
        useButton.layer.cornerRadius = 5
        useButton.setTitleColor(UIColor.black, for: .normal)
        
        let imgage = #imageLiteral(resourceName: "delete")
        let scaledImage = imgage.resizedImageWithinRect(rectSize: CGSize(width: 20, height: 20))
        deleteButton = UIButton(frame: CGRect(x: 5, y: self.bounds.maxY - 40, width: self.bounds.width - 10, height: 35))
        deleteButton.layer.borderWidth = 2
        deleteButton.layer.borderColor = UIColor.red.cgColor
        deleteButton.setTitle(" Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.red, for: .normal)
        deleteButton.setImage(scaledImage, for: .normal)
        
        
        contentView.addSubview(deleteButton)
        contentView.addSubview(button)
        contentView.addSubview(useButton)
        
        self.deleteButton?.addTarget(self, action: #selector(self.deleteButtonTapped), for: UIControlEvents.touchUpInside)
        self.button?.addTarget(self, action: #selector(self.previewButtonTapped), for: UIControlEvents.touchUpInside)
        self.useButton?.addTarget(self, action: #selector(self.useButtonTapped), for: UIControlEvents.touchUpInside)
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    @objc func deleteButtonTapped(sender: UIButton) {
        self.delegate?.deleteButtonTapped(cell: self)
    }
    @objc func previewButtonTapped(sender: UIButton) {
        self.delegate?.previewButtonTapped(cell: self)
    }
    @objc func useButtonTapped(sender: UIButton) {
        self.delegate?.useButtonTapped(cell: self)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
