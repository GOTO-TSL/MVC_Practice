//
//  PokeVattleData.swift
//  PokemonAPIDemo
//
//  Created by 後藤孝輔 on 2021/10/08.
//

import Foundation

struct PokeVattleData: Codable {
    let sprites: Sprites
}

struct Sprites: Codable {
    let front_default: String
}
