//
//  MovieListViewController.swift
//  MovieBox
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController {

    let indicatorView = IndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
    @IBOutlet weak var collectionView: UICollectionView!
    private(set) var dataSource: MovieListDataSource?
    
    var viewModel: MovieListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    // MARK: UI

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        viewModel.load()
    }
    
    override func viewWillLayoutSubviews() {
        self.loadViewIfNeeded()
    }
    
    // MARK: Data
    
    public func reloaDataSource() {
        dataSource = viewModel.getDataSource()
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        
    }
    
    public func reloadAll() {
        collectionView.reloadData()
    }
    
    public func reloadJustItem() {
        collectionView.reloadItems(at: [IndexPath.init(item: 0, section: 0)])
    }
    
    public func reloadWhenEndOfScrool() {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.contentOffset.y = self.collectionView.contentOffset.y + ((AppConstants.ContentCollection.PosterImageRatio * self.collectionView.frame.size.width) / 2)
        }
    }
    // MARK: UI
    
    private func registerCells() {
        collectionView.register(MovieItemCell.self)
    }
    
}

extension MovieListViewController: MovieListViewModelDelegate {
    func handleViewModelOutput(_ output: MovieListViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            DispatchQueue.main.async {
                if isLoading {
                    self.view.addSubview(self.indicatorView)
                    self.indicatorView.viewAnimate.play { finished in
                        
                    }
                }
            }
        case .reloadMovieList:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.indicatorView.removeFromSuperview()
                self.reloaDataSource()
                self.reloadAll()
            }
        case .reloadJustSections:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.indicatorView.removeFromSuperview()
                self.reloaDataSource()
                self.reloadJustItem()
            }
        case .reloadEndOfScroll:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.indicatorView.removeFromSuperview()
                self.reloaDataSource()
                self.reloadWhenEndOfScrool()
            }
        }
    }
}
