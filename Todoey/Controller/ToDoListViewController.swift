//
//  ViewController.swift
//  Todoey
//
//  Created by Maxim on 6/15/18.
//  Copyright © 2018 Oldmen. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
    var itemArray : [ToDoModel] = []
    let keyArray = "ItemsArray"
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: keyArray) as? [ToDoModel]{
            itemArray = items
        }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc func appMovedToBackground() {
        print("App moved to Background!")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item:ToDoModel = itemArray[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType = item.isChecked ? .checkmark : .none
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(itemArray[indexPath.row])
        //        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        let cellAccessory = tableView.cellForRow(at: indexPath)?.accessoryType
        
        if cellAccessory == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            itemArray[indexPath.row].isChecked = false
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            itemArray[indexPath.row].isChecked = true
        }
        defaults.set(itemArray, forKey: keyArray)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField();
        let alert = UIAlertController(title: "Add new ToDo", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if(!(textField.text?.isEmpty)!){
                let toDo = ToDoModel(name: textField.text!, isChecked: false)
//                toDo.name =
                self.itemArray.append(toDo)
                self.tableView.reloadData()
//                self.defaults.set(self.itemArray, forKey: self.keyArray)
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter ToDo Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

