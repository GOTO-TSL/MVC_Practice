//
//  PokeData.swift
//  PokemonAPIDemo
//
//  Created by 後藤孝輔 on 2021/09/15.
//

import Foundation

struct PokeData: Codable {
    let base_happiness: Int
    let capture_rate: Int
    let names: [Name]

}

struct Name: Codable {
    let language: Language
    let name: String
}

struct Language: Codable {
    let name: String
    let url: String
}
