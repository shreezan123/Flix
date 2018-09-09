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
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        titleLabel.text = movie["title"] as? String
        releaseDateLabel.text = movie["release_date"] as? String
        overviewLabel.text = movie["overview"] as? String
        
        let backdropString = movie["backdrop_path"] as! String
        let posterString = movie["poster_path"] as! String
        let baseURL:String = "https://image.tmdb.org/t/p/w500"
        let backdropURL = URL(string: baseURL + backdropString)!
        let posterURL = URL(string: baseURL + posterString)!
        backdropImageView.af_setImage(withURL: backdropURL)
        posterImageView.af_setImage(withURL: posterURL)
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
