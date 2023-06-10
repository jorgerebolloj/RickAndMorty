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
        ZStack{
            Color.mint.ignoresSafeArea()
            VStack{
                if character?.image == nil {
                    ProgressView()
                } else {
                    AsyncImage(url: URL(string: character?.image ?? "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!) { phase in
                        if let image = phase.image {
                            image
                        } else if phase.error != nil {
                            Image(systemName: "person.fill")
                        }
                    }
                    .frame(width: 300, height: 300)
                    .clipped()
                    .clipShape(Circle())
                    Text(character?.name ?? "").font(.title)
                    Text(character?.status ?? "")
                    Text(character?.species ?? "")
                    Text(character?.type ?? "")
                    Text(character?.gender ?? "")
                }
            }
        }
        .onAppear {
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
