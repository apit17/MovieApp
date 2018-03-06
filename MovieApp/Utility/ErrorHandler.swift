//
//  ErrorHandler.swift
//  MovieApp
//
//  Created by Apit on 3/6/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit

class ErrorHandler: NSObject {
    private(set) var code:String!
    private(set) var desc:String!
    
    init(error:NSError) {
        super.init()
        setSelf(code: "\(error.code)", desc: error.localizedDescription)
    }
    
    init(code:String, desc:String) {
        super.init()
        setSelf(code: code, desc: desc)
    }
    
    private func setSelf(code:String, desc:String){
        var description = desc
        if code == "500" || code == "3840"{
            description = "We're sorry but something went wrong"
        } else if code == "-1009" || code == "-1001" || code == "-1005" || code == "4" {
            description = "We're sorry but something went wrong, please check your connection"
        }
        self.code = code
        self.desc = description
    }
}
