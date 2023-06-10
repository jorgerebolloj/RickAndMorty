//
//  ContentView.swift
//  RickAndMorty
//
//  Created by XIPEHK on 6/9/23.
//

import SwiftUI

struct CharacterListView: View {
    
    @State private var characters = [CharactersListQuery.Data.Characters.Result]()
    @State private var fetchGraphQL = false
    
    var body: some View {
        NavigationView {
            VStack {
                if fetchGraphQL == false {
                    ProgressView()
                } else {
                    List(characters, id: \.id){ character in
                        NavigationLink(destination: CharacterDetailView(idCharacter: character.id ?? "1")){
                            Text(character.name ?? "").font(.title)
                        }
                    }
                }
            }
            .navigationTitle("Personajes")
            .onAppear(perform: {
                ApolloManager.shared.apollo.fetch(query: CharactersListQuery()){ result in
                    switch result {
                    case .success(let graphql):
                        DispatchQueue.main.async {
                            characters = graphql.data?.characters?.results as! [CharactersListQuery.Data.Characters.Result]
                            fetchGraphQL = true
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            })
        }
    }
}
