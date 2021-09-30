//
//  UIExtension.swift
//  tensor_task
//
//  Created by Sergey on 29.09.2021.
//

import UIKit
import SnapKit

extension UITextView {
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(resignFirstResponder))
        done.tintColor = .white
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        inputAccessoryView = doneToolbar
    }
}

extension UIView {
    
    func addSubViews(_ views: UIView...) {
        views.forEach({ self.addSubview($0) })
    }
}
