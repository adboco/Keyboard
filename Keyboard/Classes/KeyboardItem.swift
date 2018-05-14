//
//  KeyboardItem.swift
//  Keyboard
//
//  Created by Adrián Bouza Correa on 11/05/2018.
//

import UIKit

public enum KeyboardItem {
    
    case barButton(title: String, style: UIBarButtonItemStyle, action: UIBarButtonItemTargetClosure?)
    case systemBarButton(system: UIBarButtonSystemItem, action: UIBarButtonItemTargetClosure?)
    case flexibleSpace
    case fixedSpace(width: CGFloat)
    case custom(view: UIView)
    
    func barButtonItem() -> UIBarButtonItem? {
        switch self {
        case .barButton(title: let title, style: let style, action: let action):
            let button = UIBarButtonItem(title: title, style: style, target: nil, action: nil)
            button.actionClosure = action
            return button
        case .systemBarButton(system: let system, action: let action):
            let button = UIBarButtonItem(barButtonSystemItem: system, target: nil, action: nil)
            button.actionClosure = action
            return button
        case .flexibleSpace:
            return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        case .fixedSpace(width: let width):
            let fixedSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            fixedSpaceItem.width = width
            return fixedSpaceItem
        case .custom(view: let view):
            return UIBarButtonItem(customView: view)
        }
    }
    
}
