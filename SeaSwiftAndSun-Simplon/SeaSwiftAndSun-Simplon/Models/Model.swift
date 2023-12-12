//
//  Model.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Keyhan Mortezaeifar on 12/12/2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Destinations: Codable {
    let records: [Record]
}

// MARK: - Record
struct Record: Codable {
    let id: String
    let createdTime: String
    let fields: Fields
}

// MARK: - Fields
struct Fields: Codable {
    let difficultyLevel: Int
    let surfBreak: [String]
    let magicSeaweedLink: String
    let photos: [Photo]
    let peakSurfSeasonBegins: String
    let destinationStateCountry: String
    let peakSurfSeasonEnds: String
    let destination: String
    let influencers: [String]
    let address: String

    enum CodingKeys: String, CodingKey {
        case difficultyLevel = "Difficulty Level"
        case surfBreak = "Surf Break"
        case magicSeaweedLink = "Magic Seaweed Link"
        case photos = "Photos"
        case peakSurfSeasonBegins = "Peak Surf Season Begins"
        case destinationStateCountry = "Destination State/Country"
        case peakSurfSeasonEnds = "Peak Surf Season Ends"
        case destination = "Destination"
        case influencers = "Influencers"
        case address = "Address"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let id: String
    let width: Int
    let height: Int
    let url: String
    let filename: String
    let size: Int
    let type: String
}
