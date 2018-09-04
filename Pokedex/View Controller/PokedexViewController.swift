//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Cody on 9/4/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UISearchBarDelegate {
    
    //IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setUpUi()
    }
    
    func setUpUi(){
        view.addVerticalGradientLayer(topColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), bottomColor: #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1))
//        pokemonImageView.layer.borderColor = UIColor.white.cgColor
//        pokemonImageView.layer.borderWidth = 1.5
//        pokemonImageView.layer.cornerRadius = 5
        pokemonImageView.layer.shadowOffset = CGSize(width: 3, height: 4)
        pokemonImageView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pokemonImageView.layer.shadowRadius = 3
        pokemonImageView.layer.shadowOpacity = 1
        nameLabel.textColor = .white
        nameLabel.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        idLabel.textColor = .white
        idLabel.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        abilitiesLabel.textColor = .white
        abilitiesLabel.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonText = searchBar.text?.lowercased() else {return}
        PokemonController.shared.fetchPokemon(by: pokemonText) { (pokemon) in
            guard let pokemon = pokemon else {self.presentAlert(); return}
            DispatchQueue.main.async {
                
                self.nameLabel.text = "Name: \(pokemon.name.capitalized)"
                self.idLabel.text = "ID: \(pokemon.id)"
                self.abilitiesLabel.text = "Abilities: \(pokemon.abilitiesName.joined(separator: ", ").capitalized)"
            }
            PokemonController.shared.fetchImage(pokemon: pokemon, completion: { (image) in
                if image != nil {
                    DispatchQueue.main.async {
                        self.pokemonImageView.image = image
                    }
                }else{
                    self.presentAlert()
                }
            })
        }
        
        //dismiss keyboard
        searchBar.resignFirstResponder()
    }
    
    func presentAlert(){
        let alert = UIAlertController(title: "That Is Not Correct", message: "🤮🤮🤮🤮🤮🤮🤮🤮🤮🤮\n Check your spelling!\nThere are only 802 pokemon registered on this pokedex", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
