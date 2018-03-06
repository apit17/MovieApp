//
//  NowPlayingViewController.swift
//  MovieApp
//
//  Created by Apit on 3/6/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit
import SDWebImage

class NowPlayingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var movieTableView: UITableView!
    var listMovie = [ListMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        loadMovie()
    }
    
    func loadMovie() {
        WebService.GET(url: WebService.GET_MOVIE_LIST + "1", header: ["Authorization": WebService.accessToken], parameter: [:], isLoading: true, success: { (json) in
            self.listMovie = ListMovie.parseJSON(response: json)
            self.movieTableView.reloadData()
            print(self.listMovie.count)
        }) { (error) in
            
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
        cell.titleMovieLabel.text = listMovie.title
        cell.dateMovieLabel.text = listMovie.date
        cell.contentMovieLabel.text = listMovie.content
        let urlImage = WebService.baseImageApi + listMovie.poster
        cell.posterImage.sd_setImage(with: URL(string: urlImage))
        return cell
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
