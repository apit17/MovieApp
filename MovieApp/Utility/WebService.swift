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


class WebService: NSObject {
    
    static var manager: SessionManager!
    
    static let accessToken = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjOTU3YzQ0NjMxNzk0NTdjMWE2MzAzMWE4OGVhZDFiOCIsInN1YiI6IjVhOWViODE1YzNhMzY4NDI4YjAxNTNjMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.H2FDbk1XIBBw6-jwg-w1PGE2Uo0M2HRcwrBSc_ZzEc4"
    static let baseApi = "https://api.themoviedb.org/4/"
    static let baseImageApi = "https://image.tmdb.org/t/p/w500/"
    static let GET_MOVIE_LIST = baseApi + "list/"
    
    
    static func GET(url: String, header: [String: String], parameter: [String: Any], isLoading:Bool, success: @escaping (JSON) -> Void, failure: @escaping (ErrorHandler) -> Void) {
        if manager == nil {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30
            configuration.timeoutIntervalForResource = 30
            manager = SessionManager(configuration: configuration)
        }
        let request = manager.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: header)
        request.responseJSON { (response) in
            switch response.result {
            case .success(let json):
                let jsonObject = JSON(json)
                success(jsonObject)
            case .failure(let error):
                failure(ErrorHandler(error: error as NSError))
            }
        }
    }

}
