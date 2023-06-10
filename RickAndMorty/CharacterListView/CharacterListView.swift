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

    init(){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.orange
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if fetchGraphQL == false {
                    ProgressView()
                } else {
                    List(characters, id: \.id){ character in
                        NavigationLink(destination: CharacterDetailView(idCharacter: character.id ?? "1")){
                            Text(character.name ?? "")
                                .font(.title)
                                .bold()
                                .foregroundColor(Color.white)
                        }
                        .listRowBackground(Color.yellow)
                        .foregroundColor(.red)
                        .buttonStyle(.borderedProminent)
                    }
                    .toolbarColorScheme(.light, for: .navigationBar)
                    .toolbarBackground(Color.orange, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .foregroundColor(.orange)
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
        .tint(Color.green)
    }
}
