//
//  DetailViewController.swift
//  Flix
//
//  Created by Shrijan Aryal on 9/6/18.
//  Copyright © 2018 Shrijan Aryal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
/*
    @IBOutlet weak var backdropImageView: UIImageView!//large one
    
    @IBOutlet weak var posterImageView: UIImageView! //small one
*/
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var backdropImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        titleLabel.text = movie?.title
        releaseDateLabel.text = movie?.releaseDate
        overviewLabel.text = movie?.overview
        
        let backdropString = movie?.backdropPath
        let posterString = movie?.posterUrl
        let baseURL:String = "https://image.tmdb.org/t/p/w500"
        
        if movie!.posterUrl != nil {
            posterImageView.af_setImage(withURL: movie!.posterUrl!)
        }
        if movie!.backdropUrl != nil {
            backdropImageView.af_setImage(withURL: movie!.backdropUrl!)
        }
        
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
