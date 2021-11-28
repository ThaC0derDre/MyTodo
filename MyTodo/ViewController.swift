//
//  ViewController.swift
//  MyTodo
//
//  Created by Andres Gutierrez on 11/27/21.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    let items = Items()
    let realm = try! Realm()
  
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
                             
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Item"
        }
        alert.addAction(action)
       
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}

