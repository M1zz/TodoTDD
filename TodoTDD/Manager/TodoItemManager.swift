//
//  TodoItemManager.swift
//  TodoTDD
//
//  Created by 이현호 on 2021/03/11.
//  Copyright © 2021 tempYsoup. All rights reserved.
//

import UIKit

class ToDoItemManager {
    
    static let shared = ToDoItemManager()
    
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    
    private var toDoItems = [ToDoItem]()
    private var doneItems = [ToDoItem]()
    
    // plist related
    var toDoPathURL: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let documentURL = fileURLs.first else {
            fatalError("Something went wrong. Documents url could not be found")
        }
        
        return documentURL.appendingPathComponent("toDoItems.plist")
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.willResignActiveNotification, object: nil)
        
        if let nsToDoItems = NSArray(contentsOf: toDoPathURL) {
            for dict in nsToDoItems {
                if let toDoItem = ToDoItem(dict: dict as! [String:Any]) {
                    toDoItems.append(toDoItem)
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        save()
    }
    
    @objc func save() {
        let nsToDoItems = toDoItems.map { $0.plistDict }
        
        guard nsToDoItems.count > 0 else {
            try? FileManager.default.removeItem(at: toDoPathURL)
            return
        }
        
        do {
            let plistData = try PropertyListSerialization.data(
                fromPropertyList: nsToDoItems,
                format: PropertyListSerialization.PropertyListFormat.xml,
                options: PropertyListSerialization.WriteOptions(0)
            )
            try plistData.write(to: toDoPathURL,
                                options: Data.WritingOptions.atomic)
        } catch {
            print(error)
        }
    }
    
    
    func add(_ item: ToDoItem) {
        toDoItems.append(item)
    }
    
    func item(at index: Int?) -> ToDoItem? {
        if let index = index {
            return toDoItems[index]
        }
        return nil
    }
    
    func doneItem(at index: Int) -> ToDoItem {
        return doneItems[index]
    }
    
    func checkItem(at index: Int) {
        let checkedItem = toDoItems.remove(at: index)
        doneItems.append(checkedItem)
    }
    
    func uncheckItem(at index: Int) {
        let uncheckedItem = doneItems.remove(at: index)
        toDoItems.append(uncheckedItem)
    }
    
    func removeAll() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
}
