//
//  ListMovie.swift
//  MovieApp
//
//  Created by Apit on 3/7/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListMovie: NSObject {
    var poster: String!
    var title: String!
    var content: String!
    var date: String!
    var rating: String!
    var movieId: String!
    
    static func parseJSON(response: JSON) -> [ListMovie] {
        let result = response["results"].arrayValue
        var listMovie = [ListMovie]()
        for res in result {
            let list = ListMovie()
            list.poster = res["poster_path"].stringValue
            list.title = res["title"].stringValue
            list.content = res["overview"].stringValue
            list.date = res["release_date"].stringValue
            list.rating = res["vote_average"].stringValue
            list.movieId = res["id"].stringValue
            listMovie.append(list)
        }
        return listMovie
    }
}
