//
//  MovieListViewController.swift
//  MovieBox
//
//  Created by Ömer Faruk Öztürk on 28.10.2019.
//  Copyright © 2019 omerfarukozturk. All rights reserved.
//

import UIKit
import Utilities

final class MovieListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
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
        self.collectionViewHeightConstraint.constant = self.collectionView.contentSize.height
        self.loadViewIfNeeded()
    }
    
    // MARK: Data
    
    public func reloaDataSource() {
        dataSource = viewModel.getDataSource()
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.reloadData()
    }
    
    // MARK: UI
    
    private func registerCells() {
        collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        collectionView.register(MovieItemCell.self)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if (change?[.newKey]) != nil {
                let contentHeight: CGFloat = self.collectionView.contentSize.height
                self.collectionViewHeightConstraint.constant = contentHeight
            }
        }
    }
    
    @IBAction func btnActPager(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            
            break;
        case 1:
            
            break;
        default:
            break;
        }
    }
    
}

extension MovieListViewController: MovieListViewModelDelegate {
    func handleViewModelOutput(_ output: MovieListViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
            }
        case .reloadMovieList:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.reloaDataSource()
            }
        }
    }
}
