//
//  ViewController.swift
//  finalproject
//
//  Created by Тимур Бакланов on 11.12.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, AddIngredientsProtocol {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var button: UIButton!
    
    func getAllIngredients() {
        do {
            model = try context.fetch(Ingridient.fetchRequest())
            DispatchQueue.main.async {
                self.ingredientTableView.reloadData()
            }
        } catch {
            
        }
    }
    
    func createIngredient(ingredient: Ingredient) {
        let newItem = Ingridient(context: context)
        newItem.name = ingredient.name
        newItem.id = Int64(ingredient.id)
        do {
            try context.save()
            getAllIngredients()
        } catch {
            print(error)
        }
    }
    
    func deleteIngredient(item: Ingridient) {
        context.delete(item)
        
        do {
            try context.save()
            getAllIngredients()
        } catch {
            print(error)
        }
    }
    
    func controllerDidFinishedWithNewImage(ingredients: [Ingredient]) {
        for ingredient in ingredients {
            createIngredient(ingredient: ingredient)
        }
    }
    
    func controllerDidCancled() {
        
    }
    

    @IBOutlet weak var ingredientTableView: UITableView!
    var ingrideints = [Ingredient]()
    var model = [Ingridient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        ingredientTableView.estimatedRowHeight = 100.0 // Adjust Primary table height
        ingredientTableView.rowHeight = UITableView.automaticDimension
        getAllIngredients()
        button.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let uniqueUnordered = Array(Set(ingrideints))
        ingrideints = uniqueUnordered
        ingredientTableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let inredientController = segue.destination as? IngredientViewController
        let reciepiesController = segue.destination as? ReciepiesViewController
        inredientController?.delegate = self
        reciepiesController?.ingridients = model
    }
    
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IngridientTableViewCell
        cell.title?.text = model[indexPath.row].name
        var data = ""
        if ((model[indexPath.row].name?.contains(" ")) != nil) {
            let newString = model[indexPath.row].name!.replacingOccurrences(of: " ", with: "-")
            data = "https://spoonacular.com/cdn/ingredients_100x100/\(newString).jpg"
        } else {
            data = "https://spoonacular.com/cdn/ingredients_100x100/\(model[indexPath.row].name).jpg"
        }
        DispatchQueue.main.async {
            let url = URL(string: data)
            let data = try? Data(contentsOf: url!)
            cell.ingImage.image = UIImage(data: data!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            deleteIngredient(item: model[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.endUpdates()
        }
    }
    
}
