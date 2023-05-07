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
    let origin: Location
    let location: Location
    let image: URL
    let episode: [URL]
    let url: URL
    let created: String
}

struct Location: Decodable {
    let name: String
    let url: String
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: URL?
    let prev: URL?
}
