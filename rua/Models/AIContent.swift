//
//  AIContent.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

// AI 교육 컨텐츠 생성 응답
struct AIContent: Codable, Identifiable {
    let result: String
    var id: String { result }
}

// AI 교육 컨텐츠 생성(슬라이드) 응답
struct AISlide: Codable, Identifiable {
    let id: String
    let embed: String
    let download: String
}
