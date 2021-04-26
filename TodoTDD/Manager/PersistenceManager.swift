//
//  PersistenceManager.swift
//  TodoTDD
//
//  Created by 이현호 on 2021/03/13.
//  Copyright © 2021 tempYsoup. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "todoList"
    }
    
    static func retrieveTodoItems(completed: @escaping (Result<[ToDoItem], TodoError>) -> Void) {
        guard let todoData = defaults.object(forKey: Keys.favorites) as? [ToDoItem] else {
            completed(.success([]))
            return
        }
        completed(.success(todoData))
    }
    
    
    static func save(items: [ToDoItem]) -> TodoError? {
        do {
            let encoder = JSONEncoder()
            _ = try encoder.encode(items)
            defaults.setValue(items, forKey: Keys.favorites)
            return nil
        } catch {
            return .uableToFavorite
        }
    }
}
