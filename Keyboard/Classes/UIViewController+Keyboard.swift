//
//  UIViewController+Keyboard.swift
//  Keyboard
//
//  Created by Adrián Bouza Correa on 14/05/2018.
//

import UIKit

public extension UIViewController {
    
    fileprivate struct AssociatedKeys {
        static var keyboardToolbar    = "keyboardToolbar"
        static var willShow = "willShow"
        static var willHide = "willHide"
        static var didShow = "didShow"
        static var didHide = "didHide"
    }
    
    // MARK: - Keyboard Events
    
    internal var willShow: KeyboardEventBlock? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.willShow) as? KeyboardEventBlock }
        set { objc_setAssociatedObject(self, &AssociatedKeys.willShow, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    internal var willHide: KeyboardEventBlock? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.willHide) as? KeyboardEventBlock }
        set { objc_setAssociatedObject(self, &AssociatedKeys.willHide, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    internal var didShow: KeyboardEventBlock? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.didShow) as? KeyboardEventBlock }
        set { objc_setAssociatedObject(self, &AssociatedKeys.didShow, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    internal var didHide: KeyboardEventBlock? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.didHide) as? KeyboardEventBlock }
        set { objc_setAssociatedObject(self, &AssociatedKeys.didHide, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    @objc internal func kb_keyboardWillShow(sender: NSNotification) {
        willShow?(sender)
    }
    
    @objc internal func kb_keyboardWillHide(sender: NSNotification) {
        willHide?(sender)
    }
    
    @objc internal func kb_keyboardDidShow(sender: NSNotification) {
        didShow?(sender)
    }
    
    @objc internal func kb_keyboardDidHide(sender: NSNotification) {
        didHide?(sender)
    }
    
}

extension UIViewController: KeyboardCompatible {
    
    open override var canBecomeFirstResponder: Bool {
        return true
    }
    
    open override var inputAccessoryView: UIView? {
        return keyboard.keyboardToolbar
    }
    
}

public extension Keyboard where Base: UIViewController {
    
    // MARK: - Keyboard Events
    
    func subscribe(to events: KeyboardEvent..., action: KeyboardEventBlock?) {
        for event in events {
            switch event {
            case .willShow:
                base.willShow = action
                NotificationCenter.default.addObserver(base, selector: #selector(UIViewController.kb_keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            case .willHide:
                base.willHide = action
                NotificationCenter.default.addObserver(base, selector: #selector(UIViewController.kb_keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            case .didShow:
                base.didShow = action
                NotificationCenter.default.addObserver(base, selector: #selector(UIViewController.kb_keyboardDidShow(sender:)), name: UIResponder.keyboardDidShowNotification, object: nil)
            case .didHide:
                base.didHide = action
                NotificationCenter.default.addObserver(base, selector: #selector(UIViewController.kb_keyboardDidHide(sender:)), name: UIResponder.keyboardDidHideNotification, object: nil)
            }
        }
    }
    
    func unsubscribe(from events: KeyboardEvent...) {
        if events.isEmpty {
            unsubscribe()
        } else {
            unsubscribe(from: events)
        }
    }
    
    internal func unsubscribe(from events: [KeyboardEvent] = KeyboardEvent.all) {
        for event in events {
            switch event {
            case .willShow:
                base.willShow = nil
                NotificationCenter.default.removeObserver(base, name: UIResponder.keyboardWillShowNotification, object: nil)
            case .willHide:
                base.willHide = nil
                NotificationCenter.default.removeObserver(base, name: UIResponder.keyboardWillHideNotification, object: nil)
            case .didShow:
                base.didShow = nil
                NotificationCenter.default.removeObserver(base, name: UIResponder.keyboardDidShowNotification, object: nil)
            case .didHide:
                base.didHide = nil
                NotificationCenter.default.removeObserver(base, name: UIResponder.keyboardDidHideNotification, object: nil)
            }
        }
    }
    
    // MARK: - UIToolbar
    
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
    
    func customize(_ block: KeyboardCustomizeBlock) {
        guard let toolbar = keyboardToolbar else {
            return
        }
        block(toolbar, toolbar.items)
        toolbar.layoutIfNeeded()
        return
    }
    
    // MARK: - Building
    
    func with(items: KeyboardItem...) -> Self {
        return self.with(items: items)
    }
    
    func with(items: [KeyboardItem]) -> Self {
        buildAccesoryView(with: items)
        return self
    }
    
}
