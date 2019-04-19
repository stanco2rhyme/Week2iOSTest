//
//  Pokemon.swift
//  PokemonTableView
//
//  Created by Stanley Ejechi on 4/16/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    var baseExperience: Int
    var isDefault: Bool
    var name: String
    var abilities: [Abilities]
    var forms: [forms]
    var gameIndices: [gameIndices]
    var height: Int
    var id: Int
//    var heldItems: [heldItems]
    var locationAreaEncounters: String
    var moves: [moves]
    var order: Int
    var weight  : Int
    
    enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case isDefault = "is_default"
        case name
        case abilities
        case forms
        case gameIndices = "game_indices"
        case height
        case id
//        case heldItems = "held_items"
        case locationAreaEncounters = "location_area_encounters"
        case moves
        case order
        case weight
    }
    //Needed when you want to convert this model to a data and post it
    
//    init() {
//        baseExperience = 0
//        isDefault = false
//        name = "someName"
//        abilities = []
//    }
 
}


struct Abilities: Codable {
    var ability: Ability
    var isHidden: Bool
    var slot: Int
    
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct Ability: Codable {
    var name: String
    var url: String
}


struct forms: Codable {
    var name: String
    var url: String
}

struct gameIndices: Codable {
    var gameIndex: Int
    var version: Version
    
    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

struct Version: Codable {
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

struct heldItems: Codable {
    
}

struct moves: Codable {
    var move: move
//    var versionGroupDetails: String
    
    enum CodingKeys: String, CodingKey {
        case move
//        case versionGroupDetails = "version_group_details"
    }
}

struct move: Codable {
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
