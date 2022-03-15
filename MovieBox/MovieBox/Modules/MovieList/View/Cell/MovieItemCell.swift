//
//  MovieItemCell.swift
//  MovieBox
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import UIKit

final class MovieItemCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8.0
        setGradientBlaclBackground()
    }
    
    func setup(with movie: CharacterModel) {
        posterImage.setImage(with: "\(movie.thumbnail?.path ?? "")\(AppConstants.ImagesExtend.portRaitUncanny)")
        titleLabel.text = movie.name
    }
    
    func setGradientBlaclBackground() {
        let colorTop =  UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = titleBackgroundView.bounds

        titleBackgroundView.layer.insertSublayer(gradientLayer, at:0)
    }
}
