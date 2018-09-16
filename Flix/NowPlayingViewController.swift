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
    var globalmovie: [[String:Any]] = []
    var refreshcontrol:UIRefreshControl!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        tableView.addSubview(activityIndicator)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        refreshcontrol = UIRefreshControl()
        fetchMovies()
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
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print (error.localizedDescription)
            }
            if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                let movies = dataDictionary["results"] as! [[String:Any]]
                self.globalmovie = movies
                self.tableView.reloadData()
                self.refreshcontrol.endRefreshing()
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = globalmovie[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.globalmovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = self.globalmovie[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let postImageURL = movie["poster_path"] as! String
        let baseURL:String = "https://image.tmdb.org/t/p/w500"
        
        let fullURL = URL(string: baseURL + postImageURL)!
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.posterimageView.af_setImage(withURL: fullURL)
        
        return cell
    }
    
}
