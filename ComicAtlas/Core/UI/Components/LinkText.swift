//
//  LinkText.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 25.03.2026.
//

import SwiftUI

struct LinkText: View {
    var destination: URL
    var text: String
    
    init(destination: URL, text: String) {
        self.destination = destination
        self.text = text
    }
    
    init(destination: URL, resource: LocalizedStringResource) {
        self.destination = destination
        self.text = String(localized: resource)
    }
    
    var body: some View {
        Link(
            destination: destination
        ) {
            Text(text)
                .foregroundStyle(Color(.brandPrimary))
                .underline()
        }
    }
}

#Preview {
    LinkText(
        destination: .init(safeString: "https://translate.google.com"),
        resource: .Common.openOnWeb
    )
}
