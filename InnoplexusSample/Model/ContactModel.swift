//
//  ContactModel.swift
//  InnoplexusSample
//
//  Created by Seevan Ranka on 03/01/18.
//  Copyright © 2018 Seevan Ranka. All rights reserved.
//

import Foundation

class ContactModel {
    var id: Int64!
    var name: String!
    var username: String!
    var email: String!
    var address: AddressModel
    var phone: String
    var website: String
    var company: Company
    
    init(id: Int64, name: String, username: String, email: String, street: String, suite: String, city: String, zipcode: String, lat: Double, lng: Double, phone: String, website: String, cname: String,catchPhrase: String, bs: String ){
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = AddressModel(street: street, suite: suite, city: city, zipcode: zipcode, lat: lat, lng: lng)
        self.phone = phone
        self.website = website
        self.company = Company(name: cname, catchPhrase: catchPhrase, bs: bs)
    }
    
}
struct Company {
    var name: String
    var catchPhrase: String
    var bs: String
}
