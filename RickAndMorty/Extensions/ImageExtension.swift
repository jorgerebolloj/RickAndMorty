//
//  ImageExtension.swift
//  RickAndMorty
//
//  Created by XIPEHK on 6/9/23.
//

import SwiftUI

extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url){
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}
