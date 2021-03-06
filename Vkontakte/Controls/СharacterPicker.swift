//
//  СharacterPicker.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 02.02.2021.
//

import UIKit

class CharacterPicker: UIControl {

    var chars = [String]()
    private var buttons = [UIButton]()
    private var stackView: UIStackView!
    
    var selectedChar: String? = nil {
        didSet {
            updateSelectedChar()
            sendActions(for: .valueChanged)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUi()
    }
    
    func setupUi() {
        for char in chars {
            let button = UIButton(type: UIButton.ButtonType.system)
            button.setTitle(char, for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectChar), for: .touchUpInside)
            buttons.append(button)
        }
        stackView = UIStackView(arrangedSubviews: buttons)
        addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    @objc func selectChar(_ sender: UIButton) {
        
        guard let index = buttons.firstIndex(of: sender),
              let char: String? = chars[index]
        else { return }
          
        selectedChar = char
    }
    
    private func updateSelectedChar() {
        for (index, button) in buttons.enumerated() {
            guard let char: String? = chars[index] else { return }
            button.isSelected = char == selectedChar
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
    }

}
