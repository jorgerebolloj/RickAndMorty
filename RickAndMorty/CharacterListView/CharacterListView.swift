//
//  ContentView.swift
//  RickAndMorty
//
//  Created by XIPEHK on 6/9/23.
//

import SwiftUI

struct CharacterListView: View {
    
    @State private var characters = [CharactersListQuery.Data.Characters.Result]()
    
    var body: some View {
        NavigationView {
            VStack {
                List(characters, id: \.id){ character in
                    //AsyncImage(url: URL(string: character?.image ?? "https://rickandmorty.com/api/character/avatar/1.jpeg")!)
                    Text(character.name ?? "")
                }
            }
            .navigationTitle("Personajes")
            .onAppear(perform: {
                ApolloManager.shared.apollo.fetch(query: CharactersListQuery()){ result in
                    switch result {
                    case .success(let graphql):
                        DispatchQueue.main.async {
                            characters = graphql.data?.characters?.results as! [CharactersListQuery.Data.Characters.Result]
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            })
        }
    }
}
