//
//  UIView+Keyboard.swift
//  Keyboard
//
//  Created by Adrián Bouza Correa on 14/05/2018.
//

import UIKit

public extension UIView {
    
    fileprivate struct AssociatedKeys {
        static var keyboardToolbar    = "keyboardToolbar"
    }
    
}

extension UIView: KeyboardCompatible { }

public extension Keyboard where Base: UIView {
    
    internal var keyboardToolbar: UIToolbar? {
        get { return objc_getAssociatedObject(base, &type(of: base).AssociatedKeys.keyboardToolbar) as? UIToolbar }
        set { objc_setAssociatedObject(base, &type(of: base).AssociatedKeys.keyboardToolbar, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    internal func buildAccesoryView(with items: KeyboardItem...) {
        return buildAccesoryView(with: items)
    }
    
    internal func buildAccesoryView(with items: [KeyboardItem]) {
        if keyboardToolbar == nil {
            keyboardToolbar = UIToolbar()
            keyboardToolbar?.sizeToFit()
        }
        var toolbarItems: [UIBarButtonItem] = []
        for item in items {
            guard let barButtonItem = item.barButtonItem() else {
                continue
            }
            toolbarItems.append(barButtonItem)
        }
        keyboardToolbar?.items = toolbarItems
    }
    
    // MARK: - Customization
    
    public func customize(_ block: KeyboardCustomizeBlock) {
        guard let toolbar = keyboardToolbar else {
            return
        }
        block(toolbar, toolbar.items)
        toolbar.layoutIfNeeded()
        return
    }
    
}
