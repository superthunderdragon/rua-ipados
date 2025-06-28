//
//  ruaApp.swift
//  rua
//
//  Created by 김아인 on 6/27/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
struct ruaApp: App {
    @StateObject var appState = AppState()
    init() {
        KakaoSDK.initSDK(appKey: "8618e51a81a081c4f9ee930dc37255b3")
    }
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: HeaderTabViewModel())
                .environmentObject(appState)
                .onOpenURL(perform: { url in
                    if(AuthApi.isKakaoTalkLoginUrl(url)){
                        AuthController.handleOpenUrl(url: url)
                    }
                    if(url.absoluteString == "rua://signup/teacher") {
                        appState.signupRole = "teacher"
                    }
                })
        }
    }
}
