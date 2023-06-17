//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by XIPEHK on 6/16/23.
//

import SwiftUI

class CharacterDetailViewModel: ObservableObject {
    @Published public var character : CharacterDetailQuery.Data.Character?
    public var characterId = "" 
    
    public func fecthCharacterDetail() {
        print(characterId)
        ApolloManager.shared.apollo.fetch(query: CharacterDetailQuery(id: characterId)){ [weak self] result in
            switch result {
            case .success(let graphql):
                DispatchQueue.main.async {
                   self!.character = (graphql.data?.character as? CharacterDetailQuery.Data.Character?)!
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
