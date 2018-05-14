//
//  ViewController.swift
//  Keyboard
//
//  Created by adboco@telefonica.net on 05/11/2018.
//  Copyright (c) 2018 adboco@telefonica.net. All rights reserved.
//

import UIKit
import SnapKit
import Keyboard

class ViewController: UIViewController {
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "\(textView.text.utf8.count)"
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private var bottomTextViewConstraint: Constraint?
    
    private var maxLength: Int = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            bottomTextViewConstraint = make.bottom.equalToSuperview().inset(12).constraint
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            } else {
                make.top.equalToSuperview().inset(12)
            }
        }
        
        let cancelItem = KeyboardItem.barButton(title: "Cancel", style: .plain) { _ in
            self.textView.endEditing(true)
        }
        
        let labelItem = KeyboardItem.custom(view: countLabel)
        
        let doneItem = KeyboardItem.barButton(title: "Done", style: .done) { _ in
            self.textView.endEditing(true)
        }
        
        keyboard.with(items: cancelItem, .flexibleSpace, labelItem, .flexibleSpace, doneItem).customize { (toolbar, _) in
            toolbar.isTranslucent = false
            toolbar.tintColor = .purple
        }
        
        textView.keyboard.with(items: cancelItem).customize { (toolbar, _) in
            toolbar.tintColor = .red
        }
        
        keyboard.subscribe(to: .willShow) { sender in
            let userInfo = sender.userInfo!
            var keyboardHeight: CGFloat = 150
            if let frameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                keyboardHeight = frameValue.cgRectValue.height
            }
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self.bottomTextViewConstraint?.update(offset: -keyboardHeight)
                }
            }
        }
        
        keyboard.subscribe(to: .willHide) { _ in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self.bottomTextViewConstraint?.update(offset: 0)
                }
            }
        }
        
        textView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }

}

// MARK: - UITextViewDelegate

extension ViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        countLabel.text = "\(textView.text.utf8.count)"
        countLabel.textColor = textView.text.utf8.count <= maxLength ? .black : .red
        countLabel.sizeToFit()
    }
    
}

