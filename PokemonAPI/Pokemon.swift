//
//  Pokemon.swift
//  PokemonTableView
//
//  Created by Stanley Ejechi on 4/16/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    var embedded: embedded
 
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}


struct embedded: Codable {
    var episodes: [episodes]

    enum CodingKeys: String, CodingKey {
        case episodes
    }
}

struct episodes: Codable {
    var episodeTitle: String
    var premierDate: String
    var airtime: String
    var season: Int
    var episodeNumber: Int
    var summary: String?
    
    enum CodingKeys: String, CodingKey {
        case episodeTitle = "name"
        case premierDate = "airdate"
        case airtime = "airtime"
        case season = "season"
        case episodeNumber = "number"
        case summary = "summary"
    }
}

