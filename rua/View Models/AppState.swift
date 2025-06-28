//
//  AppState.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import Combine

// 교사 회원가입 딥링크 처리를 위한 클래스
class AppState: ObservableObject {
    @Published var signupRole: String? = nil
}
