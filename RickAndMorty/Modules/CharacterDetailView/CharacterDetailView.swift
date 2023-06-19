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
            Color.yellow.ignoresSafeArea()
            VStack{
                if character.character?.image == nil {
                    ProgressView()
                } else {
                    Spacer()
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
                    Spacer()
                    Text(character.character?.name ?? "")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                        .shadow(color: .gray, radius: 2, x: 0, y: 5)
                        .fontWidth(.condensed)
                    Spacer()
                    Text("Status: " + (character.character?.status ?? "No Data"))
                        .foregroundStyle(.white)
                        .fontWidth(.condensed)
                        .font(.system(size: 30))
                    Text("Species: " + (character.character?.species ?? "No Data"))
                        .foregroundStyle(.white)
                        .fontWidth(.condensed)
                        .font(.system(size: 30))
                    Text("Type: " + (character.character?.type ?? "No Data"))
                        .foregroundStyle(.white)
                        .fontWidth(.condensed)
                        .font(.system(size: 30))
                    Text("Gernder: " + (character.character?.gender ?? "No Data"))
                        .foregroundStyle(.white)
                        .fontWidth(.condensed)
                        .font(.system(size: 30))
                    Spacer()
                }
            }
        }
        .onAppear(){
            character.characterId = idCharacter
            character.fecthCharacterDetail()
        }
    }
}
