//
//  InputViewController.swift
//  TodoTDD
//
//  Created by 이현호 on 2020/07/01.
//  Copyright © 2020 tempYsoup. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancel() {
      dismiss(animated: true, completion: nil)
    }
}
