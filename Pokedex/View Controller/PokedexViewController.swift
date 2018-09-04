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
