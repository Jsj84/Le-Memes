//
//  CollectionViewController.swift
//  Le Meme
//
//  Created by Jesse on 8/6/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController {
    
    var image:[UIImage] = [#imageLiteral(resourceName: "trump.png"),#imageLiteral(resourceName: "kimjung.png"),#imageLiteral(resourceName: "putin.png"),#imageLiteral(resourceName: "sheen.png")]
    let maincontroller = ViewController()
    let defaults = UserDefaults()
    let pictureConroller = PictureController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create custom button in navigation bar
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        btn.setTitle("Custom", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(self.loadCustomController), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        self.collectionView?.backgroundColor = UIColor.black
        
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    func loadCustomController() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let myVC = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! PictureController
        let myPics = UIAlertAction(title: "Saved Pics", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "myPics", sender: self)
        })
        let choosePic = UIAlertAction(title: "Choose Picture", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            myVC.typeOfPic = false
            self.navigationController?.pushViewController(myVC, animated: true)
        })
        
        let takePic = UIAlertAction(title: "Take Picture", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            myVC.typeOfPic = true
             self.navigationController?.pushViewController(myVC, animated: true)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
        })
        optionMenu.addAction(myPics)
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
        cell.imageView.image = image[indexPath.row]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let i = image[indexPath.row]
        let imageData:NSData = UIImagePNGRepresentation(i)! as NSData
        UserDefaults.standard.set(imageData, forKey: "image")
        performSegue(withIdentifier: "mainSegue2", sender: self)
    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
