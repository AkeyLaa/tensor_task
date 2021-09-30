//
//  UITitledLabel.swift
//  tensor_task
//
//  Created by Sergey on 30.09.2021.
//

import UIKit

class UITitledLabel: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        //label.font = label.font.withSize(20)
        return label
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    convenience init(_ title: String) {
        self.init()
        titleLabel.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(textLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        textLabel.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(titleLabel.snp.right).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
