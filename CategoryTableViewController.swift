//
//  CategoryTableViewController.swift
//  MyTodo
//
//  Created by Andres Gutierrez on 11/30/21.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    private let realm = try! Realm()
     var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       load()
    }

    //MARK: - TableView DataSources
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let categoryLabel = categoryArray?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryLabel?.name ?? "Create new Category"
        
        return cell

    }
    //MARK: - TableView Delgate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

    
    //MARK: - IBA's
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            textField.placeholder = "Enter Category Title"
            let newCat = Category()
            newCat.name = textField.text!
            
            self.save(newCat)
        }
        alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        alert.addTextField { text in
            textField = text
    }
    }
   
    //MARK: - TableView Manipulation Methods
    func save(_ category: Category){
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error saving category with Realm: \(error)")
        }
        tableView.reloadData()
    }

    func load(){
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    

}

