//
//  Keyboard.swift
//  Keyboard
//
//  Created by Adrián Bouza Correa on 11/05/2018.
//

import UIKit

public typealias KeyboardCustomizeBlock = (UIToolbar, [UIBarButtonItem]?) -> Void
public typealias KeyboardEventBlock = (NSNotification) -> Void

public class Keyboard<Base> {
    
    public let base: Base
    init(_ base: Base) {
        self.base = base
    }
    
}

public protocol KeyboardCompatible {
    
    associatedtype CompatibleType
    var keyboard: Keyboard<CompatibleType> { get set }
    
}

public extension KeyboardCompatible {
    
    public var keyboard: Keyboard<Self> {
        get { return Keyboard(self) }
        set { }
    }
    
}
