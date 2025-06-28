//
//  Lecture.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

// 중단원
struct Unit: Codable, Identifiable {
    let id: String
    let classroom: String
    let description: String
    let title: String
}

// 중단원 API 응답 저장
struct UnitListResponse: Codable {
    let units: [Unit]
}

// 소단원
struct SubUnit: Codable, Identifiable {
    let id: String
    let description: String
    let title: String
    let code: String
    let unitId: String
}

// 소단원 API 응답 저장
struct SubunitsListResponse: Codable {
    let subunits: [SubUnit]
}

// 컨텐츠
struct Content: Codable, Identifiable {
    let id: String
    let type: String
    let subunitId: String
    let label: String
    let body: String
}

// 컨텐츠 API 응답 저장
struct ContentsListResponse: Codable {
    let contents: [Content]
}

// 컨텐츠 API 응답 저장
struct ContentEvaluation: Codable {
    let message: String
    let question: String
    let contents: String
    let answer: String
    let selections: [String]
}
