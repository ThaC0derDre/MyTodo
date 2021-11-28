//
//  ViewController.swift
//  MyTodo
//
//  Created by Andres Gutierrez on 11/27/21.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    let realm = try! Realm()
  
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
           let newItem = Items()
            newItem.title = textField.text!
            do{
                try self.realm.write(){
                    self.realm.add(newItem)
                }
            }catch {
                print("Error adding new Item")
            }
            
        }
      
        
        alert.addAction(action)
       
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}

