//
//  InputViewController.swift
//  TodoTDD
//
//  Created by 이현호 on 2020/07/01.
//  Copyright © 2020 tempYsoup. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    lazy var geocoder = CLGeocoder()
    var itemManager: ToDoItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        addressTextField.delegate = self
        descriptionTextField.delegate = self
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      view.endEditing(true)
    }
    
    
    @IBAction func TapCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tapOkButton(_ sender: Any) {
        guard let titleString = titleTextField.text,
          titleString.count > 0 else {
            return
        }
        
        var date: Date?
        if datePicker != nil {
            date = datePicker.date
        }
        
        var descriptionString: String?
        if descriptionTextField != nil {
            descriptionString = descriptionTextField.text
        }
        
        var placeMark: CLPlacemark?
        var addressName: String?

        if addressTextField != nil {
            addressName = addressTextField.text
            addressName = "경기도 용인시 수지구 도마치로89번길 16"
            if let addressName = addressName, addressName.count > 0 {
                
                geocoder.geocodeAddressString(addressName) { [weak self] placeMarks, _ in
                    placeMark = placeMarks?.first
                    
                    // TODO:- Add model
                    let item = ToDoItem(title: titleString,
                                        itemDescription: descriptionString,
                                        timeStamp: date?.timeIntervalSince1970,
                                        location: nil)
                    self?.itemManager?.add(item)
                    self?.dismiss(animated: true)
                    
//                    DispatchQueue.main.async {
//                      //self?.itemManager?.add(item)
//                      self?.dismiss(animated: true)
//                    }
                }
            }
        }
    }
}
