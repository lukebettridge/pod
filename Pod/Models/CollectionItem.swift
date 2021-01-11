//
//  CollectionItem.swift
//  Pod
//
//  Created by Luke Bettridge on 26/12/2020.
//

import UIKit
import CoreData

class CollectionItem: NSManagedObject, Identifiable {
    @NSManaged var createdAt: Date
    @NSManaged var favourite: Bool
    @NSManaged var notes: String
    @NSManaged var podId: String
    @NSManaged var quantity: Int
    
    func save () -> Void {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        try? managedObjectContext.save()
    }
}

extension CollectionItem {
    static func add(_ context: NSManagedObjectContext? = nil, podId: String) -> Void {
        let context = context ?? (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let collectionItem = NSEntityDescription.insertNewObject(forEntityName: "CollectionItem", into: context) as! CollectionItem
        collectionItem.createdAt = Date()
        collectionItem.podId = podId
        collectionItem.quantity = 1
        try? context.save()
    }
    
    static func exists(podId: String) -> Bool? {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<CollectionItem>(entityName: "CollectionItem")
        request.predicate = NSPredicate(format: "podId == %@", podId)
        return try? managedObjectContext.count(for: request) > 0
    }
    
    static func fetchRequest(sort: Dictionary<String, Bool> = ["createdAt": true]) -> NSFetchRequest<CollectionItem> {
        let request = NSFetchRequest<CollectionItem>(entityName: "CollectionItem")
        request.sortDescriptors = sort.map { NSSortDescriptor(key: $0.key, ascending: $0.value) }
        return request
    }
    
    static func fetchRequest(podId: String) -> NSFetchRequest<CollectionItem> {
        let request = NSFetchRequest<CollectionItem>(entityName: "CollectionItem")
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        request.predicate = NSPredicate(format: "podId == %@", podId)
        return request
    }
    
    static func remove(collectionItem: CollectionItem) -> Void {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(collectionItem)
        try? context.save()
    }
}
