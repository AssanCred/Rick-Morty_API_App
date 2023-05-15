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
    private var filterCharacters: [Character] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        fetchCharacters()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterCharacters.count
        }
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCharacter", for: indexPath)
        guard let cell = cell as? CharacterViewCell else  { return UITableViewCell() }
        let character = isFiltering
            ? filterCharacters[indexPath.row]
            : characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = isFiltering
        ? filterCharacters[indexPath.row]
        : characters[indexPath.row]
        let detailsVC = segue.destination as? CharacterDetailsViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailsVC?.character = character
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

extension CharacterTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filterCharacters = characters.filter({ (character: Character) -> Bool in
            return character.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
