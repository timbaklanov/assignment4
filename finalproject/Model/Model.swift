//
//  Model.swift
//  finalproject
//
//  Created by Тимур Бакланов on 11.12.2021.
//

import Foundation

struct Reciepe: Codable {
    var id: Int
    var title: String
    var image: String
    
}

struct Ingredient: Hashable {
    var name: String
    var id: Int
}

struct RecDetails: Codable {
    var id: Int
    var title: String
    var image: String
    var sourceUrl: String
    var summary: String
}
