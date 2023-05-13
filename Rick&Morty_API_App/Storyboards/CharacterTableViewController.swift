//
//  CharacterTableViewController.swift
//  Rick&Morty_API_App
//
//  Created by Артём Латушкин on 11.05.2023.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        fetchCourse()
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
   // }

}

// MARK: - Networking
extension CharacterTableViewController {
    
    private func fetchCourse() {
        networkManager.fetchCharacter(from: Link.characterLink.url) { result in
            switch result {
            case .success(let character):
                self.characters = character.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
