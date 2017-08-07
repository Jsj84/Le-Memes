//
//  CollectionViewController.swift
//  Le Meme
//
//  Created by Jesse on 8/6/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import UIKit
import CoreData
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
        self.managedObject.getFaces()
        return managedObject.faces.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MycollectionCell
        managedObject.getFaces()
        let data = managedObject.faces[indexPath.row].value(forKey: "imageData") as! Data
        cell.imageView.image = UIImage(data: data)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        managedObject.getFaces()
        //let appDelegate = AppDelegate()
        let managedContext = managedObject.getContext()
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let use = UIAlertAction(title: "Use", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            let i = self.managedObject.faces[indexPath.row].value(forKey: "imageData") as! Data
            UserDefaults.standard.set(i, forKey: "image")
            self.performSegue(withIdentifier: "showMyPicSegue", sender: self)
        })
        let delete = UIAlertAction(title: "Delete", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            managedContext.delete(self.managedObject.faces[indexPath.row] as NSManagedObject)
            do {
                try managedContext.save()
            }
            catch{print(" Sorry Jesse, had and error saving. The error is: \(error)")}
            collectionView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            optionMenu.dismiss(animated: true, completion: nil)
        })
        optionMenu.addAction(use)
        optionMenu.addAction(delete)
        optionMenu.addAction(cancel)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
