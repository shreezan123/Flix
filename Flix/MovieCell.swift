//
//  MovieCell.swift
//  Flix
//
//  Created by Shrijan Aryal on 9/5/18.
//  Copyright © 2018 Shrijan Aryal. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterimageView: UIImageView!
    
    var movie: Movie!{
        didSet{
            titleLabel.text =  movie.title
            overviewLabel.text = movie.overview
            posterimageView.af_setImage(withURL: movie.posterUrl!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
