//
//  EvaluationSelectView.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import SwiftUI

struct EvaluationSelectView: View {
    var contentEvaluation: ContentEvaluation
    @State var seletedAnswer: String = "?"
    @State var seletedAnswerColorList: [[Color]] = [
        [Color.ruaBlack, Color(hex: "E7E9EA"), Color(hex: "F7F7F8")],
        [Color.ruaBlack, Color(hex: "E7E9EA"), Color(hex: "F7F7F8")],
        [Color.ruaBlack, Color(hex: "E7E9EA"), Color(hex: "F7F7F8")],
        [Color.ruaBlack, Color(hex: "E7E9EA"), Color(hex: "F7F7F8")]
    ]
    @StateObject var dashboardViewModel = DashboardViewModel()
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 0) {
                Spacer()
                HStack(alignment: .top) {
                    Image("Ruby")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                    Text("\(contentEvaluation.question)")
                        .font(.system(size: 16))
                        .foregroundStyle(Color.ruaBlack)
                        .padding(12)
                        .background(Color(hex: "F7F7F8"))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: "E7E9EA"), lineWidth: 1)
                        )
                        .padding(.leading, 12)
                    Spacer()
                }
                .frame(width: 800)
                .padding(.bottom, 10)
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(contentEvaluation.contents)")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundStyle(Color.ruaBlack)
                        }
                    }
                    .padding(40)
                    Spacer()
                }
                .frame(width: 800)
                .background(Color(hex: "F7F7F8"))
                .cornerRadius(24)
                .padding(.bottom, 28)
                ForEach(0...1, id: \.self) { indexOuter in
                    HStack(spacing: 28) {
                        ForEach(indexOuter...indexOuter+1, id: \.self) { index in
                            let forIndex: Int = indexOuter + index
                            Text("\(contentEvaluation.selections[forIndex])")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(seletedAnswerColorList[forIndex][0])
                                .padding(.vertical, 12)
                                .frame(width: 386)
                                .background(seletedAnswerColorList[forIndex][2])
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(seletedAnswerColorList[forIndex][1], lineWidth: 1)
                                )
                                .onTapGesture {
                                    seletedAnswerColorList = [[Color.ruaBlack, Color(hex: "E7E9EA"), Color(hex: "F7F7F8")], [Color.ruaBlack, Color(hex: "E7E9EA"), Color(hex: "F7F7F8")], [Color.ruaBlack, Color(hex: "E7E9EA"), Color(hex: "F7F7F8")], [Color.ruaBlack, Color(hex: "E7E9EA"), Color(hex: "F7F7F8")]]
                                    seletedAnswer = contentEvaluation.selections[forIndex]
                                    if(contentEvaluation.answer == contentEvaluation.selections[forIndex]) {
                                        seletedAnswerColorList[forIndex] = [Color(hex: "32CC58"), Color(hex: "32CC58"), Color(hex: "EAF9EE")]
                                        dashboardViewModel.lmsCorrect(score: 1)
                                    } else{
                                        seletedAnswerColorList[forIndex] = [Color(hex: "FE315B"), Color(hex: "FF4035"), Color(hex: "FFEBE9")]
                                        dashboardViewModel.lmsCorrect(score: 0)
                                    }
                                }
                        }
                    }
                    .padding(.bottom, 28)
                }
                Spacer()
            }
            Spacer()
        }
    }
}
