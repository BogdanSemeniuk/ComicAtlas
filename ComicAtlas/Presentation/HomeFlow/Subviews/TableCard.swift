//
//  TableCard.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 30.03.2026.
//

import SwiftUI

struct TableCard: View {
    var cardData: CardData
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            RemoteImage(path: cardData.imageURL)
                .frame(width: 150)
            VStack(alignment: .leading, spacing: 10) {
                CardTitle(text: cardData.title)
                if let desctiption = cardData.desctiption {
                    Text(desctiption)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(Color(.textSecondary))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .contentShape(.rect)
    }
}

#Preview {
    TableCard(
        cardData: .init(
            .init(dto: .init( .init(
                id: 0,
                name: "",
                description: "",
                aliases: nil,
                realName: nil,
                image: .init(iconUrl: "", smallUrl: ""))))
        )
    )
}
