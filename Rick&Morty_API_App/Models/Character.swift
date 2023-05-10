//
//  Character.swift
//  Rick&Morty_API_App
//
//  Created by Артём Латушкин on 07.05.2023.
//

import Foundation

struct CharacterListResponse: Decodable {
    let info: Info
    let results: [Character]
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Decodable {
    let name: String
    let url: String
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}


