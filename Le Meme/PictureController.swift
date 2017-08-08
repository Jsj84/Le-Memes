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

class PictureController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // create class variables and constants
    var typeOfPic = Bool()
    let imagePicker = UIImagePickerController()
    var managedObject = ManagedObject()
    
    @IBAction func saveAction(_ sender: Any) {
        let i = imageView.image
        let imageData:NSData = UIImagePNGRepresentation(i!)! as NSData
        UserDefaults.standard.set(imageData, forKey: "image")
        managedObject.save(face: imageData)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // handle views and styles
        self.view.backgroundColor = UIColor.black
        self.cancelButton.backgroundColor = UIColor.green
        self.cancelButton.layer.cornerRadius = 10
        self.cancelButton.setTitleColor(UIColor.red, for: .normal)
        self.saveButton.backgroundColor = UIColor.green
        self.saveButton.layer.cornerRadius = 10
        
        // Bring view to front
        self.view.bringSubview(toFront: imageView)
        
        // set delegate so changes are recognized
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        switch typeOfPic {
        case true:
            self.imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        default:
            self.imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
