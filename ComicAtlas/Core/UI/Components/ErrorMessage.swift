//
//  ErrorMessage.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

struct ErrorMessage: View {
    var message: String
    var lineLimit = 1
    
    var body: some View {
        Text(message)
            .lineLimit(lineLimit)
            .foregroundStyle(.error)
            .frame(height: 32)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ErrorMessage(message: "Invalid request")
}
