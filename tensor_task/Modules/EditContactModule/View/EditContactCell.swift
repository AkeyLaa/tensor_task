//
//  EditContactCell.swift
//  tensor_task
//
//  Created by Sergey on 30.09.2021.
//

import UIKit
import SnapKit

class EditContactCell: UITableViewCell {
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(systemName: "person.circle.fill")
        imageView.tintColor = .systemGray2
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var editIconButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить фото", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    lazy var surnameTextView: UITitledTextView = {
        let textView = UITitledTextView("Фамилия")
        textView.textView.textColor = .white
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    lazy var nameTextView: UITitledTextView = {
        let textView = UITitledTextView("Имя")
        textView.textView.textColor = .white
        return textView
    }()
    
    lazy var middlenameTextView: UITitledTextView = {
        let textView = UITitledTextView("Отчество")
        textView.textView.textColor = .white
        return textView
    }()
    
    lazy var contactTextView: UITitledTextView = {
        let textView = UITitledTextView("Телефон")
        textView.textView.textColor = .white
        return textView
    }()
    
    lazy var birthdayTextView: UITitledTextView = {
        let textView = UITitledTextView("Дата рождения")
        textView.textView.textColor = .white
        return textView
    }()
    
    lazy var postTextView: UITitledTextView = {
        let textView = UITitledTextView("Должность")
        textView.textView.textColor = .white
        return textView
    }()
    
    lazy var workPhoneTextView: UITitledTextView = {
        let textView = UITitledTextView("Рабочий телефон")
        textView.textView.textColor = .white
        return textView
    }()
    
    func configure(contact: ContactModel? = nil) {
        guard let contact = contact else {
            setupView(.colleague)
            setupConstraints(.colleague)
            return
        }
        setupView(contact.contactType)
        setupConstraints(contact.contactType)
        surnameTextView.textView.text = contact.surname
        nameTextView.textView.text = contact.name
        middlenameTextView.textView.text = contact.middlename
        contactTextView.textView.text = contact.contactPhone
        if contact.contactType == .colleague {
            postTextView.textView.text = contact.post
            workPhoneTextView.textView.text = contact.workPhone
        } else {
            birthdayTextView.textView.text = contact.birthday
        }
    }
    
    func setupView(_ contactType: ContactEnum) {
        backgroundColor = UIColor(named: "ContactBackground")
        contentView.addSubViews(
            iconImageView,
            editIconButton,
            surnameTextView,
            nameTextView,
            middlenameTextView,
            contactTextView
        )
        if contactType == .colleague {
            contentView.addSubViews(
                postTextView,
                workPhoneTextView
            )
        } else {
            contentView.addSubViews(
                birthdayTextView
            )
        }
    }
    
    func setupConstraints(_ contactType: ContactEnum) {
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        editIconButton.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
        }
        surnameTextView.snp.makeConstraints { make in
            make.top.equalTo(editIconButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        nameTextView.snp.makeConstraints { make in
            make.top.equalTo(surnameTextView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        middlenameTextView.snp.makeConstraints { make in
            make.top.equalTo(nameTextView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        contactTextView.snp.makeConstraints { make in
            make.top.equalTo(middlenameTextView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        if contactType == .colleague {
            postTextView.snp.makeConstraints { make in
                make.top.equalTo(contactTextView.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().inset(20)
            }
            workPhoneTextView.snp.makeConstraints { make in
                make.top.equalTo(postTextView.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().inset(20)
                make.bottom.equalToSuperview().inset(20)
            }
        } else {
            birthdayTextView.snp.makeConstraints { make in
                make.top.equalTo(contactTextView.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().inset(20)
                make.bottom.equalToSuperview().inset(20)
            }
        }
    }
}
