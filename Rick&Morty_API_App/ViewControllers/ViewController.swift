//
//  ViewController.swift
//  Rick&Morty_API_App
//
//  Created by Артём Латушкин on 07.05.2023.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacter()
    }
    
    private func fetchCharacter() {
        let urlString = "https://rickandmortyapi.com/api/character"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let CharacterListResponse = try decoder.decode(CharacterListResponse.self, from: data)
                print(CharacterListResponse)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }


}

