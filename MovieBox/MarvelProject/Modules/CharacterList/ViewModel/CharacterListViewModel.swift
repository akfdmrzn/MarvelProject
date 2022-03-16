//
//  CharacterListViewModel.swift
//  MovieBox
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import Foundation

protocol CharacterListViewModelProtocol {
    var delegate: CharacterListViewModelDelegate? { get set }
    var coordinatorDelegate: MovieListCoordinatorViewModelDelegate? { get set }
    
    func load()
    func getTitle() -> String
    func getMovieItem(at indexPath: IndexPath) -> CharacterModel
    func selectMovie(at index: Int)
    func getDataSource() -> CharacterListDataSource
    func didComeEndOfScroll()
    func reloadForFavourite()
    func getLimitCount() -> Int
}

enum CharacterListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case reloadMovieList
    case reloadJustSections
    case reloadEndOfScroll
}

protocol CharacterListViewModelDelegate {
    func handleViewModelOutput(_ output: CharacterListViewModelOutput)
}

protocol MovieListCoordinatorViewModelDelegate {
    func showDetails(of content: CharacterModel)
}

final class CharacterListViewModel: CharacterListViewModelProtocol {
    
    var coordinatorDelegate: MovieListCoordinatorViewModelDelegate?
    var delegate: CharacterListViewModelDelegate?
    
    var apiClient: CharactersListServiceProtocol!
    var movies: [CharacterModel] = []
    var limit: Int = AppConstants.ParameterValues.ScrollIncreaseLimit
    var offSet: Int = 0
    
    init(apiClient: CharactersListServiceProtocol) {
        self.apiClient = apiClient
    }
    
    func load() {
        notify(.updateTitle(getTitle()))
        self.fetchMovie(limit: self.limit,offSet : self.offSet)
        
    }
    
    func fetchMovie(limit : Int,offSet : Int,isFavourited : Bool = false,isEndOfScrool : Bool = false){
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
                else if isEndOfScrool{
                    self.notify(.reloadEndOfScroll)
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
        self.limit += AppConstants.ParameterValues.ScrollIncreaseLimit
        if self.limit > AppConstants.ParameterValues.ScrollTotalLimit {
            self.limit = AppConstants.ParameterValues.ScrollTotalLimit //Service don't support more than 100 Items.
        }
        if self.limit != AppConstants.ParameterValues.ScrollTotalLimit{
            self.fetchMovie(limit: self.limit, offSet: self.offSet,isEndOfScrool: true)
        }
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
    
    func getDataSource() -> CharacterListDataSource {
        let didSelectItemHandler : CharacterListDataSource.MovieDidSelectItemHandler = {  [weak self] index in
            self?.selectMovie(at: index)
        }
        
        let comeEndOfScroll : CharacterListDataSource.ScrollEndOfHandler = {
            self.didComeEndOfScroll()
        }
        
        let reloadForFavourite : CharacterListDataSource.ReloadForFavouriteHandler = {
            self.reloadForFavourite()
        }
        
        return CharacterListDataSource(with: movies, didSelectItemHandler: didSelectItemHandler, comeEndOfScroll: comeEndOfScroll, reloadForFavourite: reloadForFavourite)
    }
    
    private func notify(_ output: CharacterListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
