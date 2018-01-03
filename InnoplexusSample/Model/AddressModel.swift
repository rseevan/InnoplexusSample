//
//  AddressModel.swift
//  InnoplexusSample
//
//  Created by Seevan Ranka on 03/01/18.
//  Copyright © 2018 Seevan Ranka. All rights reserved.
//

import Foundation
class AddressModel {
    var street : String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
    
    init(street : String, suite: String, city: String, zipcode: String, lat: Double, lng: Double) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = Geo(lat: lat, lng: lng)
    }
}

struct Geo {
    var lat: Double
    var lng: Double
}
