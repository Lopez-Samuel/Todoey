//
//  ViewController.swift
//  Todoey
//
//  Created by Samuel Lopez on 10/16/19.
//  Copyright © 2019 Samuel Lopez. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController  {

    var itemArray = [Item]()

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in:
        .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        loadItems()
    }

    // MARK TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title

        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }

    // MARK TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)

        saveItems()

    }

    // MARK Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController.init(title: "addNewTodoeyItem" , message: "", preferredStyle: .alert)

        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in

            // what will happen when user clicks add item button on our ui alert

            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)

            self.saveItems()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true) {
        }

    }

    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding array")
            }
        }
    }


    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array")
        }
        tableView.reloadData()
    }
}

