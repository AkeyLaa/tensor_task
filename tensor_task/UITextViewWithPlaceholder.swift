//
//  UITextViewWithPlaceholder.swift
//  tensor_task
//
//  Created by Sergey on 30.09.2021.
//

import UIKit

@IBDesignable class UITextViewWithPlaceholder: UITextView {
    
    private lazy var placeholderTextView: UITextView = {
        let textView = UITextView()
        textView.text = placeholder
        textView.font = font
        textView.backgroundColor = backgroundColor
        textView.textColor = placeholderColor
        textView.frame = bounds
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return textView
    }()
    
    @IBInspectable
    var placeholder: String? {
        didSet {
            placeholderTextView.text = placeholder
        }
    }
    
    @IBInspectable
    var placeholderColor: UIColor? {
        didSet {
            placeholderTextView.textColor = placeholderColor
        }
    }
    
    override var text: String! {
        didSet {
            placeholderTextView.isHidden = text.isEmpty == false
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        applyCommonTextViewAttributes(to: self)
        configureMainTextView()
        addPlaceholderTextView()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }
    
    
    
    func addPlaceholderTextView() {
        applyCommonTextViewAttributes(to: placeholderTextView)
        insertSubview(placeholderTextView, at: 0)
    }
    
    private func applyCommonTextViewAttributes(to textView: UITextView) {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 10,
                                                   left: 10,
                                                   bottom: 10,
                                                   right: 10)
    }
    
    private func configureMainTextView() {
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.cgColor
        font = UIFont.systemFont(ofSize: 16.0)
        textColor = .white
        textAlignment = .left
        dataDetectorTypes = .all
        layer.shadowOpacity = 0.5
        isEditable = true
        backgroundColor = .darkGray
        isScrollEnabled = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderTextView.frame = bounds
    }
    
    @objc func textDidChange() {
        placeholderTextView.isHidden = !text.isEmpty
    }
}
