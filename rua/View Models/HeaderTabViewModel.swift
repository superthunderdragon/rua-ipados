//
//  HeaderTabViewModel.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import Combine

// 최상단 헤더의 메뉴 인덱스 클래스
class HeaderTabViewModel: ObservableObject {
    @Published var selectedTab: HeaderTab = .홈
}
