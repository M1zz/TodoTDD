//
//  ItemListViewController.swift
//  TodoTDD
//
//  Created by 이현호 on 2020/07/01.
//  Copyright © 2020 tempYsoup. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        guard let inputViewController = storyboard?.instantiateViewController(withIdentifier: "InputViewController") as? InputViewController else {
          return
        }
        //inputViewController.itemManager = dataProvider.itemManager
        print("hey")
        present(inputViewController, animated: true, completion: nil)
    }
}

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoItemManager.shared.doneCount + ToDoItemManager.shared.toDoCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! TodoItemCell
        cell.set(index: indexPath.row)
        
        return cell
    }
    
    
}
