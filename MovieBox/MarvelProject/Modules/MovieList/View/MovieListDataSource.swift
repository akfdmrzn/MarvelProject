//
//  MovieListDataSource.swift
//  MovieBox
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import UIKit

final class MovieListDataSource: NSObject {
    
    typealias MovieDidSelectItemHandler = (Int) -> ()
    typealias ScrollEndOfHandler = () -> ()
    typealias ReloadForFavouriteHandler = () -> ()
    
    var movies: [CharacterModel] = []
    var didSelectItemHandler: MovieDidSelectItemHandler
    var comeEndOfScroll: ScrollEndOfHandler
    var reloadForFavourite: ReloadForFavouriteHandler
    var cellHeight : CGFloat = 0.0
    
    init(with movies: [CharacterModel], didSelectItemHandler: @escaping MovieDidSelectItemHandler,comeEndOfScroll: @escaping ScrollEndOfHandler,reloadForFavourite : @escaping ReloadForFavouriteHandler) {
        self.movies = movies
        self.didSelectItemHandler = didSelectItemHandler
        self.comeEndOfScroll = comeEndOfScroll
        self.reloadForFavourite = reloadForFavourite
    }
}

extension MovieListDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieItemCell.identifier, for: indexPath) as! MovieItemCell
        let movie = movies[indexPath.row]
        cell.setup(with: movie)
        cell.delegate = self
        return cell
    }
}

extension MovieListDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemHandler(indexPath.row)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            self.comeEndOfScroll()
        }
    }
}

extension MovieListDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width - AppConstants.ContentCollection.HorizontalSpaceBetweenItems * 3) / 2
        let height: CGFloat = width * AppConstants.ContentCollection.PosterImageRatio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return AppConstants.ContentCollection.VerticleSpaceBetweenItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return AppConstants.ContentCollection.HorizontalSpaceBetweenItems / 2
    }
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftMargin = CGFloat(AppConstants.ContentCollection.HorizontalSpaceBetweenItems)
        let topMargin = CGFloat(AppConstants.ContentCollection.VerticleSpaceBetweenItems)
        return UIEdgeInsets(top: topMargin, left: leftMargin, bottom: topMargin, right: leftMargin)
    }
}
extension MovieListDataSource : MovieItemCellDelegate{
    func tappedFavourite() {
        self.reloadForFavourite()
    }
}
