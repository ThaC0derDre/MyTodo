//
//  ViewController.swift
//  MyTodo
//
//  Created by Andres Gutierrez on 11/27/21.
//

import UIKit
import RealmSwift

class ItemsViewController: SwipeToDelete {
    
    let realm = try! Realm()
  //Pulling From Realm
    var toDoItems: Results<Items>?
 
    var selectedCategory: Category? {
    didSet{
        load()
    }
    }
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
    
    private func handleMoveToTrash() {
        print("Moved to Trash")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let items = toDoItems?[indexPath.row]{
            do{
                try realm.write{
                    items.done = !items.done
                }
                }catch{
                    print("Error toggling checkmark")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)

    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .destructive,
                                       title: "Trash") { [weak self] (action, view, completionHandler) in
            self?.handleMoveToTrash()
            completionHandler(true)
            let result = self?.delete(at: indexPath) ?? false
            completionHandler(result)
        }
        trash.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [trash])

        return configuration
    }
    //MARK: - IBA

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            if let currentCategory = self.selectedCategory{
            do{
                try self.realm.write{
                    let newItem = Items()
                     newItem.title = textField.text!
                    currentCategory.items.append(newItem)
                }
            }catch {
                print("Error adding new Item \(error)")
            }
            self.tableView.reloadData()
        }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
    }
    //MARK: - Funcs

    func load(){
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    func delete(at indexPath: IndexPath) -> Bool {
        // Check if there is a category at provided row
        guard let item = toDoItems?[indexPath.row] else {
            return false
        }
        // Delete data from persistent storage
        do {
            // Open transaction
        try realm.write {

                // Insert category
            realm.delete(item)
        }
        } catch {
            fatalError("Error deleting Category: \(error)")
        }
        load()
           return true
}
}
