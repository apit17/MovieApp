//
//  MainTabBarViewController.swift
//  MovieApp
//
//  Created by Apit on 3/8/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit
import SDWebImage

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let nowPlaying = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NowPlayingViewController") as! NowPlayingViewController
        nowPlaying.title = "Now Playing"
        let upcoming = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NowPlayingViewController") as! NowPlayingViewController
        upcoming.title = "Upcoming"
        let popular = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NowPlayingViewController") as! NowPlayingViewController
        popular.title = "Popular"
        let navigationController = UINavigationController()
        navigationController.viewControllers = [nowPlaying, upcoming, popular]
        self.addChildViewController(navigationController)
        tabBar.layer.masksToBounds = false
        tabBar.clipsToBounds = true
        UITabBar.appearance()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
