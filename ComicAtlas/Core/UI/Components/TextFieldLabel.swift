//
//  TextFieldLabel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

struct TextFieldLabel: View {
    var resource: LocalizedStringResource
    
    var body: some View {
        Text(resource)
            .font(.title2)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.textPrimary)
    }
}

#Preview {
    TextFieldLabel(resource: .Common.emailLabel)
}
