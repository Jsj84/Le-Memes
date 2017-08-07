//
//  CollectionViewController.swift
//  Le Meme
//
//  Created by Jesse on 8/6/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell2"

class MyPicViewController: UICollectionViewController {
    
    let managedObject = ManagedObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.collectionView?.backgroundColor = UIColor.black
        
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(MycollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return managedObject.faces.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MycollectionCell
        managedObject.getFaces()
        cell.backgroundColor = UIColor.blue
        let data = managedObject.value(forKey: "imageData")
        cell.imageView.image = UIImage(data: data as! Data)
        return cell
    }
    //    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let i = image[indexPath.row]
    //        let imageData:NSData = UIImagePNGRepresentation(i)! as NSData
    //        UserDefaults.standard.set(imageData, forKey: "image")
    //        performSegue(withIdentifier: "mainSegue2", sender: self)
    //    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
