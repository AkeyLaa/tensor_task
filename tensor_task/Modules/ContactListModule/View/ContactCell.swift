//
//  ContactCell.swift
//  tensor_task
//
//  Created by Sergey on 29.09.2021.
//

import UIKit
import SnapKit

class ContactCell: UITableViewCell {
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(systemName: "person.circle.fill")
        imageView.tintColor = .systemGray2
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var contactLabel: UITitledView = {
        let label = UITitledView("Телефон")
        label.textLabel.textColor = .white
        return label
    }()
    
    lazy var birthdayLabel: UITitledView = {
        let label = UITitledView("Дата рождения")
        label.textLabel.textColor = .white
        return label
    }()
    
    lazy var postLabel: UITitledView = {
        let label = UITitledView("Должность")
        label.textLabel.numberOfLines = 0
        label.textLabel.textColor = .white
        return label
    }()
    
    lazy var workPhoneLabel: UITitledView = {
        let label = UITitledView("Рабочий телефон")
        label.textLabel.textColor = .white
        return label
    }()
    
    func configure(contact: ContactModel) {
        setupView(contact.contactType)
        setupContraints(contact.contactType)
        fullnameLabel.text = contact.fullname
        contactLabel.textLabel.text = contact.contactPhone
        if contact.contactType == .colleague {
            postLabel.textLabel.text = contact.post
            workPhoneLabel.textLabel.text = contact.workPhone
        } else {
            birthdayLabel.textLabel.text = contact.birthday
        }
    }
    
    func setupView(_ contactType: ContactEnum) {
        selectionStyle = .none
        backgroundColor = UIColor(named: "ContactBackground")
        addSubViews(
            iconImageView,
            fullnameLabel,
            contactLabel
        )
        if contactType == .colleague {
            addSubViews(
                postLabel,
                workPhoneLabel
            )
        } else {
            addSubViews(
                birthdayLabel
            )
        }
    }
    
    func setupContraints(_ contactType: ContactEnum) {
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.left.top.equalToSuperview().offset(10)
        }
        iconImageView.setContentHuggingPriority(.required, for: .horizontal)
        iconImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        fullnameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }
        contactLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        if contactType == .colleague {
            postLabel.snp.makeConstraints { make in
                make.top.equalTo(contactLabel.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().inset(10)
            }
            workPhoneLabel.snp.makeConstraints { make in
                make.top.equalTo(postLabel.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().inset(10)
                make.bottom.equalToSuperview().inset(10)
            }
        } else {
            birthdayLabel.snp.makeConstraints { make in
                make.top.equalTo(contactLabel.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().inset(10)
                make.bottom.equalToSuperview().inset(10)
            }
        }
    }
}
