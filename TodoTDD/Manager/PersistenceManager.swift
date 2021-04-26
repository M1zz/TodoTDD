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
    
//    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
//        retrieveFavorites { (result) in
//            switch result {
//            case .success(var favorites):
//
//                switch actionType {
//                case .add:
//                    guard !favorites.contains(favorite) else {
//                        completed(.alreadyInFavorites)
//                        return
//                    }
//
//                    favorites.append(favorite)
//                case .remove:
//                    favorites.removeAll { $0.login == favorite.login }
//                }
//
//            completed(save(favorites: favorites))
//
//            case .failure(let error):
//                completed(error)
//            }
//        }
//    }
//
    
    static func retrieveTodoItems(completed: @escaping (Result<[ToDoItem], TodoError>) -> Void) {
        guard let todoData = defaults.object(forKey: Keys.favorites) as? [ToDoItem] else {
            completed(.success([]))
            return
        }
        
        completed(.success(todoData))
        
//        do {
//            let decoder = JSONDecoder()
//            let favorites = try decoder.decode([Follower].self, from: favariteData)
//            completed(.success(favorites))
//        } catch {
//            completed(.failure(.unableToComplete))
//        }
    }
    
    
    static func save(items: [ToDoItem]) -> TodoError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(items)
            defaults.setValue(items, forKey: Keys.favorites)
            return nil
        } catch {
            return .uableToFavorite
        }
    }
}
