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
                        if character.image == nil {
                            ProgressView()
                        } else {
                            NavigationLink(destination: CharacterDetailView(idCharacter: character.id ?? "1")){
                                AsyncImage(url: URL(string: character.image ?? "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!) { phase in
                                    if let image = phase.image {
                                        image
                                    } else if phase.error != nil {
                                        Image(systemName: "person.fill")
                                    }
                                }
                                .clipped()
                                .clipShape(Circle())
                                .frame(width: 100, height:200, alignment: .center)
                                Text(character.name ?? "")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 5)
                                    .multilineTextAlignment(.trailing)
                                    .fontWidth(.condensed)
                            }
                            .listRowBackground(Color.yellow)
                            .foregroundColor(.red)
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .toolbarColorScheme(.light, for: .navigationBar)
                    .toolbarBackground(.orange, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .foregroundColor(.orange)
                }
            }
            .navigationTitle("Personajes")
        }
        .tint(.black)
    }
}
