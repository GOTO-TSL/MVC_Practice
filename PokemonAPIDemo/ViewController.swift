//
//  ViewController.swift
//  PokemonAPIDemo
//
//  Created by 後藤孝輔 on 2021/09/15.
///

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "ポケモン名"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "図鑑番号を入力"
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
        
        configureUI()
        
    }
    
    func configureUI() {
        view.addSubview(nameLabel)
        view.addSubview(inputTextField)
        
        [
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20)
        ].forEach { $0.isActive = true }
    }
    
    func featchPokeData(number: String) {
        let urlString = "https://pokeapi.co/api/v2/pokemon-species/" + number + "/"
        guard let url = URL(string: urlString) else { fatalError() }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let safeData = data else { fatalError() }
            guard let pokeModel = self.parseJSON(safeData) else { fatalError() }
            DispatchQueue.main.async {
                self.nameLabel.text = pokeModel.name
            }
        }
        
        task.resume()
    }
    
    func parseJSON(_ pokeData: Data) -> PokeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokeData.self, from: pokeData)
            let hapi = decodedData.base_happiness
            let cap = decodedData.capture_rate
            let name = decodedData.names[0].name
            let pokeModel = PokeModel(hapi: hapi, capture_rate: cap, name: name)
            return pokeModel
        } catch {
            print(error)
            return nil
        }
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.endEditing(true)
        guard let text = textField.text else { return }
        featchPokeData(number: text)
    }
}

