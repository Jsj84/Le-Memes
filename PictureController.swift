//
//  PictureController.swift
//  Le Meme
//
//  Created by Jesse on 8/6/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import Foundation
import UIKit


class PictureController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var managedObject = ManagedObject()
    var tempImage = UIImage()
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.layer.cornerRadius = imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 2
        self.imageView.layer.borderColor = UIColor.black.cgColor
        
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.isNavigationBarHidden = false
        
        let cancel = UIButton()
        cancel.setTitle("Cancel", for: .normal)
        cancel.setTitleColor(UIColor.red, for: .normal)
        cancel.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        cancel.addTarget(self, action: #selector(cancelAct), for: .touchUpInside)
        let item1 = UIBarButtonItem()
        item1.customView = cancel
        
        let save = UIButton()
        save.setTitle("Save", for: .normal)
        save.setTitleColor(UIColor.blue, for: .normal)
        save.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        save.addTarget(self, action: #selector(saveAct), for: .touchUpInside)
        let item2 = UIBarButtonItem()
        item2.customView = save
        
        self.navigationItem.rightBarButtonItems = [item2, item1]
        self.view.backgroundColor = UIColor.black
        
    }
    @objc func cancelAct() {
        navigationController?.popToRootViewController(animated: true)
    }
    @objc func saveAct() {
        let imageData:NSData = UIImageJPEGRepresentation(imageView.image!, 100)! as NSData
        defaults.set(imageData, forKey: "image")
        managedObject.save(face: imageData)
        navigationController?.popToRootViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.imageView.image = tempImage.resizedImageWithinRect(rectSize: CGSize(width: tempImage.size.width, height: tempImage.size.width))
    }
}
extension UIImage {
    func resizedImage(newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func resizedImageWithinRect(rectSize: CGSize) -> UIImage {
        let widthFactor = size.width / rectSize.width
        let heightFactor = size.height / rectSize.height
        
        var resizeFactor = widthFactor
        if size.height > size.width {
            resizeFactor = heightFactor
        }
        
        let newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
        let resized = resizedImage(newSize: newSize)
        return resized
    }
}
