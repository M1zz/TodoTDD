//
//  TodoItemCell.swift
//  TodoTDD
//
//  Created by 이현호 on 2021/03/12.
//  Copyright © 2021 tempYsoup. All rights reserved.
//

import UIKit

class TodoItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var destcriptionLabel: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(index: Int) {
        let item = ToDoItemManager.shared.item(at: index)
        titleLabel.text = item?.title
        destcriptionLabel.text = item?.itemDescription
        doneLabel.text = item?.title
    }
}
