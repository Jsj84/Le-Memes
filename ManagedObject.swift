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
    var voices:[NSManagedObject] = []

    func save(face: Data) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Faces", in: getContext ())!
        let object = NSManagedObject(entity: entity, insertInto: getContext ())
        
        object.setValue(face, forKey: "imageData")
        
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
    func saveVoice(voice: Data, index: Int) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Voices", in: getContext ())!
        let object = NSManagedObject(entity: entity, insertInto: getContext())
        
        object.setValue(voice, forKey: "voiceRecording")
        object.setValue(index, forKey: "id")
        do {
            try getContext ().save()
            voices.append(object)
            print("your query has been saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func getVoices() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Voices")
        
        do {
            voices = try getContext ().fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    func deleteVoice(index: Int) {
        getContext().delete(voices[index])
        do {
            try getContext().save()
            self.voices.remove(at: index)
       }
    catch{print(" Sorry Jesse, had and error deleting. The error is: \(error)")}
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
