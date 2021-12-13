//
//  ReciepiesViewController.swift
//  finalproject
//
//  Created by Тимур Бакланов on 11.12.2021.
//

import UIKit

class ReciepiesViewController: UITableViewController {

    var ingridients = [Ingridient]()
    var ingrids: String = ""
    lazy var recipies = [Reciepe]()
    var chosenRes: Reciepe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for ingrid in ingridients {
            if (ingrids != "") {
                ingrids += ",+" + ingrid.name!
            } else {
                ingrids += ingrid.name!
            }
        }
        let newIngrid = ingrids.replacingOccurrences(of: " ", with: "+")
        ServiceController.shared.getRecipiesFromIngrediants(ingred: newIngrid) { resultFromAPI in
            DispatchQueue.main.async {
                self.recipies = resultFromAPI
                print(resultFromAPI)
                self.tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recDetVC = segue.destination as? RecDetailsViewController {
            recDetVC.rec = recipies[(tableView.indexPathForSelectedRow?.row)!]
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReciepieTableViewCell
        cell.title.text = recipies[indexPath.row].title
        DispatchQueue.main.async {
            let url = URL(string: self.recipies[indexPath.row].image)
            let data = try? Data(contentsOf: url!)
            cell.recepieImg.image = UIImage(data: data!)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenRes = recipies[indexPath.row]
        self.performSegue(withIdentifier: "showRec", sender: self)
    }
}

