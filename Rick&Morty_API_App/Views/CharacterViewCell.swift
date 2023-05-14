//
//  CharacterViewCell.swift
//  Rick&Morty_API_App
//
//  Created by Артём Латушкин on 11.05.2023.
//

import UIKit

class CharacterViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var pictureImageView: UIImageView! {
        didSet {
            pictureImageView.layer.cornerRadius = pictureImageView.frame.height / 2
        }
    }
    @IBOutlet var loadActivityIndicator: UIActivityIndicatorView! {
        didSet {
            loadActivityIndicator.startAnimating()
            loadActivityIndicator.hidesWhenStopped = true
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    // MARK: - Public Methods
    func configure(with character: Character) {
        nameLabel.text = "Name: \(character.name)"
        genderLabel.text = "Gender: \(character.gender)"
        statusLabel.text = "Status: \(character.status)"
        
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: character.image) else { return }
            DispatchQueue.main.async {
                self?.pictureImageView.image = UIImage(data: imageData)
                self?.loadActivityIndicator.stopAnimating()
            }
        }
    }
}
