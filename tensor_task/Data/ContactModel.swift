//
//  ContactModel.swift
//  tensor_task
//
//  Created by Sergey on 29.09.2021.
//

import Foundation

enum ContactEnum: Int {
    case colleague = 0
    case friend = 1
}

struct ContactModel {
    
    var contactType: ContactEnum
    
    var contactIcon: Data?
    var name: String
    var surname: String
    var middlename: String?
    var contactPhone: String
    
    /// Birthday only for friends
    var birthday: String?
    
    /// Post and workphone for colleagues
    var post: String?
    var workPhone: String?
    
    var fullname: String {
        if middlename == nil {
            return surname + " " + name + " "
        } else {
            return surname + " " + name + " " + middlename!
        }
    }
    
    init(name: String, surname: String, middlename: String? = nil, contactPhone: String, birthday: String?) {
        self.contactType = .friend
        self.name = name
        self.surname = surname
        self.middlename = middlename
        self.contactPhone = contactPhone
        self.birthday = birthday
    }
    
    init(name: String, surname: String, middlename: String? = nil, contactPhone: String, post: String?, workPhone: String?) {
        self.contactType = .colleague
        self.name = name
        self.surname = surname
        self.middlename = middlename
        self.contactPhone = contactPhone
        self.post = post
        self.workPhone = workPhone
    }
}
