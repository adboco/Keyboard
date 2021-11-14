//
//  UISearchBar+Keyboard.swift
//  Keyboard
//
//  Created by Adrián Bouza Correa on 11/05/2018.
//

import UIKit

public extension Keyboard where Base: UISearchBar {
    
    func with(items: KeyboardItem...) -> Self {
        return self.with(items: items)
    }
    
    func with(items: [KeyboardItem]) -> Self {
        buildAccesoryView(with: items)
        base.inputAccessoryView = keyboardToolbar
        return self
    }
    
}
