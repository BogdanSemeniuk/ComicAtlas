//
//  View+ErrorAlert.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 06.03.2026.
//

import SwiftUI

extension View {
    func errorAlert(
        error: Binding<Error?>,
        buttonTitle: String = .init(localized: .Common.ok)
    ) -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "")
        }
    }
}

struct LocalizedAlertError: LocalizedError {
    let underlyingError: Error
    var errorDescription: String? {
        underlyingError.localizedDescription
    }
    
    var recoverySuggestion: String? {
        (underlyingError as? LocalizedError)?.recoverySuggestion
    }
    
    init?(error: Error?) {
        guard let error else { return nil }
        underlyingError = error
    }
}
