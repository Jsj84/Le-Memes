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
    var img = UIImage()
    let managedObject = ManagedObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
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
        for i in 0..<managedObject.faces.count {
            let data = self.managedObject.faces[i].value(forKey: "imageData") as! Data
            image.append(UIImage(data: data)!)
        }
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
        return image.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.imageView.contentMode = .scaleToFill
        cell.imageView.clipsToBounds = true
        cell.imageView.image = image[indexPath.row]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let i = image[indexPath.item]
        let imageData:NSData = UIImagePNGRepresentation(i)! as NSData
        UserDefaults.standard.set(imageData, forKey: "image")
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer) {

        if (gestureRecognizer.state != UIGestureRecognizerState.ended){
            return
        }
        let p = gestureRecognizer.location(in: collectionView)
        
        if let index = self.collectionView?.indexPathForItem(at: p) {
         collectionView?.cellForItem(at: index)?.isSelected = true
            print(index)
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
            destination.tempImage = img
        }
    }
}
