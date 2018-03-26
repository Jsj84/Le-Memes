//
//  ManagedObject.swift
//  Le Meme
//
//  Created by Jesse on 8/6/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ManagedObject: NSObject {
    
    var faces:[NSManagedObject] = []

    func save(face: NSData) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Faces", in: getContext ())!
        let object = NSManagedObject(entity: entity, insertInto: getContext ())
        
        object.setValue(face, forKeyPath: "imageData")
        
        do {
            try getContext ().save()
            faces.append(object)
            print("your query has been saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func getFaces() {
     
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Faces")
        
        do {
            faces = try getContext ().fetch(fetchRequest)
    
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    func deleteFace(index: Int) {

       getContext().delete(faces[index])
        do {
            try getContext().save()
            faces.remove(at: index)
        }
        catch{print(" Sorry Jesse, had and error deleting. The error is: \(error)")}
    }
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
