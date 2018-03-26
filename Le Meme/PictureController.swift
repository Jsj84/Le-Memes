//
//  PictureController.swift
//  Le Meme
//
//  Created by Jesse on 8/6/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PictureController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var managedObject = ManagedObject()
    var tempImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // handle views and styles
        self.view.backgroundColor = UIColor.black
        
        // Bring view to front
        self.view.bringSubview(toFront: imageView)
        
    }
    @objc func cancelAct() {
        navigationController?.popToRootViewController(animated: true)
    }
    @objc func saveAct() {
        let imageData:NSData = UIImageJPEGRepresentation(imageView.image!, 100)! as NSData
        UserDefaults.standard.set(imageData, forKey: "image")
        managedObject.save(face: imageData)
        navigationController?.popToRootViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.imageView.image = tempImage
    }
    
}
