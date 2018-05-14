//
//  KeyboardEvent.swift
//  Keyboard
//
//  Created by Adrián Bouza Correa on 14/05/2018.
//

import Foundation

public enum KeyboardEvent {
    
    case willShow, willHide, didShow, didHide
    
    public static var all: [KeyboardEvent] {
        return [.willShow, .willHide, .didShow, .didHide]
    }
    
}
