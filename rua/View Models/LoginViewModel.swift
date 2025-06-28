//
//  LoginViewModel.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import Foundation
import Alamofire
import SwiftUI

class LoginViewModel: ObservableObject {
    @EnvironmentObject var appState: AppState
    @Published var loginToken: [LoginToken] = []
    @Published var userInformation: [UserInformation] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // 로그인 처리, 카카오 로그인 후 UID와 닉네임 전송
    // 회원가입과 로그인을 한 번에 처리
    func login(kakaoUid: String, username: String, userRule: String) {
        isLoading = true
        errorMessage = nil
        let PARAM:Parameters = [
            "kakaoUid": kakaoUid,
            "username": username
        ]
        let path = userRule == "teacher" ? "/auth/teacher" : "/auth/student"
        var url = "https://backend-978489391889.asia-northeast1.run.app\(path)"
        AF.request(url, method: .post, parameters: PARAM, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: LoginToken.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let token):
                        let headers: HTTPHeaders = [
                            "Authorization": "Bearer \(token.accessToken)"
                        ]
                        url = "https://backend-978489391889.asia-northeast1.run.app/user/me"
                        AF.request(url, method: .get, headers: headers)
                            .validate()
                            .responseDecodable(of: UserInformation.self) { response in
                                DispatchQueue.main.async {
                                    switch response.result {
                                    case .success(let information):
                                        self.userInformation = [information]
                                        print(self.userInformation)
                                        UserDefaults.standard.set(information.username, forKey: "username")
                                        UserDefaults.standard.set(information.role, forKey: "userRole")
                                        print("유저 정보 가져오기!!")
                                        self.loginToken = [token]
                                        print(self.loginToken)
                                        UserDefaults.standard.set(token.accessToken, forKey: "accessToken")
                                        UserDefaults.standard.set(token.refreshToken, forKey: "refreshToken")
                                        print("로그인 성공!!")
                                    case .failure(let error):
                                        self.errorMessage = error.localizedDescription
                                        print(error)
                                    }
                                }
                            }
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error)
                    }
                }
            }
    }
    
    // accessToken 만료 시 refreshToken을 통해 재발급
    func tokenRefresh() {
        isLoading = true
        errorMessage = nil
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "refreshToken") ?? "")"
        ]
        let url = "https://backend-978489391889.asia-northeast1.run.app/auth/refresh"
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: LoginToken.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let token):
                        self.loginToken = [token]
                        print(self.loginToken)
                        UserDefaults.standard.set(token.accessToken, forKey: "accessToken")
                        UserDefaults.standard.set(token.refreshToken, forKey: "refreshToken")
                        print("리프레시 성공!!")
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error)
                    }
                }
            }
    }
}
