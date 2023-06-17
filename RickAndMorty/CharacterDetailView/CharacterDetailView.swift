//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by XIPEHK on 6/9/23.
//

import SwiftUI

struct CharacterDetailView: View {
    var idCharacter: String
    @StateObject private var character = CharacterDetailViewModel()
    
    var body: some View {
        ZStack{
            Color.mint.ignoresSafeArea()
            VStack{
                if character.character?.image == nil {
                    ProgressView()
                } else {
                    AsyncImage(url: URL(string: character.character?.image ?? "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!) { phase in
                        if let image = phase.image {
                            image
                        } else if phase.error != nil {
                            Image(systemName: "person.fill")
                        }
                    }
                    .frame(width: 300, height: 300)
                    .clipped()
                    .clipShape(Circle())
                    Text(character.character?.name ?? "").font(.title)
                    Text(character.character?.status ?? "")
                    Text(character.character?.species ?? "")
                    Text(character.character?.type ?? "")
                    Text(character.character?.gender ?? "")
                }
            }
        }
        .onAppear(){
            character.characterId = idCharacter
            character.fecthCharacterDetail()
        }
    }
}
