//
//  APIEndpointTests.swift
//  ComicAtlasTests
//
//  Created by Богдан Семенюк on 22.04.2026.
//

@testable import ComicAtlas
import Testing
import Foundation

@Suite("APIEndpoint tests")
struct APIEndpointTests {
    @Test
    func charactersEndpointComponents() {
        let limit = 10
        let offset = 0
        let endpoint = APIEndpoints.characters(limit: limit, offset: offset, sort: .default)
        
        baseExpectations(for: endpoint)
        #expect(endpoint.path == "characters/")
        #expect(endpoint.urlParams?["limit"] == "\(limit)")
        #expect(endpoint.urlParams?["offset"] == "\(offset)")
    }
    
    @Test
    func characterDetailsComponents() {
        let id = 1
        let endpoint = APIEndpoints.characterDetails(id: id)
        
        #expect(endpoint.path == "character/4005-\(id)/")
    }
    
    @Test
    func volumesEndpointComponents() {
        let limit = 10
        let offset = 0
        let endpoint = APIEndpoints.volumes(limit: limit, offset: offset, sort: .nameAscending)
        
        #expect(endpoint.path == "volumes/")
        #expect(endpoint.urlParams?["limit"] == "\(limit)")
        #expect(endpoint.urlParams?["offset"] == "\(offset)")
        #expect(endpoint.urlParams?["sort"] == "name:asc")
    }
    
    @Test
    func endpointUrlRequest() {
        let id = 1
        let request = APIEndpoints.issueDetails(id: id).urlRequest
        
        #expect(request != nil)
        #expect(request?.url != nil)
        guard let request, let url = request.url else { return }
        #expect(request.httpMethod == "GET")
        #expect(request.httpBody == nil)
        #expect(request.allHTTPHeaderFields?.count == 0)
        #expect(url.scheme == "https")
        #expect(url.host == "comicvine.gamespot.com")
        #expect(url.path() == "/api/issue/4000-1/")
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        #expect(components?.percentEncodedQuery?.contains("api_key") == true)
        #expect(components?.percentEncodedQuery?.contains("format=json") == true)
    }
    
    @Test
    func endpointPath() {
        let id = 1
        let issueDetails = APIEndpoints.issueDetails(id: id)
        let volumeDetails = APIEndpoints.volumeDetails(id: id)
        let movieDetails = APIEndpoints.movieDetails(id: id)
        let characterDetails = APIEndpoints.characterDetails(id: id)
        let characters = APIEndpoints.characters(limit: 10, offset: 0, sort: .default)
        let volumes = APIEndpoints.volumes(limit: 10, offset: 0, sort: .default)
        let movies = APIEndpoints.movies(limit: 10, offset: 0, sort: .default)
        let issues = APIEndpoints.issues(limit: 10, offset: 0, sort: .default)
        
        #expect(issueDetails.path == "issue/4000-1/")
        #expect(volumeDetails.path == "volume/4050-1/")
        #expect(movieDetails.path == "movie/4025-1/")
        #expect(characterDetails.path == "character/4005-1/")
        #expect(issues.path == "issues/")
        #expect(volumes.path == "volumes/")
        #expect(characters.path == "characters/")
        #expect(movies.path == "movies/")
    }
    
    @Test
    func sortDescriptorApiValue() {
        let defaultSort = SortDescriptor.default
        let nameAscending = SortDescriptor.nameAscending
        let nameDescending = SortDescriptor.nameDescending
        let dateAscending = SortDescriptor.dateAscending
        let dateDescending = SortDescriptor.dateDescending
        
        #expect(defaultSort.apiValue(for: .issue) == nil)
        #expect(defaultSort.apiValue(for: .character) == nil)
        #expect(nameAscending.apiValue(for: .movie) == "name:asc")
        #expect(nameDescending.apiValue(for: .volume) == "name:desc")
        
        #expect(dateAscending.apiValue(for: .movie) == "release_date:asc")
        #expect(dateAscending.apiValue(for: .issue) == "cover_date:asc")
        #expect(dateAscending.apiValue(for: .character) == "date_added:asc")
        #expect(dateAscending.apiValue(for: .volume) == "start_year:asc")
        
        #expect(dateDescending.apiValue(for: .volume) == "start_year:desc")
    }
    
    private func baseExpectations(for endpoint: APIEndpoints) {
        #expect(endpoint.baseURL == "https://comicvine.gamespot.com/api")
        #expect(endpoint.method == .get)
        #expect(endpoint.headers.isEmpty)
        #expect(endpoint.urlParams?["format"] == "json")
        #expect(endpoint.urlParams?["api_key"] != nil)
    }
}
