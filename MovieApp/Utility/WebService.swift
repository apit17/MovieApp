//
//  WebService.swift
//  MovieApp
//
//  Created by Apit on 3/6/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift


class WebService: NSObject {
    
    static var manager: SessionManager!
    
    static let accessToken = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjOTU3YzQ0NjMxNzk0NTdjMWE2MzAzMWE4OGVhZDFiOCIsInN1YiI6IjVhOWViODE1YzNhMzY4NDI4YjAxNTNjMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.H2FDbk1XIBBw6-jwg-w1PGE2Uo0M2HRcwrBSc_ZzEc4"
    static let apiKey = "c957c4463179457c1a63031a88ead1b8"
    static let baseApi = "https://api.themoviedb.org/"
    static let youtubeWatch = "https://www.youtube.com/embed/"
    static let apiV3 = baseApi + "3/movie/"
    static let apiV4 = baseApi + "4/"
    static let baseImageApi = "https://image.tmdb.org/t/p/w500/"
    static let GET_MOVIE_LIST = apiV4 + "list/"
    static let NOW_PLAYING_MOVIE = apiV3 + "now_playing"
    static let UPCOMING_MOVIE = apiV3 + "upcoming"
    static let POPULAR_MOVIE = apiV3 + "popular"
    static let SEARCH_MOVIE = baseApi + "3/search/movie"

    
    
    static func GET(url: String, header: [String: String], parameter: [String: Any], isLoading:Bool, success: @escaping (JSON) -> Void, failure: @escaping (ErrorHandler) -> Void) {
        if manager == nil {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30
            configuration.timeoutIntervalForResource = 30
            manager = SessionManager(configuration: configuration)
        }
        let request = manager.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: header)
        if isLoading {
            ProgressHUD.show("Loading", interaction: false)
        }
        request.responseJSON { (response) in
            switch response.result {
            case .success(let json):
                let jsonObject = JSON(json)
                success(jsonObject)
                if isLoading{
                    ProgressHUD.dismiss()
                }
            case .failure(let error):
                if isLoading{
                    ProgressHUD.dismiss()
                }
                failure(ErrorHandler(error: error as NSError))
            }
        }
    }
    
    static func getColor(with rating: Float) -> [UIColor]{
        let fillGreenColor = UIColor(red: 33.0/255.0, green: 208.0/255.0, blue: 122.0/255.0, alpha: 1.0)
        let emptyGreenColor = UIColor(red: 32.0/255.0, green: 69.0/255.0, blue: 41.0/255.0, alpha: 1.0)
        let fillYellowColor = UIColor(red: 210.0/255.0, green: 213.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        let emptyYellowColor = UIColor(red: 66.0/255.0, green: 61.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        let fillRedColor = UIColor(red: 219.0/255.0, green: 35.0/255.0, blue: 96.0/255.0, alpha: 1.0)
        let emptyRedColor = UIColor(red: 87.0/255.0, green: 20.0/255.0, blue: 53.0/255.0, alpha: 1.0)
        let emptyGrayColor = UIColor.gray
        if (rating > 40.0) && (rating < 70.0)  {
            return [fillYellowColor, emptyYellowColor]
        }else if (rating > 20.0) && (rating < 40.0)  {
            return [fillRedColor, emptyRedColor]
        }else if rating > 70.0 {
            return [fillGreenColor, emptyGreenColor]
        }else {
            return [emptyGrayColor, emptyGrayColor]
        }
    }

}
