//
//  NetworkManager.swift
//  Rick&Morty_API_App
//
//  Created by Артём Латушкин on 10.05.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
        
    private init() {}
            
    func fetchCharacter(from url: URL, completion: @escaping(Result<CharacterListResponse, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let character = try decoder.decode(CharacterListResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(character))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}

enum Link {
    case characterLink
    
    var url: URL {
        switch self {
        case .characterLink:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
