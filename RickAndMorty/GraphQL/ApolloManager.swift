//
//  ApolloManager.swift
//  RickAndMorty
//
//  Created by XIPEHK on 6/9/23.
//

import Foundation
import Apollo

class ApolloManager {
    static var shared = ApolloManager()
    lazy var apollo = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)
    
    private init(){}
}
