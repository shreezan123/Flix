//
//  SuperHeroViewController.swift
//  Flix
//
//  Created by Shrijan Aryal on 9/7/18.
//  Copyright © 2018 Shrijan Aryal. All rights reserved.
//

import UIKit

class SuperHeroViewController: UIViewController,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var movie: [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsperLine: CGFloat = 4
        let interItemSpacingTotal = layout.minimumInteritemSpacing*(cellsperLine-1)
        
        let width = collectionView.frame.size.width / cellsperLine - interItemSpacingTotal/cellsperLine
        layout.itemSize = CGSize(width:width, height: width*1.5)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                let movies = dataDictionary["results"] as! [[String:Any]]
                self.movie = movies
                self.collectionView.reloadData()
            }
        }
        task.resume()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movie.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = self.movie[indexPath.item]
        if let posterPath = movie["poster_path"] as? String{
            let baseURL:String = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURL + posterPath)!
            
            cell.posterImageView.af_setImage(withURL: posterURL)
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   

}
