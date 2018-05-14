//
//  UIBarButtomItemExtensions.swift
//  Keyboard
//
//  Created by Adrián Bouza Correa on 11/05/2018.
//

import UIKit

public typealias UIBarButtonItemTargetClosure = (UIBarButtonItem) -> ()

extension UIBarButtonItem {
    
    private struct AssociatedObject {
        static var key = "action_closure_key"
    }
    
    var actionClosure: UIBarButtonItemTargetClosure? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObject.key) as? UIBarButtonItemTargetClosure
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObject.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            target = self
            action = #selector(didTapButton(sender:))
        }
    }
    
    @objc func didTapButton(sender: Any) {
        actionClosure?(self)
    }
    
}
