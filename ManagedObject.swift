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
    
    var context: NSManagedObjectContext
    
    var faces: [NSManagedObject] = []
    var face:[UIImage] = []
    
    override init() {
        
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = Bundle.main.url(forResource: "Model", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let myfatalError = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: myfatalError)
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
        
        DispatchQueue.global(qos: .background).async {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docURL = urls[urls.endIndex - 1]
            let storURL = docURL.appendingPathComponent("Model.sqlite")
            
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    func save(face: NSData) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Faces", in: managedContext)!
        
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        
        object.setValue(face, forKeyPath: "imageData")
        
        do {
            try managedContext.save()
            faces.append(object)
            
            print("your query has been saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func getFaces() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Faces")
        
        do {
            faces = try managedContext.fetch(fetchRequest)
    
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }

}
