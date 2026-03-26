//
//  HTMLDecorator.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 26.03.2026.
//

import Foundation

protocol HTMLFormatting {
    func decorate(html: String, fontSize: Int) -> String
}

struct HTMLDecorator: HTMLFormatting {

    func decorate(html: String, fontSize: Int) -> String {
        """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                html, body {
                    margin: 0;
                    padding: 0;
                    font-family: -apple-system, BlinkMacSystemFont, sans-serif;
                    font-size: \(fontSize)px;
                    line-height: 1.5;
                    overflow-x: hidden;
                    word-wrap: break-word;
                }

                img, figure, div, table, iframe {
                    max-width: 100% !important;
                    width: auto !important;
                    height: auto !important;
                }

                figure {
                    margin: 0;
                }

                a {
                    word-break: break-word;
                }
            </style>
        </head>

        <body>
            \(html)
        </body>
        </html>
        """
    }
}
