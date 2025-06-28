//
//  LearningListView.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import SwiftUI

struct LearningListView: View {
    let tabItems: [[String]] = [["강의 목록", "books.vertical.fill"], ["과제 현황", "list.clipboard"], ["인원 목록", "person.2"], ["학급 관리", "person.2.badge.gearshape"]]
    @State var seletedUnit: String = ""
    @StateObject var lectureViewModel = LectureViewModel()
    var body: some View {
        NavigationStack {
            VStack{
                HStack(spacing: 0) {
                    ForEach(0...3, id: \.self) { index in
                        HStack(spacing: 10) {
                            Image(systemName: tabItems[index][1])
                                .foregroundStyle(index == 0 ? Color.ruaBlack : Color(hex: "949596"))
                            Text(tabItems[index][0])
                                .font(.system(size: 16, weight: index == 0 ? .bold : .regular))
                                .foregroundStyle(index == 0 ? Color.ruaBlack : Color(hex: "949596"))
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(index == 0 ? Color.ruaAccent : Color.clear)
                                .cornerRadius(2),
                            alignment: .bottom
                        )
                    }
                    Spacer()
                }
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(hex: "EAEAEC"))
                        .padding(.bottom, -1),
                    alignment: .bottom
                )
                ScrollView {
                    VStack(alignment: .leading, spacing: 26) {
                        GeometryReader { geometry in
                            HStack(alignment: .top) {
                                VStack(spacing: 10) {
                                    ForEach(lectureViewModel.units) { unit in
                                        HStack {
                                            VStack(alignment: .leading, spacing: 0) {
                                                HStack {
                                                    Image(systemName: "book.closed.fill")
                                                        .font(.system(size: 16))
                                                        .foregroundStyle(Color.ruaBlack)
                                                    Text(unit.title)
                                                        .font(.system(size: 16, weight: .bold))
                                                        .foregroundStyle(Color.ruaBlack)
                                                }
                                                .padding(.bottom, 6)
                                                Text(unit.description)
                                                    .font(.system(size: 14))
                                                    .foregroundStyle(Color(hex: "8C8D8F"))
                                            }
                                            Spacer()
                                            Image(systemName: "arrow.right")
                                                .font(.system(size: 14))
                                                .foregroundStyle(Color.ruaBlack)
                                        }
                                        .frame(width: (geometry.size.width / 2) - 80)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 12)
                                        .background(seletedUnit == unit.id ? Color(hex: "F7F7F7") : Color.clear)
                                        .cornerRadius(8)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            lectureViewModel.loadSubUnits(unitId: unit.id)
                                            seletedUnit = unit.id
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                                VStack(spacing: 10) {
                                    ForEach(lectureViewModel.subUnits) { subunit in
                                        NavigationLink(destination: LearningView(contentTitle: subunit.title, subunitId: subunit.id)) {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 0) {
                                                    HStack {
                                                        Image(systemName: "book.closed.fill")
                                                            .font(.system(size: 16))
                                                            .foregroundStyle(Color.ruaBlack)
                                                        Text(subunit.title)
                                                            .font(.system(size: 16, weight: .bold))
                                                            .foregroundStyle(Color.ruaBlack)
                                                    }
                                                    .padding(.bottom, 6)
                                                    Text(subunit.description)
                                                        .font(.system(size: 14))
                                                        .foregroundStyle(Color(hex: "8C8D8F"))
                                                }
                                                Spacer()
                                                Image(systemName: "arrow.right")
                                                    .font(.system(size: 14))
                                                    .foregroundStyle(Color.ruaBlack)
                                            }
                                            .frame(width: (geometry.size.width / 2) - 80)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 12)
                                            .contentShape(Rectangle())
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .onAppear {
                lectureViewModel.loadUnits()
            }
        }
    }
}

#Preview {
    LearningListView()
}
