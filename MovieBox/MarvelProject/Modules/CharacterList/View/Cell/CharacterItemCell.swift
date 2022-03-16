//
//  CharacterItemCell.swift
//  MovieBox
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import UIKit

protocol CharacterItemCellDelegate {
    func tappedFavourite()
}

final class CharacterItemCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    var character : CharacterModel?
    var delegate : CharacterItemCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8.0
        setGradientBlaclBackground()
    }
    
    func setup(with movie: CharacterModel) {
        self.character = movie
        posterImage.setImage(with: "\(movie.thumbnail?.path ?? "")\(AppConstants.ImagesExtend.portRaitUncanny)")
        titleLabel.text = movie.name
        self.btnFavourite.setBackgroundImage(movie.isFavourited ?? false ? UIImage.init(named: "starFilled") : UIImage.init(named: "starEmpty"), for: .normal)
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
    @IBAction func btnActFavourite(_ sender: Any) {
        if self.character?.isFavourited ?? false{
            var tempList = Defaults().getFavourite()
            var index = 0
            for item in tempList ?? []{
                if item == self.character?.id {
                    tempList?.remove(at: index)
                }
                index += 1
            }
            Defaults().saveFavourite(data: tempList ?? [])
        }
        else{
            var tempList = Defaults().getFavourite()
            tempList?.append(self.character?.id ?? 0)
            Defaults().saveFavourite(data: tempList ?? [])
        }
        self.delegate?.tappedFavourite()
    }
}
