//
//  LogItem.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import UIKit
import CoreData

class LogItem: NSManagedObject, Identifiable {
    @NSManaged var createdAt: Date
    @NSManaged var cup: String
    @NSManaged var loggedToHealth: Bool
    @NSManaged var podId: String
    
    func save () -> Void {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        try? managedObjectContext.save()
    }
}

extension LogItem {
    static func add(_ context: NSManagedObjectContext? = nil, podId: String, cup: String, loggedToHealth: Bool = false) -> Void {
        let context = context ?? (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let logItem = NSEntityDescription.insertNewObject(forEntityName: "LogItem", into: context) as! LogItem
        logItem.createdAt = Date()
        logItem.cup = cup
        logItem.loggedToHealth = loggedToHealth
        logItem.podId = podId
        try? context.save()
    }
    
    static func fetchRequest(sort: Dictionary<String, Bool> = ["createdAt": false]) -> NSFetchRequest<LogItem> {
        let request = NSFetchRequest<LogItem>(entityName: "LogItem")
        request.sortDescriptors = sort.map { NSSortDescriptor(key: $0.key, ascending: $0.value) }
        return request
    }
}
