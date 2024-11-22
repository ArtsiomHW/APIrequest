//
//  Club.swift
//  APIrequest
//
//  Created by Artem H on 11/21/24.
//


struct Club: Decodable, Hashable {
    let name: String
    let points: Int
    let wins: Int
    let draws: Int
    let losses: Int
    let goalsScored: Int
    let coach: String
}

struct Player: Decodable {
    let name: String
    let team: Club
    let position: String
    let goals: Int
    let assists: Int
    let appearances: Int
    let yellowCards: Int
    let redCards: Int
}
