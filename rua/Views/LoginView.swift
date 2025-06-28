//
//  LoginView.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    @Binding var isLogined: Bool
    var userRole: String
    var body: some View {
        HStack {
            Spacer()
            VStack{
                Spacer()
                Image("RUALogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .padding(.bottom, 40)
                if(userRole == "teacher") {
                    Text("선생님용 계정으로 시작하는 상태예요")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                Button(action: {
                    if(UserApi.isKakaoTalkLoginAvailable()) {
                        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                            if let error = error {
                                print(error)
                            }
                            else {
                                print("loginWithKakaoTalk() success.")
                                UserApi.shared.me() {(user, error) in
                                    if let error = error{
                                        print(error)
                                    } else{
                                        UserDefaults.standard.set((user?.id)!, forKey: "loginSession")
                                        if let name = user?.kakaoAccount?.profile?.nickname{
                                            UserDefaults.standard.set(name, forKey: "kakaoNickname")
                                        }
                                        if let profile = user?.kakaoAccount?.profile?.profileImageUrl{
                                            UserDefaults.standard.set(profile, forKey: "kakaoProfile")
                                        }
                                        loginViewModel.login(
                                            kakaoUid: String(user?.id ?? 0),
                                            username: user?.kakaoAccount?.profile?.nickname ?? "Unknown",
                                            userRule: userRole
                                        )
                                    }
                                }
                            }
                        }
                    } else{
                        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                            if let error = error {
                                print(error)
                            }
                            else {
                                print("loginWithKakaoAccount() success.")
                                UserApi.shared.me() {(user, error) in
                                    if let error = error{
                                        print(error)
                                    } else{
                                        UserDefaults.standard.set((user?.id)!, forKey: "loginSession")
                                        if let name = user?.kakaoAccount?.profile?.nickname{
                                            UserDefaults.standard.set(name, forKey: "kakaoNickname")
                                        }
                                        if let profile = user?.kakaoAccount?.profile?.profileImageUrl{
                                            UserDefaults.standard.set(profile, forKey: "kakaoProfile")
                                        }
                                        loginViewModel.login(
                                            kakaoUid: String(user?.id ?? 0),
                                            username: user?.kakaoAccount?.profile?.nickname ?? "Unknown",
                                            userRule: userRole
                                        )
                                    }
                                }
                            }
                        }
                    }
                },label: {
                    HStack{
                        Spacer()
                        Text("카카오 로그인")
                            .foregroundColor(Color(hex: "002465"))
                        Spacer()
                    }
                    .frame(maxWidth: 400)
                    .padding(.vertical, 14)
                    .background(Color(hex: "FFDE02"))
                    .cornerRadius(10)
                })
                Spacer()
            }
            Spacer()
        }
        .onReceive(loginViewModel.$loginToken) { tokens in
            if !tokens.isEmpty {
                withAnimation {
                    isLogined = true
                }
            }
        }
        .background(Color(hex: "EDEEF2"))
    }
}
