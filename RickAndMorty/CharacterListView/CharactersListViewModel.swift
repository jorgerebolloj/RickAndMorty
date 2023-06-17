//
//  CharactersListModel.swift
//  RickAndMorty
//
//  Created by XIPEHK on 6/16/23.
//

import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published public var characters = [CharactersListQuery.Data.Characters.Result]()
    @Published public var fetchGraphQL = false
    
    init() {
        fetchCharactersList()
    }
    
    func fetchCharactersList() {
        ApolloManager.shared.apollo.fetch(query: CharactersListQuery()){ [weak self] result in
            switch result {
            case .success(let graphql):
                DispatchQueue.main.async {
                    self?.characters = (graphql.data?.characters?.results as? [CharactersListQuery.Data.Characters.Result])!
                    self?.fetchGraphQL = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
