//
//  MovieListViewModel.swift
//  MovieBox
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import Foundation

protocol MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate? { get set }
    var coordinatorDelegate: MovieListCoordinatorViewModelDelegate? { get set }
    
    func load()
    func getTitle() -> String
    func getMovieItem(at indexPath: IndexPath) -> CharacterModel
    func selectMovie(at index: Int)
    func getDataSource() -> MovieListDataSource
    func didComeEndOfScroll()
    func reloadForFavourite()
    func getLimitCount() -> Int
}

enum MovieListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case reloadMovieList
    case reloadJustSections
}

protocol MovieListViewModelDelegate {
    func handleViewModelOutput(_ output: MovieListViewModelOutput)
}

protocol MovieListCoordinatorViewModelDelegate {
    func showDetails(of content: CharacterModel)
}

final class MovieListViewModel: MovieListViewModelProtocol {
    
    private enum Constant {
        static let ScrollIncreaseLimit : Int = 30
        static let ScrollTotalLimit : Int = 100
    }
    
    var coordinatorDelegate: MovieListCoordinatorViewModelDelegate?
    var delegate: MovieListViewModelDelegate?
    
    var apiClient: CharactersListServiceProtocol!
    var movies: [CharacterModel] = []
    var limit: Int = Constant.ScrollIncreaseLimit
    var offSet: Int = 0
    
    init(apiClient: CharactersListServiceProtocol) {
        self.apiClient = apiClient
    }
    
    func load() {
        notify(.updateTitle(getTitle()))
        self.fetchMovie(limit: self.limit,offSet : self.offSet)
        
    }
    
    func fetchMovie(limit : Int,offSet : Int,isFavourited : Bool = false){
        notify(.setLoading(true))
        apiClient.fetchCharactersList(limit: limit, offSet: offSet) { [weak self] (result) in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
            case .success(var data):
                let tempList = data.data?.results ?? []
                var index = 0
                for item in tempList{
                    if Defaults().getFavourite().contains(item.id ?? 0) {
                        data.data?.results![index].isFavourited = true
                    }
                    index += 1
                }
                self.movies = data.data?.results ?? []
                if isFavourited {
                    self.notify(.reloadJustSections)
                }
                else{
                    self.notify(.reloadMovieList)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didComeEndOfScroll() {
        if self.limit <= 70 {
            self.limit += Constant.ScrollIncreaseLimit
        }
        else{
            self.limit = Constant.ScrollTotalLimit
        }
        self.fetchMovie(limit: self.limit, offSet: self.offSet)
    }
    
    func reloadForFavourite() {
        self.fetchMovie(limit: self.limit, offSet: self.offSet,isFavourited: true)
    }
    
    func getTitle() -> String {
        return "Characters"
    }
    
    func getMovieItem(at indexPath: IndexPath) -> CharacterModel {
        return movies[indexPath.row]
    }
    
    func selectMovie(at index: Int) {
        let movie = movies[index]
        coordinatorDelegate?.showDetails(of: movie)
    }
    
    func getLimitCount() -> Int {
        return self.limit
    }
    
    func getDataSource() -> MovieListDataSource {
        let didSelectItemHandler : MovieListDataSource.MovieDidSelectItemHandler = {  [weak self] index in
            self?.selectMovie(at: index)
        }
        
        let comeEndOfScroll : MovieListDataSource.ScrollEndOfHandler = {
            self.didComeEndOfScroll()
        }
        
        let reloadForFavourite : MovieListDataSource.ReloadForFavouriteHandler = {
            self.reloadForFavourite()
        }
        
        return MovieListDataSource(with: movies, didSelectItemHandler: didSelectItemHandler, comeEndOfScroll: comeEndOfScroll, reloadForFavourite: reloadForFavourite)
    }
    
    private func notify(_ output: MovieListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
