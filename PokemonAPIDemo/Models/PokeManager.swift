//
//  PokeManager.swift
//  PokemonAPIDemo
//
//  Created by 後藤孝輔 on 2021/10/07.
//

import Foundation

protocol PokeManagerDelegate {
    func didFeatchPoke(_ pokeManager: PokeManager, name: String, number: Int)
    func didFeatchPokeVattle(_ pokeManager: PokeManager, image: String)
}

struct PokeManager {
    
    var delegate: PokeManagerDelegate?
    
    // pokeAPIからデータを取得
    func featchPokeData() {
        let randomNumber = Int.random(in: 1...898)
        let urlString = "https://pokeapi.co/api/v2/pokemon-species/\(randomNumber)/"
        guard let url = URL(string: urlString) else { fatalError() }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let safeData = data else { fatalError() }
            guard let pokeModel = self.parseJSON(safeData) else { fatalError() }
            self.delegate?.didFeatchPoke(self, name: pokeModel.name, number: randomNumber)
        }
        
        task.resume()
    }
    
    func featchPokeVattleData(name: String) {
        let lowerName = name.lowercased()
        print(lowerName)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(lowerName)/"
        guard let url = URL(string: urlString) else { fatalError() }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let safeData = data else { fatalError() }
            guard let pokeVattleModel = self.parseJSONVattle(safeData) else { fatalError() }
            self.delegate?.didFeatchPokeVattle(self, image: pokeVattleModel.image)
        }
        task.resume()
    }
    
    // JSON形式のデータをPokeModel型に変換
    func parseJSON(_ pokeData: Data) -> PokeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokeData.self, from: pokeData)
            let hapi = decodedData.base_happiness
            let cap = decodedData.capture_rate
            let name = decodedData.names[7].name
            let pokeModel = PokeModel(hapi: hapi, capture_rate: cap, name: name)
            return pokeModel
        } catch {
            print(error)
            return nil
        }
    }
    
    func parseJSONVattle(_ pokeVattleData: Data) -> PokeVattleModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokeVattleData.self, from: pokeVattleData)
            let pokeVattleModel = PokeVattleModel(image: decodedData.sprites.front_default)
            return pokeVattleModel
        } catch {
            print(error)
            return nil
        }
    }
}
