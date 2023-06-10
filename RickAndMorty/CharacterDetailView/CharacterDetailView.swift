//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by XIPEHK on 6/9/23.
//

import SwiftUI

struct CharacterDetailView: View {
    
    var idCharacter: String
    @State private var character: CharacterDetailQuery.Data.Character?
    
    var body: some View {
        VStack{
            
        }.onAppear {
            ApolloManager.shared.apollo.fetch(query: CharacterDetailQuery(id: idCharacter)){ result in
                switch result {
                case .success(let graphql):
                    DispatchQueue.main.async {
                        character = graphql.data?.character
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
