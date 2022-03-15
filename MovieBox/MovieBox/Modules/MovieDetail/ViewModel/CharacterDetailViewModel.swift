//
//  CharacterDetailViewModel.swift
//  MovieBox
//
//  Created by Akif Demirezen on 29.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import Foundation

// - MARK: Coordinator Delegate
protocol CharacterDetailCoordinatorViewModelDelegate {
    func dismiss()
}

protocol CharacterDetailViewModelDelegate {
    func handleViewModelOutput(_ output: CharacterDetailViewModelOutput)
}

protocol CharacterDetailViewModelProtocol {
    var delegate: CharacterDetailViewModelDelegate? { get set }
    var coordinatorDelegate: CharacterDetailCoordinatorViewModelDelegate? { get set }
    func getCharacterDetail() -> CharacterModel
    func loadComics()
    func getComicList() -> [ComicModel]
    func dismiss()
}

enum CharacterDetailViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case reloadComicList
}

class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    
    var coordinatorDelegate: CharacterDetailCoordinatorViewModelDelegate?
    var delegate: CharacterDetailViewModelDelegate?

    var apiClient: ComicListByCharacterIdServiceProtocol!

    private var character: CharacterModel!
    var comicList : [ComicModel]?
    
    init(character: CharacterModel,apiClient : ComicListByCharacterIdServiceProtocol) {
        self.character = character
        self.apiClient = apiClient
    }
    
    func getCharacterDetail() -> CharacterModel {
        return character
    }
    
    func loadComics(){
        notify(.setLoading(true))
        apiClient.fetchComicList(limit: 10, characterId: self.character.id ?? 0, dateRange: "2005-01-01%2C\(Date().requestDateFormat)", orderBy: "onsaleDate") { [weak self] (result) in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
            case .success(let data):
                self.comicList = data.data?.results ?? []
                self.notify(.reloadComicList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getComicList() -> [ComicModel]{
        return self.comicList ?? []
    }
    
    private func notify(_ output: CharacterDetailViewModelOutput) {
         delegate?.handleViewModelOutput(output)
     }
    
    func dismiss() {
        coordinatorDelegate?.dismiss()
    }
}


