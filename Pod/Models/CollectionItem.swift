//
//  CollectionItem.swift
//  Pod
//
//  Created by Luke Bettridge on 26/12/2020.
//

import UIKit
import CoreData

class CollectionItem: NSManagedObject, Identifiable {
    @NSManaged var podId: String
    @NSManaged var createdAt: Date
    @NSManaged var favourite: Bool
    @NSManaged var quantity: Int
    
    func save () -> Void {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        try? managedObjectContext.save()
    }
}

extension CollectionItem {
    static func add(podId: String) -> Void {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let collectionItem = NSEntityDescription.insertNewObject(forEntityName: "CollectionItem", into: managedObjectContext) as! CollectionItem
        collectionItem.podId = podId
        collectionItem.createdAt = Date()
        try? managedObjectContext.save()
    }
    
    static func exists(podId: String) -> Bool? {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<CollectionItem>(entityName: "CollectionItem")
        request.predicate = NSPredicate(format: "podId == %@", podId)
        return try? managedObjectContext.count(for: request) > 0
    }
    
    static func fetchRequest() -> NSFetchRequest<CollectionItem> {
        let request = NSFetchRequest<CollectionItem>(entityName: "CollectionItem")
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        return request
    }
    
    static func fetchRequest(podId: String) -> NSFetchRequest<CollectionItem> {
        let request = NSFetchRequest<CollectionItem>(entityName: "CollectionItem")
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        request.predicate = NSPredicate(format: "podId == %@", podId)
        return request
    }
    
    static func remove(collectionItem: CollectionItem) -> Void {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        managedObjectContext.delete(collectionItem)
        try? managedObjectContext.save()
    }
}
