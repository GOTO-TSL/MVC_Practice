//
//  FirstView.swift
//  PokemonAPIDemo
//
//  Created by 後藤孝輔 on 2021/10/07.
//

import UIKit

class FirstView: UIView {
    // MARK: - Properties
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "問題"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.text = "結果"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "答えを入力"
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let answerButton: UIButton = {
        let button = UIButton()
        button.setTitle("回答", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stack = UIStackView(arrangedSubviews: [questionLabel, answerLabel, inputTextField])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        addSubview(answerButton)
        
        [
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 50),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -50),
            answerButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30),
            answerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            answerButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 150),
            answerButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -150)
        ].forEach { $0.isActive = true }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
