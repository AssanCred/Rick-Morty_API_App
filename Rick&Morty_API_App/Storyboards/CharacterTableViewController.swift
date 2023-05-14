//
//  CharacterTableViewController.swift
//  Rick&Morty_API_App
//
//  Created by Артём Латушкин on 11.05.2023.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    private var characters: [Character] = []
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        fetchCharacters()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCharacter", for: indexPath)
        guard let cell = cell as? CharacterViewCell else  { return UITableViewCell() }
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as? CharacterDetailsViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailsVC?.character = characters[indexPath.row]
    }
}

// MARK: - Networking
extension CharacterTableViewController {
    
    private func fetchCharacters() {
        networkManager.fetchCharacters(from: Link.characterLink.url) { [weak self ] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
