//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Shrijan Aryal on 9/5/18.
//  Copyright © 2018 Shrijan Aryal. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
//    var globalmovie: [[String:Any]] = []
    var refreshcontrol:UIRefreshControl!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    //create instance of movie
    var movies:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        tableView.addSubview(activityIndicator)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        refreshcontrol = UIRefreshControl()
        
        activityIndicator.stopAnimating()

        refreshcontrol.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshcontrol, at:0)
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl){

        fetchMovies()
        activityIndicator.stopAnimating()

    }
    
    func fetchMovies(){
        activityIndicator.startAnimating()
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie=self.movies[indexPath.row]
        return cell
    }
    
}
