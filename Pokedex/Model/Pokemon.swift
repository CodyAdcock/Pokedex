//
//  Pokemon.swift
//  Pokedex
//
//  Created by Cody on 9/4/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

//Abilities
//Name
//ID
//Image

struct Pokemon: Decodable{
    let abilities: [AblitiesDictionary]
    let name: String
    let id: Int
    let spritesDictionary: SpritesDictionary
    
    private enum CodingKeys: String, CodingKey {
        case abilities = "abilities"
        case name = "name"
        case id = "id"
        case spritesDictionary = "sprites"
    }
    
    var abilitiesName: [String]{
        return abilities.compactMap({$0.ability.name})
    }
    
    struct AblitiesDictionary: Decodable {
        let ability: Ability
        
        struct Ability: Decodable {
            let name: String
        }
    }
}



struct SpritesDictionary: Decodable {
    let image: URL
    
    private enum CodingKeys: String, CodingKey {
        case image = "front_default"
    }
}


