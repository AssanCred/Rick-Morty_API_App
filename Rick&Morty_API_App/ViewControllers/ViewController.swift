//
//  ViewController.swift
//  Rick&Morty_API_App
//
//  Created by Артём Латушкин on 07.05.2023.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    private let networkManager = NetworkManager.shared
    private let character: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCourse()
    }
    
    private func fetchCourse() {
        networkManager.fetchCharacter(from: Link.characterLink.url) { result in
            switch result {
            case .success(let character):
                print(character)
            case .failure(let error):
                print(error)
            }
        }
    }
//
//    private func fetchImage() {
//        networkManager.fetchImage(from: character.) { <#Data#> in
//            <#code#>
//        }

    }


