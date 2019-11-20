//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Samuel Lopez on 10/28/19.
//  Copyright © 2019 Samuel Lopez. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()

    var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    
    // MARK TableView Datasource Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        categories?.count ?? 1
    }

    // MARK TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
   }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    // MARK Add New Item

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController.init(title: "add New Category" , message: "", preferredStyle: .alert)

        let action = UIAlertAction.init(title: "Add", style: .default) { (action) in

            // what will happen when user clicks add item button on our ui alert

            let newCategory = Category()
            newCategory.name = textField.text!

            self.save(category: newCategory)
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true) {
        }
    }

    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error saving context, \(error)\n")
        }
        tableView.reloadData()
    }

    func loadCategories(){

        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
}
