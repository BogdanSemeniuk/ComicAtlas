//
//  AppWebView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 26.03.2026.
//

import SwiftUI
import WebKit

struct AppWebView: View {
    let html: String
    let webViewHeight: CGFloat
    let onTapLink: ((URL) -> Void)?
    let contentHeightCompletion: ((CGFloat) -> Void)?
    @State private var page: WebPage
    
    init(
        html: String,
        webViewHeight: CGFloat,
        onTapLink: ((URL) -> Void)? = nil,
        contentHeightCompletion: ((CGFloat) -> Void)? = nil
    ) {
        self.html = html
        self.webViewHeight = webViewHeight
        self.onTapLink = onTapLink
        self.contentHeightCompletion = contentHeightCompletion
        _page = State(
            initialValue: WebPage(
                navigationDecider: WebNavigationDecider(
                    openURL: { onTapLink?($0) }
                )
            )
        )
    }
    
    var body: some View {
        WebView(page)
            .frame(height: webViewHeight)
            .webViewContentBackground(.hidden)
            .webViewMagnificationGestures(.disabled)
            .onAppear {
                page.load(html: html)
            }
            .overlay {
                if page.isLoading {
                    ProgressView()
                        .controlSize(.large)
                }
            }
            .onChange(of: page.isLoading) { _, newValue in
                guard newValue == false else { return }
                contentHeightScript()
            }
    }
    
    private func contentHeightScript() {
        let script = """
                        return Math.max(
                            document.body.scrollHeight,
                            document.documentElement.scrollHeight
                            )
                      """
        Task {
            guard let contentHeight = try? await page.callJavaScript(script) as? Double else { return }
            contentHeightCompletion?(contentHeight)
        }
    }
    
    class WebNavigationDecider: WebPage.NavigationDeciding {
        var openURL: ((URL) -> Void)?
        
        init(openURL: ((URL) -> Void)? = nil) {
            self.openURL = openURL
        }
        
        func decidePolicy(
            for action: WebPage.NavigationAction,
            preferences: inout WebPage.NavigationPreferences
        ) async -> WKNavigationActionPolicy {
            if action.navigationType == .linkActivated,
                let url = action.request.url {
                openURL?(url)
                return .cancel
            }
            return .allow
        }
    }
}

#Preview {
    AppWebView(html: "", webViewHeight: 500)
}
