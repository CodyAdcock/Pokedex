//
//  PokemonController.swift
//  Pokedex
//
//  Created by Cody on 9/4/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class PokemonController {
    
    static let shared = PokemonController()
    
    //protects from Memory leak by preventing other instances from being made
    private init(){}
    
    //MARK: - Properties
    let baseURL = URL(string: "https://pokeapi.co/api/v2")
    
    //Whenever you see the @escaping that means that the function (closure) will escape out of the function and complete at a later time.
    func fetchPokemon(by pokemonName: String, completion: @escaping (Pokemon?) -> Void){
        
        //1) Know what you want to display (complete) to the user
        //2) Call URLSession
        //if you are stuck wanting to fetch something. URLSession
        //Reverse Engineer
        //3) We need the base URL
        guard let unwrappedBaseURL = baseURL else {
            fatalError("bad base url")
        }
        //use components if you want to use Query Items
        let requestURL = unwrappedBaseURL.appendingPathComponent("pokemon").appendingPathComponent(pokemonName)
        //4) Build your URL - Components("/"), Queries[:], and Extentions(".")
        
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            //3) Do try catch
            do{
                //1) Handle your error
                if let error = error {throw error}
                //2) Handle Data
                guard let data = data else {throw NSError()}
                
                //4) JSON Decoder
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pokemon)
                
            }catch let error{
                print("Error fetching pokemon \(error) \(error.localizedDescription)")
                completion(nil);return
            }
            
            //5) Decode anad Complete with your object
            
        }.resume()
    }
    
    
    func fetchImage(pokemon: Pokemon, completion: @escaping (UIImage?) -> Void) {
        
        let imageUrl = pokemon.spritesDictionary.image
        
        URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
            
            do{
                if let error = error {throw error}
                
                guard let data = data else {throw NSError()}
                
                guard let pokemonImage = UIImage(data: data) else {completion(nil);return}
                completion(pokemonImage)
                
            }catch let error{
                print("Error fetching image \(error) \(error.localizedDescription)")
                completion(nil);return
            }
            
        }.resume()
        
        
    }

}
