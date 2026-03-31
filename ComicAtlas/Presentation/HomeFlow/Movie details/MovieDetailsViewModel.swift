//
//  MovieDetailsViewModel.swift
//  ComicAtlas
//
//  Created by Codex on 31.03.2026.
//

import Combine
import SwiftUI

@Observable
final class MovieDetailsViewModel {
    var isLoading = false
    var movieDetails: MovieDetails?
    var error: Error?
    var htmlContent: String?
    var webViewHeight: CGFloat = 200
    var linkActions: AnyPublisher<LinkHandlingInfo, Never> { linkActionsPublisher.eraseToAnyPublisher() }

    private var linkActionsPublisher: PassthroughSubject<LinkHandlingInfo, Never> = .init()
    private let id: Int
    private let movieRepository: MovieRepository
    private let htmlDecorator: any HTMLFormatting

    init(
        id: Int,
        movieRepository: MovieRepository,
        htmlDecorator: any HTMLFormatting
    ) {
        self.id = id
        self.movieRepository = movieRepository
        self.htmlDecorator = htmlDecorator
    }

    func onAppear() {
        guard movieDetails == nil, !isLoading else { return }
        fetchMovieDetails()
    }

    func linkAction(url: URL) {
        guard url.scheme == nil else {
            linkActionsPublisher.send((url: url, handleInApp: true))
            return
        }

        linkActionsPublisher.send(
            (
                url: URL(safeString: AppEnvironment.baseURL).appending(path: url.absoluteString),
                handleInApp: false
            )
        )
    }

    func webViewContentHeightDidChange(_ height: CGFloat) {
        webViewHeight = height
    }

    func fetchMovieDetails() {
        isLoading = true

        Task {
            defer { isLoading = false }

            do {
                let movieDetails = try await movieRepository.fetchMovieDetails(id: id)
                self.movieDetails = movieDetails

                guard let description = movieDetails.description else { return }
                htmlContent = htmlDecorator.decorate(html: description, fontSize: 16)
            } catch {
                self.error = error
            }
        }
    }

    func formattedReleaseDate(for movie: MovieDetails) -> String {
        movie.releaseDate.toDate(format: .yyyyMMddHHmmss)?.formatted(date: .long, time: .omitted)
        ?? movie.releaseDate
    }

    func formattedBudget(for movie: MovieDetails) -> String? {
        guard let budget = movie.budget else { return nil }
        return formattedCurrency(budget)
    }

    func formattedRevenue(for movie: MovieDetails) -> String? {
        guard let totalRevenue = movie.totalRevenue else { return nil }
        return formattedCurrency(totalRevenue)
    }

    func studiosText(for movie: MovieDetails) -> String {
        movie.studios
            .compactMap(\.name)
            .joined(separator: ", ")
    }

    private func formattedCurrency(_ rawAmount: String) -> String {
        guard let amount = Decimal(string: rawAmount) else {
            return rawAmount
        }

        return amount.formatted(
            .currency(code: "USD")
            .presentation(.narrow)
            .precision(.fractionLength(0))
        )
    }
}
