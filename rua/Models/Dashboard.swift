//
//  Dashboard.swift
//  rua
//
//  Created by 김아인 on 6/29/25.
//

// 대시보드
struct Dashboard: Codable, Identifiable {
    let result: Int
    var id: Int { result }
}

// 대시보드 배열
struct DashboardArray: Codable, Identifiable {
    let result: [String]
    var id: String { result[0] }
}
