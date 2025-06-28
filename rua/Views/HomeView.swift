//
//  HomeView.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import SwiftUI

struct HomeView: View {
    @State private var imageOffset: CGSize = .zero
    @ObservedObject var viewModel: HeaderTabViewModel
    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("👋 안녕하세요, ")
                        .font(.system(size: 48))
                        .foregroundStyle(Color(hex: "646569"))
                    +
                    Text("\(UserDefaults.standard.string(forKey: "username") ?? "김루비") \(UserDefaults.standard.string(forKey: "userRole") ?? "student" == "teacher" ? "선생님" : "학생")!")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundStyle(Color.ruaBlack)
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("내가 속한 교실")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(Color.ruaBlack)
                                .padding(.bottom, 24)
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    HStack {
                                        Image(systemName: "graduationcap.fill")
                                            .font(.system(size: 16))
                                            .foregroundStyle(Color.ruaBlack)
                                        Text("의성미래교육지구 단촌초등학교")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundStyle(Color.ruaBlack)
                                    }
                                    .padding(.bottom, 6)
                                    Text("백경애 교장선생님")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color(hex: "8C8D8F"))
                                }
                                .padding(16)
                                Spacer()
                            }
                            .background(Color(hex: "EFEFF0"))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "E1E1E4"), lineWidth: 1)
                            )
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.selectedTab = .학습하기
                            }
                        }
                        .padding(28)
                        Spacer()
                    }
                    .frame(maxWidth: 578)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.bottom, 28)
                    .padding(.top, 40)
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("추천 강의")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(Color.ruaBlack)
                                .padding(.bottom, 24)
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    HStack {
                                        Image(systemName: "book.closed.fill")
                                            .font(.system(size: 16))
                                            .foregroundStyle(Color.ruaBlack)
                                        Text("[사회 4-2] 인문환경과 인간생활 - 도시와 촌락")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundStyle(Color.ruaBlack)
                                    }
                                    .padding(.bottom, 6)
                                    Text("도시와 촌락은 입지, 기능, 공간 구조와 경관 등의 측면에서 다양한 유형이 존재하며, 의성 단촌면의 사례를 보여 살펴본다.")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color(hex: "8C8D8F"))
                                }
                                .padding(16)
                                Spacer()
                            }
                            .background(Color(hex: "EFEFF0"))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "E1E1E4"), lineWidth: 1)
                            )
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.selectedTab = .학습하기
                            }
                            .padding(.bottom, 24)
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    HStack {
                                        Image(systemName: "book.closed.fill")
                                            .font(.system(size: 16))
                                            .foregroundStyle(Color.ruaBlack)
                                        Text("[국어 6-2] 의성군 소재 소설 읽기 - 인물, 사건, 배경 파악")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundStyle(Color.ruaBlack)
                                    }
                                    .padding(.bottom, 6)
                                    Text("만취당기 소설을 읽고, 소설 속에 나온 의성군의 배경에 대해 알아본다.")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color(hex: "8C8D8F"))
                                }
                                .padding(16)
                                Spacer()
                            }
                            .background(Color(hex: "EFEFF0"))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "E1E1E4"), lineWidth: 1)
                            )
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.selectedTab = .학습하기
                            }
                        }
                        .padding(28)
                        Spacer()
                    }
                    .frame(maxWidth: 578)
                    .background(Color.white)
                    .cornerRadius(20)
                }
                .padding(.leading, 80)
                Spacer()
                Image("Ruby")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400)
                    .scaleEffect(x: -1, y: 1)
                    .offset(imageOffset)
                    .padding(.trailing, 80)
            }
            Spacer()
        }
        .background(Color(hex: "EDEEF2"))
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0)) {
                imageOffset = CGSize(width: CGFloat.random(in: -80...80), height: CGFloat.random(in: -80...80))
            }
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 2.0)) {
                    imageOffset = CGSize(width: CGFloat.random(in: -80...80), height: CGFloat.random(in: -80...80))
                }
            }
        }
    }
}
