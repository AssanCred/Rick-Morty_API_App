//
//  CharacterDetailsViewController.swift
//  Rick&Morty_API_App
//
//  Created by Артём Латушкин on 13.05.2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var detailsInfoLabel: UILabel!
    
    // MARK: - Public Proporties
    var character: Character!
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    private var spinnerView = UIActivityIndicatorView()
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsInfoLabel.text = character.detailsInfo
        title = character.name
        showSpinner(in: pictureImageView)
        fetchImage()
    }
    
    // MARK: - Private Methods
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .white
        spinnerView.startAnimating()
        spinnerView.center = pictureImageView.center
        spinnerView.hidesWhenStopped = true
        view.addSubview(spinnerView)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

// MARK: - Networking
extension CharacterDetailsViewController {
    
    private func fetchImage() {
        networkManager.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.pictureImageView.image = UIImage(data: imageData)
                self?.spinnerView.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
