//
//  DetailMovie.swift
//  MovieApp
//
//  Created by Apit on 3/8/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Artist {
    var artistId: String!
    var profileImage: String!
    var fullName: String!
    var character: String!
    var creditId: String!
}

struct Videos {
    var key: String!
}

class DetailMovie: NSObject {
    var poster: String!
    var title: String!
    var content: String!
    var date: String!
    var rating: String!
    var movieId: String!
    var language: String!
    var genres: [String] = [String]()
    var runningTime: String!
    var votes: String!
    var artists: [Artist] = [Artist]()
    var videos: [Videos] = [Videos]()
    
    static func parseJSON(response: JSON) -> DetailMovie {
        let detailMovie = DetailMovie()
        detailMovie.poster = response["poster_path"].stringValue
        detailMovie.title = response["title"].stringValue
        detailMovie.content = response["overview"].stringValue
        detailMovie.date = response["release_date"].stringValue
        detailMovie.rating = response["vote_average"].stringValue
        detailMovie.movieId = response["id"].stringValue
        detailMovie.language = response["original_language"].stringValue
        let genres = response["genres"].arrayValue
        for genre in genres {
            detailMovie.genres.append(genre["name"].stringValue)
        }
        detailMovie.runningTime = response["runtime"].stringValue
        detailMovie.votes = response["vote_count"].stringValue
        let artistsData = response["casts"]["cast"].arrayValue
        for artist in artistsData {
            var artis = Artist()
            artis.artistId = artist["id"].stringValue
            artis.profileImage = artist["profile_path"].stringValue
            artis.fullName = artist["name"].stringValue
            artis.character = artist["character"].stringValue
            artis.creditId = artist["credit_id"].stringValue
            detailMovie.artists.append(artis)
        }
        let videoData = response["videos"]["results"].arrayValue
        for video in videoData {
            var videoPlayer = Videos()
            videoPlayer.key = video["key"].stringValue
            detailMovie.videos.append(videoPlayer)
        }
        return detailMovie
    }
}
