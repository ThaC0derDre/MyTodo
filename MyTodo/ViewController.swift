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
  //Pulling From Realm
    var toDoItems: Results<Items>?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - TableView DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        if let items = toDoItems?[indexPath.row]{
            cell.textLabel?.text = items.title
            cell.accessoryType = items.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = "Nothing added yet"
        }
        return cell
    }
   
    //MARK: - TableView Delgate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
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

