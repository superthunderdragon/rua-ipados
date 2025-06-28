//
//  DashboardView.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import SwiftUI

struct DashboardView: View {
    @State private var attendanceDates: [String] = []
    
    var currentWeekDates: [Date] {
        let calendar = Calendar.current
        let today = Date()
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) else { return [] }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: weekInterval.start) }
    }

    var weekLabel: String {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.month, .weekOfMonth], from: today)
        let month = components.month ?? 0
        let week = components.weekOfMonth ?? 0
        return "\(month)월 \(week)주차"
    }

    let weekdaySymbols: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    @StateObject var dashboardViewModel = DashboardViewModel()
    @State var studyTime: String = "1시간 18분"
    @State var progress: Double = 0.0
    @State var correct: Double = 0.0
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
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
                            Text(weekLabel)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(Color.ruaBlack)
//                            Image(systemName: "arrow.right")
//                                .font(.system(size: 14))
//                                .foregroundStyle(Color(hex: "BBBCBD"))
                            
                        }
                        .padding(.top, 24)
                        HStack {
                            ForEach(Array(currentWeekDates.enumerated()), id: \.offset) { index, date in
                                let daySymbol = weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
                                let dayNumber = Calendar.current.component(.day, from: date)
                                let dateString = dateFormatter.string(from: date)
                                let isAttended = attendanceDates.contains(dateString)
                                ZStack {
                                    Circle()
                                        .frame(width: 68, height: 68)
                                        .foregroundStyle(Color(hex: "F2F2F3"))
                                    VStack(spacing: 2) {
                                        Text(daySymbol)
                                            .font(.system(size: 12))
                                            .foregroundStyle(Color.ruaBlack)
                                        Text("\(dayNumber)")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundStyle(Color.ruaBlack)
                                    }
                                    if isAttended {
                                        Image("RubyStamp")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 68, height: 68)
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
                        HStack(spacing: 100) {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(spacing: 6) {
                                    Image(systemName: "lightbulb")
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color.ruaBlack)
                                    Text("수강 진행률")
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color.ruaBlack)
                                }
                                Spacer()
                                DonutChart(progress: progress)
                                    .frame(width: 140, height: 140)
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
                                DonutChart(progress: correct)
                                    .frame(width: 140, height: 140)
                            }
                            .frame(height: 187)
                        }
                        .padding(36)
                        .padding(.horizontal, 40)
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                }
                VStack(alignment: .leading) {
                    Text("총 학습 시간")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.ruaBlack)
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 12) {
                                Spacer()
                                Text("\(studyTime)")
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundStyle(Color.ruaAccent)
                            }
                            .frame(height: 187)
                            Spacer()
                            Image("StudyRuby")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 230)
                                .padding(.trailing, -40)
                                .padding(.bottom, -40)
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
            dashboardViewModel.lmsStudyTimeGet { totalMinutes in
                if let totalMinutes = totalMinutes {
                    let hours = totalMinutes / 60
                    let minutes = totalMinutes % 60
                    let formattedTime = "\(hours)시간 \(minutes)분"
                    self.studyTime = formattedTime
                } else {
                    self.studyTime = "0시간 0분"
                }
            }
            dashboardViewModel.lmsAttendanceGet { atendance in
                print(atendance)
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.attendanceDates = atendance ?? []
                }
            }
            dashboardViewModel.lmsCorrectGet { correctData in
                print(correctData)
                withAnimation(.easeInOut(duration: 1.0)) {
                    correct = Double(Double(correctData ?? 0) / 100.0)
                }
                print("correct", correct)
            }
            dashboardViewModel.lmsProgressGet { progressData in
                print(progressData)
                withAnimation(.easeInOut(duration: 1.0)) {
                    progress = Double(Double(progressData ?? 0) / 100.0)
                }
                print("progress", progress)
            }
        }
    }
}

#Preview(traits: .landscapeRight) {
    DashboardView()
}
