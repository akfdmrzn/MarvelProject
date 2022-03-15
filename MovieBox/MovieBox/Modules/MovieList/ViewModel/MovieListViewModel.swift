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
    
    func load(indexType : GetDataSourceIndexType)
    func getTitle() -> String
    func getMovieItem(at indexPath: IndexPath) -> CharacterModel
    func selectMovie(at index: Int)    
    func getDataSource() -> MovieListDataSource
}

enum MovieListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case reloadMovieList
}

enum GetDataSourceIndexType: Int {
    case defaultType = 0
    case nextType = 1
    case backType = 2
}

protocol MovieListViewModelDelegate {
    func handleViewModelOutput(_ output: MovieListViewModelOutput)
}

protocol MovieListCoordinatorViewModelDelegate {
    func showDetails(of content: CharacterModel)
}

final class MovieListViewModel: MovieListViewModelProtocol {
    var coordinatorDelegate: MovieListCoordinatorViewModelDelegate?
    var delegate: MovieListViewModelDelegate?

    var apiClient: CharactersListServiceProtocol!
    var movies: [CharacterModel] = []
    var limit: Int = 30
    var offSet: Int = 0
    
    init(apiClient: CharactersListServiceProtocol) {
        self.apiClient = apiClient
    }
    
    func load(indexType : GetDataSourceIndexType) {
        notify(.updateTitle(getTitle()))
        notify(.setLoading(true))
        switch indexType {
        case .defaultType:
            self.offSet = 0
            break;
        case .nextType:
            self.offSet += 30
            break;
        case .backType:
            if self.offSet != 0 {
                self.offSet -= 30
            }
            break;
        }
        apiClient.fetchCharactersList(limit: self.limit, offSet: self.offSet) { [weak self] (result) in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
            case .success(let data):
                self.movies = data.data?.results ?? []
                self.notify(.reloadMovieList)
            case .failure(let error):
                print(error)
            }
        }
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
    
    func getDataSource() -> MovieListDataSource {
        let didSelectItemHandler : MovieListDataSource.MovieDidSelectItemHandler = {  [weak self] index in
            self?.selectMovie(at: index)
        }
        
        return MovieListDataSource(with: movies, didSelectItemHandler: didSelectItemHandler)
    }
        
    private func notify(_ output: MovieListViewModelOutput) {
         delegate?.handleViewModelOutput(output)
     }
}
