//
//  ServiceController.swift
//  finalproject
//
//  Created by Тимур Бакланов on 11.12.2021.
//

import Foundation

class ServiceController {
    static var shared = ServiceController()
    
    func getRecipiesFromIngrediants(ingred: String,handler: @escaping ([Reciepe]) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=2b150c56c69944beab485cad78a7b14c&ingredients=\(ingred)"
        let urlObj = URL(string: urlString)!
        
        var task = URLSession.shared.dataTask(with: urlObj) { data, apiResponse, error in
            if let error = error {
                print(error)
            } else if let correctData = data {
                let decoder = JSONDecoder()
                do {
                    var resultFromDecoder = try? decoder.decode([Reciepe].self, from: correctData)
                    handler(resultFromDecoder!)
                } catch {
                    print(error)
                }
                
            }
        }
        task.resume()
    }
    
    func getRecDetails(rec: Reciepe, handler: @escaping (RecDetails) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/\(rec.id)/information?apiKey=2b150c56c69944beab485cad78a7b14c"
        let urlObj = URL(string: urlString)!
        
        var task = URLSession.shared.dataTask(with: urlObj) { data, apiResponse, error in
            if let error = error {
                print(error)
            } else if let correctData = data {
                let decoder = JSONDecoder()
                do {
                    var resultFromDecoder = try? decoder.decode(RecDetails.self, from: correctData)
                    handler(resultFromDecoder!)
                } catch {
                    print(error)
                }
                
            }
        }
        task.resume()
    }
}
