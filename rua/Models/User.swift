//
//  User.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

// API 엑세스를 위한 토큰
struct LoginToken: Codable, Identifiable {
    let accessToken: String
    let refreshToken: String
    var id: String { accessToken }
}

// 유저 정보
struct UserInformation: Codable, Identifiable {
    var id: String
    let username: String
    let role: String
}
