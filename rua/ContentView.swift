//
//  ContentView.swift
//  rua
//
//  Created by 김아인 on 6/27/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    static let ruaBlack = Color(hex: "292A2E")
    static let ruaAccent = Color(hex: "02BBA2")
    static let ruaIndigo = Color(hex: "5B59DE")
}

struct ProgressBar: View {
    let value: Float
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(hex: "E8ECF8"))
                
                RoundedRectangle(cornerRadius: 9).frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.ruaAccent)
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

struct DonutChart: View {
    var progress: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(hex: "FAFAFA"), lineWidth: 8)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.ruaAccent,
                    style: StrokeStyle(lineWidth: 16, lineCap: .butt)
                )
                .rotationEffect(.degrees(-90))
                .scaleEffect(x: -1, y: 1)
            Text("80%")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(Color.ruaAccent)
        }
    }
}

struct ContentView: View {
    @State var chatHis: [String] = ["GEMINI: 안녕하세요! 어떤 교육 컨텐츠를 만들고 싶으신가요? 원하시는 내용을 말씀해 보세요!"]
    @State var isLogined: Bool = UserDefaults.standard.string(forKey: "accessToken") != nil
    @ObservedObject var viewModel: HeaderTabViewModel
    @EnvironmentObject var appState: AppState
    @StateObject var loginViewModel = LoginViewModel()
    var body: some View {
        if(isLogined == true) {
            VStack {
                HeaderView(viewModel: viewModel)
                switch viewModel.selectedTab {
                case .홈:
                    HomeView(viewModel: viewModel)
                case .학습하기:
                    LearningListView()
                case .대시보드:
                    DashboardView()
                case .AI:
                    AIContentCreateView(chatHis: $chatHis)
//                case .형성평가:
//                    EvaluationSelectView()
//                case .테스트1:
//                    EvaluationSelectView()
//                case .테스트2:
//                    LearningView(contentTitle: "테스트2", subunitId: "123")
                default:
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .onAppear {
                loginViewModel.tokenRefresh()
            }
        } else {
            if let role = appState.signupRole {
                LoginView(isLogined: $isLogined, userRole: role)
                    .environmentObject(appState)
                    
            } else {
                LoginView(isLogined: $isLogined, userRole: "student")
                    .environmentObject(appState)
            }
        }
    }
}

#Preview(traits: .landscapeRight) {
    ContentView(viewModel: HeaderTabViewModel())
        .environmentObject(AppState())
}
