//
//  Constants.swift
//  MovieApp
//
//  Created by Apit on 3/9/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import Foundation

struct Constants {
    static let MY_INSTANCE_ADDRESS = "apit-gilang-aprida.us1a.cloud.realm.io"
    
    static let AUTH_URL  = URL(string: "https://\(MY_INSTANCE_ADDRESS)")!
    static let REALM_URL = URL(string: "realms://\(MY_INSTANCE_ADDRESS)/MovieApp")!
}
