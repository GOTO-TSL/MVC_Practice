//
//  ViewController.swift
//  PokemonAPIDemo
//
//  Created by 後藤孝輔 on 2021/09/15.
///

import UIKit

class ViewController: UIViewController {
    
    var nameLabel: UILabel!
    var textField: UITextField!
    var pokeManager: PokeManager!
    var benchmark: Benchmark!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeManager = PokeManager()
        pokeManager.delegate = self
        configureUI()
        
    }
    
    func configureUI() {
        
        let firstView = FirstView()
        firstView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel = firstView.nameLabel
        textField = firstView.inputTextField
        view.addSubview(firstView)
        
        [
            firstView.topAnchor.constraint(equalTo: view.topAnchor),
            firstView.leftAnchor.constraint(equalTo: view.leftAnchor),
            firstView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            firstView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ].forEach { $0.isActive = true }
        
        textField.delegate = self
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
        benchmark = Benchmark(key: "getPoke")
        DispatchQueue.global(qos: .background).async {
            self.pokeManager.featchPokeData(number: text)
        }
    }
}

extension ViewController: PokeManagerDelegate {
    func didFeatchPoke(_ pokeManager: PokeManager, name: String) {
        DispatchQueue.main.async {
            self.nameLabel.text = name
            self.benchmark.finish()
        }
    }
}
