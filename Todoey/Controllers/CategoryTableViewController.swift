//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Samuel Lopez on 10/28/19.
//  Copyright © 2019 Samuel Lopez. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoryArray = [Category]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    
    // MARK TableView Datasource Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        cell.textLabel?.text = categoryArray[indexPath.row].name

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        categoryArray.count
    }

    // MARK TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
   }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    // MARK Add New Item

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController.init(title: "add New Category" , message: "", preferredStyle: .alert)

        let action = UIAlertAction.init(title: "Add", style: .default) { (action) in

            // what will happen when user clicks add item button on our ui alert

            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)

            self.saveCategories()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true) {
        }
    }

    func saveCategories(){
        do{
            try context.save()
        }catch{
            print("Error saving context, \(error)\n")
        }
        tableView.reloadData()
    }

    func loadCategories(){

        let request : NSFetchRequest<Category> = Category.fetchRequest()

        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Error fetching categories, \(error)")
        }

        tableView.reloadData()
    }
}
