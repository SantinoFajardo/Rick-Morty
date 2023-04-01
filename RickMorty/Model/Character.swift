//
//  Character.swift
//  RickMorty
//
//  Created by Santino Fajardo on 28/03/2023.
//

import Foundation

// Here I'll represent the data that will be managed
// The `Codable` protocol allow me decode the JSON data

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let image: String
    let url: String
    let created: String
    let location: Location?
    let episode: [String]
    let origin: Origin?
    var episodesDetail: [Episodes]?
}

struct CharacterDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: Origin?
    let location: Location?
    let image: String
    var episode: [Episodes]
}

struct Location: Decodable,Encodable {
    let name: String
}

struct Origin: Decodable,Encodable {
    let name: String
}

struct Episodes:Decodable,Encodable,Identifiable{
    let id: Int
    let name: String
    let air_date: String
    let episode: String
}

