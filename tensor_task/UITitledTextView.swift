//
//  UITitledTextField.swift
//  tensor_task
//
//  Created by Sergey on 30.09.2021.
//

import UIKit

class UITitledTextView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        return label
    }()
    
    lazy var textView: UITextViewWithPlaceholder = {
        let textView = UITextViewWithPlaceholder()
        textView.addDoneButtonOnKeyboard()
        return textView
    }()
    
    convenience init(_ title: String) {
        self.init()
        titleLabel.text = title
        textView.placeholder = "Не указано"
        textView.placeholderColor = .systemGray2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        
        addSubview(titleLabel)
        addSubview(textView)
        titleLabel.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        textView.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.greaterThanOrEqualTo(40)
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard self.point(inside: point, with: event) else { return nil }
        return textView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
