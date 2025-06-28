//
//  DashboardView.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import SwiftUI

struct DashboardView: View {
    @State var firstData: Float = 0.0
    @State var secondData: Double = 0.0
    let days: [String] = ["화", "수", "목", "금", "토", "일", "월"]
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 80) {
                Spacer()
                HStack(spacing: 24) {
                    ZStack {
                        Circle()
                            .frame(width: 72, height: 72)
                            .foregroundStyle(Color(hex: "F7F7F7"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color(hex: "E8E8EA"), lineWidth: 1)
                            )
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .foregroundStyle(Color.ruaBlack)
                    }
                    Text("\(UserDefaults.standard.string(forKey: "username") ?? "김루비") 학생")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundStyle(Color.ruaBlack)
                }
                VStack(alignment: .leading) {
                    Text("출석 현황")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.ruaBlack)
                    VStack(spacing: 0) {
                        HStack(spacing: 16) {
//                            Image(systemName: "arrow.left")
//                                .font(.system(size: 14))
//                                .foregroundStyle(Color(hex: "BBBCBD"))
                            Text("7월 1주차")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(Color.ruaBlack)
//                            Image(systemName: "arrow.right")
//                                .font(.system(size: 14))
//                                .foregroundStyle(Color(hex: "BBBCBD"))
                            
                        }
                        .padding(.top, 24)
                        HStack {
                            ForEach(1...7, id: \.self) { index in
                                ZStack {
                                    Circle()
                                        .frame(width: 68, height: 68)
                                        .foregroundStyle(Color(hex: "F2F2F3"))
                                    VStack(spacing: 2) {
                                        Text("\(days[index - 1])")
                                            .font(.system(size: 12))
                                            .foregroundStyle(Color.ruaBlack)
                                        Text("\(index)")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundStyle(Color.ruaBlack)
                                    }
                                }
                            }
                        }
                        .padding(24)
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                }
                Spacer()
            }
            .padding(.bottom, 80)
            HStack(spacing: 48) {
                Spacer()
                VStack(alignment: .leading) {
                    Text("학습 정보")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.ruaBlack)
                    VStack(spacing: 0) {
                        HStack(spacing: 80) {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(spacing: 6) {
                                    Image(systemName: "book")
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color.ruaBlack)
                                    Text("문제 풀이")
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color.ruaBlack)
                                }
                                Spacer()
                                Text("12/15")
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundStyle(Color.ruaAccent)
                                ProgressBar(value: firstData)
                                    .frame(width: 229, height: 9)
                            }
                            .frame(height: 187)
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(spacing: 6) {
                                    Image(systemName: "lightbulb")
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color.ruaBlack)
                                    Text("정답률")
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color.ruaBlack)
                                }
                                Spacer()
                                DonutChart(progress: secondData)
                                    .frame(width: 140, height: 140)
                            }
                            .frame(height: 187)
                        }
                        .padding(36)
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                }
                VStack(alignment: .leading) {
                    Text("총 학습 시간")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.ruaBlack)
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 80) {
                            VStack(alignment: .leading, spacing: 12) {
                                Spacer()
                                Text("6시간 36분")
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundStyle(Color.ruaAccent)
                            }
                            .frame(height: 187)
                            Spacer()
                        }
                        .padding(36)
                    }
                    .frame(width: 500)
                    .background(Color.white)
                    .cornerRadius(16)
                }
                Spacer()
            }
            Spacer()
        }
        .background(Color(hex: "EDEEF2"))
        .onAppear {
            withAnimation(.easeInOut(duration: 1.6)) {
                firstData = 0.8
                secondData = 0.8
            }
        }
    }
}

#Preview(traits: .landscapeRight) {
    DashboardView()
}
