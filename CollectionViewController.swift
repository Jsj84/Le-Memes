//
//  CollectionViewController.swift
//  Le Meme
//
//  Created by Jesse on 8/6/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import UIKit
import Foundation
private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    
    var image:[UIImage] = [#imageLiteral(resourceName: "trump.png"),#imageLiteral(resourceName: "kimjung.png"),#imageLiteral(resourceName: "putin.png"),#imageLiteral(resourceName: "sheen.png")]
    let maincontroller = ViewController()
    let defaults = UserDefaults()
    let pictureConroller = PictureController()
    let imagePicker = UIImagePickerController()
    let managedObject = ManagedObject()
    var img:UIImage? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.value(forKey: "loadedPicstures") == nil {
            for i in 0..<image.count{
                if let tempImage = UIImageJPEGRepresentation(image[i], 100){
                    managedObject.save(face: tempImage)
                }
            }
            defaults.set(true, forKey: "loadedPicstures")
        }
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        self.collectionView?.addGestureRecognizer(lpgr)
        
        // set delegate so changes are recognized
        self.imagePicker.delegate = self 
        self.imagePicker.allowsEditing = true
        
        // programatically crate a bar buttom item...... Because I'm fucking lazy!
        let camera = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(self.loadCustomController))
        self.navigationItem.rightBarButtonItem = camera
        self.collectionView?.backgroundColor = UIColor.black
        
        // Register cell classes
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        managedObject.getFaces()
    }
    @objc func loadCustomController() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let choosePic = UIAlertAction(title: "Choose Picture", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            
        })
        
        let takePic = UIAlertAction(title: "Take Picture", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
        })
        optionMenu.addAction(takePic)
        optionMenu.addAction(choosePic)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        managedObject.getFaces()
        return managedObject.faces.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.imageView.contentMode = .scaleToFill
        cell.imageView.clipsToBounds = true
        cell.imageView.image = UIImage(data: managedObject.faces[indexPath.row].value(forKey: "imageData") as! Data)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let i = indexPath.item
        let imageData = managedObject.faces[i].value(forKey: "imageData") as! Data
        defaults.set(imageData, forKey: "image")
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state != UIGestureRecognizerState.ended { return }
        let p = gestureRecognizer.location(in: collectionView)
        
        if let index = self.collectionView?.indexPathForItem(at: p) {
            collectionView?.cellForItem(at: index)?.isSelected = true
            
            collectionView?.cellForItem(at: index)?.layer.borderColor = UIColor.red.cgColor
            collectionView?.cellForItem(at: index)?.layer.borderWidth = 2
            // Create the alert controller
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Delete", style: .destructive) {
                UIAlertAction in
                let newIndex = index.item
                self.managedObject.deleteFace(index: newIndex)
                self.collectionView?.deleteItems(at: [index])
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
                UIAlertAction in
                self.collectionView?.cellForItem(at: index)?.layer.borderColor = UIColor.clear.cgColor
               self.collectionView?.cellForItem(at: index)?.layer.borderWidth = 0
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
          self.img = pickedImage
        }
        performSegue(withIdentifier: "fotoController", sender: self)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fotoController" {
            let destination = segue.destination as! PictureController
            destination.tempImage = img!
        }
    }
}
