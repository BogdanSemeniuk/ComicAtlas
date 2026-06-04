//
//  CharacterRepositoryImplTests.swift
//  ComicAtlasTests
//
//  Created by Codex on 04.06.2026.
//

import Foundation
@testable import ComicAtlas
import Testing

@Suite("CharacterRepositoryImpl tests")
struct CharacterRepositoryImplTests {
    @Test
    func fetchCharactersRequestsCharactersEndpoint() async throws {
        let (sut, api) = try makeSUT(fixtureName: "character_list")
        
        _ = try await sut.fetchCharacters(
            limit: 20,
            offset: 40,
            sort: .nameDescending
        )
        
        let request = try #require(await api.requests.first)
        #expect(request.path == "characters/")
        #expect(request.method == .get)
        #expect(request.urlParams?["limit"] == "20")
        #expect(request.urlParams?["offset"] == "40")
        #expect(request.urlParams?["format"] == "json")
        #expect(request.urlParams?["sort"] == "name:desc")
    }
    
    @Test
    func fetchCharactersMapsResponse() async throws {
        let (sut, _) = try makeSUT(fixtureName: "character_list")
        
        let characters = try await sut.fetchCharacters(
            limit: 20,
            offset: 0,
            sort: .default
        )
        
        #expect(characters.count == 3)
        #expect(characters[0].id == 1254)
        #expect(characters[0].name == "Dream Girl")
        #expect(characters[0].description == "description")
        #expect(characters[0].aliases?.contains("Nura Nal") == true)
        #expect(characters[0].realName == "Nura Nal")
        #expect(characters[0].iconUrl == "https://comicvine.gamespot.com/a/uploads/scale_small/2/29837/2422799-dreamgirl_lsh_vol7_04.jpg")
        #expect(characters[0].smallUrl == "https://comicvine.gamespot.com/a/uploads/scale_small/2/29837/2422799-dreamgirl_lsh_vol7_04.jpg")
        #expect(characters[1].id == 1255)
        #expect(characters[1].name == "Brainiac 5")
        #expect(characters[2].id == 1256)
        #expect(characters[2].name == "Invisible Kid")
    }
    
    @Test
    func fetchCharactersPropagatesAPIError() async {
        let (sut, api) = makeSUT(error: TestError.expectedFailure)
        
        await #expect(throws: TestError.expectedFailure) {
            try await sut.fetchCharacters(
                limit: 20,
                offset: 0,
                sort: .default
            )
        }
        
        #expect(await api.requests.count == 1)
    }
    
    @Test
    func fetchCharacterDetailsRequestsDetailsEndpoint() async throws {
        let (sut, api) = try makeSUT(fixtureName: "character_details")
        
        _ = try await sut.fetchCharacterDetails(id: 1490)
        
        let request = try #require(await api.requests.first)
        #expect(request.path == "character/4005-1490/")
        #expect(request.method == .get)
        #expect(request.urlParams?["format"] == "json")
    }
    
    @Test
    func fetchCharacterDetailsMapsResponse() async throws {
        let (sut, _) = try makeSUT(fixtureName: "character_details")
        
        let details = try await sut.fetchCharacterDetails(id: 1490)
        let firstIssueCredit = try #require(details.issueCredits.first)
        
        #expect(details.id == 1490)
        #expect(details.name == "Carnage")
        #expect(details.description == "description")
        #expect(details.aliases?.contains("Cletus Kasady") == true)
        #expect(details.birth == nil)
        #expect(details.characterEnemies.prefix(2) == ["Agent Gao", "Alana"])
        #expect(details.characterFriends.prefix(2) == ["Arthur Krane", "Carrion (McBride)"])
        #expect(details.countOfIssueAppearances == 769)
        #expect(details.dateAdded == "2008-06-06 11:27:42")
        #expect(details.deck?.contains("Carnage is the offspring") == true)
        #expect(details.firstAppearedInIssueName == "Gun From The Heart!")
        #expect(details.firstAppearedInIssueNumber == "345")
        #expect(details.gender == 1)
        #expect(firstIssueCredit.id == 1159638)
        #expect(firstIssueCredit.name == "Death Spiral, Part 4")
        #expect(details.movies == ["Venom: Let There Be Carnage"])
        #expect(details.originName == "Alien")
        #expect(details.powers.prefix(3) == ["Flight", "Super Strength", "Super Speed"])
        #expect(details.publisherName == "Marvel")
        #expect(details.realName == "Carnage")
        #expect(details.siteDetailUrl == "https://comicvine.gamespot.com/carnage/4005-1490/")
        #expect(details.teams == ["Avengers", "Frightful Four", "Sinister Six", "Symbiotes"])
        #expect(details.volumeCredits == ["Homem-Aranha Kids"])
        #expect(details.iconUrl == "https://comicvine.gamespot.com/a/uploads/square_avatar/12/124259/8056391-extreme_carnage_alpha_vol_1_1_lee_retailer_shared_exclusive_virgin_variant.jpg")
        #expect(details.smallUrl == "https://comicvine.gamespot.com/a/uploads/scale_small/12/124259/8056391-extreme_carnage_alpha_vol_1_1_lee_retailer_shared_exclusive_virgin_variant.jpg")
    }
    
    @Test
    func fetchCharacterDetailsPropagatesAPIError() async {
        let (sut, api) = makeSUT(error: TestError.expectedFailure)
        
        await #expect(throws: TestError.expectedFailure) {
            try await sut.fetchCharacterDetails(id: 1490)
        }
        
        #expect(await api.requests.count == 1)
    }
    
    private func makeSUT(
        fixtureName: String
    ) throws -> (sut: CharacterRepository, api: APIClientMock) {
        makeSUT(responseData: try fixtureData(named: fixtureName))
    }
    
    private func makeSUT(
        responseData: Data? = nil,
        error: (any Error)? = nil
    ) -> (sut: CharacterRepository, api: APIClientMock) {
        let api = APIClientMock(
            responseData: responseData,
            error: error
        )
        return (CharacterRepositoryImpl(api: api), api)
    }
    
    private func fixtureData(named name: String) throws -> Data {
        let fixtureURL = URL(filePath: #filePath)
            .deletingLastPathComponent()
            .appending(path: "JSONResponses")
            .appending(path: "\(name).json")
        return try Data(contentsOf: fixtureURL)
    }
}
