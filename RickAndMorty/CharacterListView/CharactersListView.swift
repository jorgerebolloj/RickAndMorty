//
//  ContentView.swift
//  RickAndMorty
//
//  Created by XIPEHK on 6/9/23.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject private var characters = CharacterListViewModel()
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.orange
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if characters.fetchGraphQL == false {
                    ProgressView()
                } else {
                    List(characters.characters, id: \.id){ character in
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
        }
        .tint(Color.green)
    }
}
