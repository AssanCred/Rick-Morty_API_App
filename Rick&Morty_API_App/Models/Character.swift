//
//  Character.swift
//  Rick&Morty_API_App
//
//  Created by Артём Латушкин on 07.05.2023.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let url: String
    let created: String
    
    init(id: Int, name: String, status: String, species: String, type: String, gender: String, image: String, url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.image = image
        self.url = url
        self.created = created
    }
    
    init(from characterData: [String: Any]) {
        id = characterData["id"] as? Int ?? 0
        name = characterData["name"] as? String ?? ""
        status = characterData["status"] as? String ?? ""
        species = characterData["species"] as? String ?? ""
        type = characterData["type"] as? String ?? ""
        gender = characterData["gender"] as? String ?? ""
        image = characterData["image"] as? String ?? ""
        url = characterData["url"] as? String ?? ""
        created = characterData["created"] as? String ?? ""
    }
    
    var detailsInfo: String {
        """
        Name: \(name)
        Gender: \(gender)
        Type: \(type)
        Status: \(status)
        Created: \(created)
        """
    }
    
    static func getCharacter(from value: Any) -> [Character] {
        guard let characterListResponseData = (value as? [String: Any])?["results"] as? [Any] else { return [] }
        guard let charactersData = characterListResponseData as? [[String: Any]] else { return [] }
        
        return charactersData.map { Character(from: $0) }
    }
}

