//
//  DataController.swift
//  Bookworm
//
//  Created by Berardino Chiarello on 21/05/23.
//
import CoreData
import Foundation

class DataController: ObservableObject {
    //NSPersistentContainer is the Core Data type responsible for loading a data model and giving us access to the data inside. That tells Core Data we want to use the Bookworm data model. It doesn’t actually load it
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        //load the data 
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
        }
    }
    
}
