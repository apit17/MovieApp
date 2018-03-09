//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by Apit on 3/8/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit
import YOChartImageKit

class DetailMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var detailTableView: UITableView!
    
    var movie = ListMovie()
    var detailMovie = DetailMovie()
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDetailMovie()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        // Do any additional setup after loading the view.
    }
    
    func loadDetailMovie() {
        let parameter: [String: Any] = ["api_key": WebService.apiKey,
                                        "append_to_response": "videos,casts"]
        WebService.GET(url: WebService.apiV3 + movie.movieId, header: ["Authorization": WebService.accessToken], parameter: parameter, isLoading: true, success: { (json) in
            self.detailMovie = DetailMovie.parseJSON(response: json)
            self.detailTableView.reloadData()
            print(self.detailMovie.artists[0])
        }) { (error) in
            ProgressHUD.dismiss()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.register(UINib.init(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "PosterCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "PosterCell") as! TitleCell
            cell.titleMovieLabel.text = ""
            if detailMovie.title != nil {
                let url = WebService.baseImageApi + detailMovie.poster
                cell.posterImageView.sd_setImage(with: URL(string: url))
                cell.titleMovieLabel.text = detailMovie.title
            }
            cell.selectionStyle = .none
            return cell
        }else if indexPath.row == 1{
            tableView.register(UINib.init(nibName: "BodyCell", bundle: nil), forCellReuseIdentifier: "ContentCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell") as! BodyCell
            if detailMovie.title != nil {
                let image = YODonutChartImage()
                image.donutWidth = 3.5
                image.labelText = detailMovie.rating
                let ratingInt: Float? = Float(detailMovie.rating)
                let rating = ratingInt! * 10
                let findColor = WebService.getColor(with: rating)
                let emptyRating = 100 - rating
                let scale = cell.ratingImage.frame.size.width + 2 / cell.ratingImage.frame.size.height + 2
                image.labelColor = UIColor.black
                image.values = [rating as NSNumber, emptyRating as NSNumber]
                image.colors = findColor
                let locale = Locale(identifier: detailMovie.language)
                let originalLanguage = locale.localizedString(forLanguageCode: detailMovie.language)
                cell.ratingImage.image = image.draw(cell.ratingImage.frame, scale: scale)
                cell.releaseDateLabel.text = "Release Date : " + detailMovie.date
                cell.runningTimeLabel.text = "Running Time : " + detailMovie.runningTime
                cell.originalLanguageLabel.text = "Original Language : " + originalLanguage!
                cell.voteLabel.text = "Vote : " + detailMovie.runningTime
                cell.contentLabel.text = detailMovie.content
                cell.selectionStyle = .none
            }
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
            return cell
        }else if indexPath.row == 2{
            tableView.register(UINib.init(nibName: "SupportCell", bundle: nil), forCellReuseIdentifier: "AktrisCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "AktrisCell") as! SupportCell
            if detailMovie.artists.count > 0 {
                cell.detailMovie = detailMovie.artists
                cell.artistId = "1234234"
                cell.collectionView.reloadData()
            }
            cell.selectionStyle = .none
            return cell
        }else {
            tableView.register(UINib.init(nibName: "VideosCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideosCell
            if detailMovie.videos.count > 0 {
                let videos = detailMovie.videos[0]
                let urlVideo = URL(string: WebService.youtubeWatch + videos.key)
                let webview = UIWebView.init(frame: CGRect(x: 0, y: 8, width: cell.videoView.frame.size.width, height: cell.videoView.frame.size.height))
                let request = URLRequest(url: urlVideo!)
                webview.scalesPageToFit = true
                webview.loadRequest(request)
                cell.videoView.addSubview(webview)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 395
        }else if indexPath.row == 1 {
            tableView.estimatedRowHeight = 181
            tableView.rowHeight = UITableViewAutomaticDimension
            return tableView.rowHeight
        }else if indexPath.row == 2 {
            tableView.estimatedRowHeight = 270
            tableView.rowHeight = UITableViewAutomaticDimension
            return tableView.rowHeight
        }else {
            tableView.estimatedRowHeight = 270
            tableView.rowHeight = UITableViewAutomaticDimension
            return tableView.rowHeight
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
