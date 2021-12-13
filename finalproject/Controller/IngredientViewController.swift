//
//  IngredientViewController.swift
//  finalproject
//
//  Created by Тимур Бакланов on 11.12.2021.
//

import UIKit

protocol AddIngredientsProtocol {
    
    func controllerDidFinishedWithNewImage(ingredients: [Ingredient])
    func controllerDidCancled()
    
}

class IngredientViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var delegate: AddIngredientsProtocol?

    var ingrideints = [Ingredient]()
    var filteredData: [Ingredient]!
    var selectedIngredients = [Ingredient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertCSVIntoArray()
        searchBar.delegate = self
        filteredData = ingrideints
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row].name
        return cell
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if (searchText == "") {
            filteredData = ingrideints
        }
        for ingredient in ingrideints {
            if ingredient.name.lowercased().contains(searchText.lowercased()) {
                filteredData.append(ingredient)
            }
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            selectedIngredients.append(filteredData[indexPath.row])
            print(selectedIngredients)
        }
    }
    @IBAction func addIngredients(_ sender: Any) {
        delegate?.controllerDidFinishedWithNewImage(ingredients: selectedIngredients)
        navigationController?.popViewController(animated: true)
    }
}

extension IngredientViewController {

    func convertCSVIntoArray() {

            //locate the file you want to use
            guard let filepath = Bundle.main.path(forResource: "top-1k-ingredients", ofType: "csv") else {
                return
            }

            //convert that file into one long string
            var data = ""
            do {
                data = try String(contentsOfFile: filepath)
            } catch {
                print(error)
                return
            }

            //now split that string into an array of "rows" of data.  Each row is a string.
            var rows = data.components(separatedBy: "\n")


            //now loop around each row, and split it into each of its columns
            for row in rows {
                let columns = row.components(separatedBy: ";")

                //check that we have enough columns
                if columns.count == 2 {
                    let name = columns[0]
                    let id = Int(columns[1]) ?? 0
                    
                    let ingredient = Ingredient(name: name, id: id)
                    ingrideints.append(ingredient)
                }
            }
        }

}
