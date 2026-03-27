//
//  InfoItem.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 27.03.2026.
//

import SwiftUI

struct InfoItem: View {
    var label: LocalizedStringResource
    var value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .bold()
                .frame(width: 90, alignment: .leading)
            Text(value)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    InfoItem(label: .Common.nameLabel, value: "Example")
}
