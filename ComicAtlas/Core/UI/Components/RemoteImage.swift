//
//  RemoteImage.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 25.03.2026.
//

import SwiftUI

struct RemoteImage: View {
    var path: String
    var height: CGFloat = 200
    var backgroundColor: Color = .white
    
    var body: some View {
        AsyncImage(url: URL(string: path)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                wrappedImage(image)
            case .failure:
                wrappedImage()
            default:
                Color.red
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .background(backgroundColor)
    }
    
    private func wrappedImage(_ image: Image = Image(.placeholder)) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    RemoteImage(
        path: "https://comicvine.gamespot.com/a/uploads/scale_large/0/4/9-1489-8-1-tomb-of-terror.jpg"
    )
}
