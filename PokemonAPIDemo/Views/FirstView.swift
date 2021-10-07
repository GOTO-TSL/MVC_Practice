//
//  FirstView.swift
//  PokemonAPIDemo
//
//  Created by 後藤孝輔 on 2021/10/07.
//

import UIKit

class FirstView: UIView {
    // MARK: - Properties
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "ポケモン名"
        label.textAlignment = .center
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, inputTextField])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        [
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 50),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -50)
        ].forEach { $0.isActive = true }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
