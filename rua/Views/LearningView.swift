//
//  LearningView.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import SwiftUI
import UIKit

struct LearningView: View {
    @State var imageScale: CGFloat = 1.0
    @State var imageIndex: Int = 0
    let contentTitle: String
    let subunitId: String
    @StateObject var lectureViewModel = LectureViewModel()
    @StateObject var dashboardViewModel = DashboardViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "book")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: "696A6D"))
                        .padding(.leading, 32)
                    Text("학습하기")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: "696A6D"))
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    dismiss()
                }
                Image(systemName: "arrow.right")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(hex: "696A6D"))
                    .padding(.leading, 10)
                Image(systemName: "book.closed.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(hex: "696A6D"))
                    .padding(.leading, 10)
                Text(contentTitle)
                    .font(.system(size: 14))
                    .foregroundStyle(Color(hex: "696A6D"))
                Spacer()
            }
            .padding(.top, 10)
            .padding(.bottom, 18)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(hex: "EAEAEC"))
                    .padding(.bottom, -1),
                alignment: .bottom
            )
            Spacer()
            if(lectureViewModel.imageURLs != [] && lectureViewModel.imageURLs[imageIndex].starts(with: "{") == false) {
                ZoomableScrollView {
                    AsyncImage(url: URL(string: lectureViewModel.imageURLs[imageIndex])) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                if(imageIndex < lectureViewModel.imageURLs.count - 1) {
                                    imageIndex += 1
                                    print(lectureViewModel.imageURLs[imageIndex])
                                }
                                if(imageIndex == lectureViewModel.imageURLs.count - 1) {
                                    dashboardViewModel.lmsProgress(subUnitId: subunitId)
                                }
                            }
                    } placeholder: {
                        ProgressView()
                    }
                }
            } else if(lectureViewModel.imageURLs != [] && lectureViewModel.imageURLs[imageIndex].starts(with: "{") == true) {
                if let data = lectureViewModel.imageURLs[imageIndex].data(using: .utf8) {
                    if let evaluation = try? JSONDecoder().decode(ContentEvaluation.self, from: data) {
                        EvaluationSelectView(contentEvaluation: evaluation)
                    } else {
                        Text("평가 정보를 불러오지 못했습니다.")
                    }
                }
            } else {
                ProgressView()
                    .onAppear {
                        lectureViewModel.loadContents(subunitId: subunitId)
                    }
            }
            Spacer()
            HStack(spacing: 0) {
                ZStack {
                    Circle()
                        .frame(width: 36, height: 36)
                        .foregroundStyle(Color(hex: "F2F2F3"))
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 14, height: 12)
                        .foregroundStyle(Color.ruaBlack)
                }
                .onTapGesture {
                    if(imageIndex > 0) {
                        imageIndex -= 1
                    }
                }
                .padding(.trailing, 32)
                Text("\(imageIndex + 1) / \(lectureViewModel.imageURLs.count)")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.ruaBlack)
                ZStack {
                    Circle()
                        .frame(width: 36, height: 36)
                        .foregroundStyle(Color(hex: "F2F2F3"))
                    Image(systemName: "arrow.right")
                        .resizable()
                        .frame(width: 14, height: 12)
                        .foregroundStyle(Color.ruaBlack)
                }
                .onTapGesture {
                    if(imageIndex < lectureViewModel.imageURLs.count - 1) {
                        imageIndex += 1
                    }
                    if(imageIndex == lectureViewModel.imageURLs.count - 1) {
                        dashboardViewModel.lmsProgress(subUnitId: subunitId)
                    }
                }
                .padding(.leading, 32)
            }
            .padding(.bottom, 10)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    var content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        scrollView.bouncesZoom = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        let hosting = UIHostingController(rootView: content)
        hosting.view.translatesAutoresizingMaskIntoConstraints = true
        hosting.view.frame = scrollView.bounds
        hosting.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.addSubview(hosting.view)

        context.coordinator.hostingController = hosting
        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.hostingController.rootView = content
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>!

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
    }
}
