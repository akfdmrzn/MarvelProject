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
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
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
        viewModel.load(indexType: .defaultType)
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
        self.scrollView.setContentOffset(CGPoint.init(x: 0, y: -100), animated: true)
        
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
            viewModel.load(indexType: .backType)
            break;
        case 1:
            viewModel.load(indexType: .nextType)
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
            }
        }
    }
}
