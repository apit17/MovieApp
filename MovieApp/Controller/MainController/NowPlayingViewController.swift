//
//  NowPlayingViewController.swift
//  MovieApp
//
//  Created by Apit on 3/6/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit
import SDWebImage
import YOChartImageKit
import CCBottomRefreshControl

class NowPlayingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    var listMovie = [ListMovie]()
    var isProgress = true
    var onPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.estimatedRowHeight = 120
        movieTableView.rowHeight = UITableViewAutomaticDimension
        searchBar.delegate = self
        
        loadMovie()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isProgress = true
        navigationController?.title = "Koplok"
    }
    
    @objc func loadMovie() {
        var url = ""
        if title == "Now Playing" {
            url = WebService.NOW_PLAYING_MOVIE
        }else if title == "Upcoming" {
            url = WebService.UPCOMING_MOVIE
        }else {
            url = WebService.POPULAR_MOVIE
        }
        let parameter: [String: Any] = ["api_key": WebService.apiKey,
                                        "page": onPage]
        WebService.GET(url: url, header: ["Authorization": WebService.accessToken], parameter: parameter, isLoading: isProgress, success: { (json) in
            if self.isProgress || self.onPage == 1{
                self.listMovie = ListMovie.parseJSON(response: json)
            }else {
                self.listMovie += ListMovie.parseJSON(response: json)
            }
            self.movieTableView.reloadData()
            self.movieTableView.bottomRefreshControl?.endRefreshing()
        }) { (error) in
            ProgressHUD.dismiss()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NowPlayingCell", for: indexPath) as! ListMovieTableViewCell
        let listMovie = self.listMovie[indexPath.row]
        let scale = cell.ratingImageView.frame.size.width + 2 / cell.ratingImageView.frame.size.height + 2
        let image = YODonutChartImage()
        image.donutWidth = 3.5
        image.labelText = listMovie.rating
        let ratingInt: Float? = Float(listMovie.rating)
        let rating = ratingInt! * 10
        let findColor = WebService.getColor(with: rating)
        let emptyRating = 100 - rating
        image.labelColor = UIColor.black
        image.values = [rating as NSNumber, emptyRating as NSNumber]
        image.colors = findColor
        cell.ratingImageView.image = image.draw(cell.ratingImageView.frame, scale: scale)
        cell.titleMovieLabel.text = listMovie.title
        cell.dateMovieLabel.text = listMovie.date
        cell.contentMovieLabel.text = listMovie.content
        let urlImage = WebService.baseImageApi + listMovie.poster
        cell.posterImage.sd_setImage(with: URL(string: urlImage))
        if indexPath.row == self.listMovie.count - 1 {
            refreshBottom()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailMovieViewController") as! DetailMovieViewController
        controller.movie = self.listMovie[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func refreshBottom() {
        let bottomRefresh = UIRefreshControl()
        bottomRefresh.triggerVerticalOffset =  50
        bottomRefresh.addTarget(self, action: #selector(loadMovie), for: .valueChanged)
        movieTableView.bottomRefreshControl = bottomRefresh
        isProgress = false
        if self.listMovie.count > 0 {
            self.onPage += 1
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let parameter: [String: Any] = ["api_key": WebService.apiKey,
                                        "page": onPage,
                                        "query":searchBar.text!]
        WebService.GET(url: WebService.SEARCH_MOVIE, header: ["Authorization": WebService.accessToken], parameter: parameter, isLoading: isProgress, success: { (json) in
            self.listMovie.removeAll()
            if self.isProgress || self.onPage == 1{
                self.listMovie = ListMovie.parseJSON(response: json)
            }else {
                self.listMovie += ListMovie.parseJSON(response: json)
            }
            self.movieTableView.reloadData()
            self.movieTableView.bottomRefreshControl?.endRefreshing()
        }) { (error) in
            ProgressHUD.dismiss()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
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
