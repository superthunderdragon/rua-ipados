//
//  HeaderView.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: HeaderTabViewModel
    var body: some View {
        HStack(spacing: 0) {
            Image("RUALogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .padding(.horizontal, 32)
            ForEach(HeaderTab.allCases, id: \.self) { tab in
                if(tab == .AI){
                    if(UserDefaults.standard.string(forKey: "userRole") == "teacher") {
                        HStack(spacing: 10) {
                            Image(systemName: iconName(for: tab))
                                .foregroundStyle(viewModel.selectedTab == tab ? Color.ruaBlack : Color(hex: "949596"))
                            Text("AI 컨텐츠 생성")
                                .font(.system(size: 16, weight: viewModel.selectedTab == tab ? .bold : .regular))
                                .foregroundStyle(viewModel.selectedTab == tab ? Color.ruaBlack : Color(hex: "949596"))
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(viewModel.selectedTab == tab ? Color.ruaAccent : Color.clear)
                                .cornerRadius(2),
                            alignment: .bottom
                        )
                        .onTapGesture {
                            viewModel.selectedTab = tab
                        }
                    }
                } else if(tab == .AI튜터 || tab == .대시보드){
                    if(UserDefaults.standard.string(forKey: "userRole") == "student") {
                        HStack(spacing: 10) {
                            Image(systemName: iconName(for: tab))
                                .foregroundStyle(viewModel.selectedTab == tab ? Color.ruaBlack : Color(hex: "949596"))
                            Text(tab.rawValue)
                                .font(.system(size: 16, weight: viewModel.selectedTab == tab ? .bold : .regular))
                                .foregroundStyle(viewModel.selectedTab == tab ? Color.ruaBlack : Color(hex: "949596"))
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(viewModel.selectedTab == tab ? Color.ruaAccent : Color.clear)
                                .cornerRadius(2),
                            alignment: .bottom
                        )
                        .onTapGesture {
                            viewModel.selectedTab = tab
                        }
                    }
                } else {
                    HStack(spacing: 10) {
                        Image(systemName: iconName(for: tab))
                            .foregroundStyle(viewModel.selectedTab == tab ? Color.ruaBlack : Color(hex: "949596"))
                        Text(tab.rawValue)
                            .font(.system(size: 16, weight: viewModel.selectedTab == tab ? .bold : .regular))
                            .foregroundStyle(viewModel.selectedTab == tab ? Color.ruaBlack : Color(hex: "949596"))
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(viewModel.selectedTab == tab ? Color.ruaAccent : Color.clear)
                            .cornerRadius(2),
                        alignment: .bottom
                    )
                    .onTapGesture {
                        viewModel.selectedTab = tab
                    }
                }
            }
            Spacer()
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color(hex: "F7F7F7"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color(hex: "E8E8EA"), lineWidth: 1)
                        )
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color.ruaBlack)
                }
                Text("\(UserDefaults.standard.string(forKey: "username") ?? "김루비")")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.ruaBlack)
            }
            .padding(.trailing, 32)
        }
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(hex: "EAEAEC"))
                .padding(.bottom, -1),
            alignment: .bottom
        )
    }
    
    func iconName(for tab: HeaderTab) -> String {
            switch tab {
            case .홈:
                return "house" + (viewModel.selectedTab == .홈 ? ".fill" : "")
            case .학습하기:
                return "book" + (viewModel.selectedTab == .학습하기 ? ".fill" : "")
            case .대시보드:
                return "chart.bar.xaxis"
            case .AI튜터:
                return "pencil.and.outline"
            case .AI:
                return "pencil.and.outline"
            }
        }
}

#Preview {
    HeaderView(viewModel: HeaderTabViewModel())
}
