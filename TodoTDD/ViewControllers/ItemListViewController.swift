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
