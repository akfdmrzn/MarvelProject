//
//  CharacterDetailCell.swift
//  MovieBox
//
//  Created by Akif Demirezen on 29.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import UIKit

class CharacterDetailCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setup(with comicItem: ComicModel) {
        titleLabel.text = comicItem.title
        dateLabel.text = comicItem.dates?.first?.date?.toCleanDateString
    }
}
