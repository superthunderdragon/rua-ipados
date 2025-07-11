//
//  AIContentCreateView.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import SwiftUI
import WebKit

struct AIContentCreateView: View {
    @Binding var chatHis: [String]
    @StateObject var aiContentViewModel = AIContentViewModel()
    @State private var imageOffset: CGSize = .zero
    @State var chat: String = ""
    @State private var showWebView: Bool = false
    @State private var selectedURL: URL? = nil
    var body: some View {
        HStack {
            Spacer()
            VStack {
                ScrollViewReader { proxy in
                    GeometryReader { gr in
                        ScrollView() {
                            Spacer()
                            VStack(alignment: .leading) {
                                ForEach(chatHis, id: \.self) { history in
                                    if (history.starts(with: "GEMINI: ")){
                                        if (history.starts(with: "GEMINI: 교육 컨텐츠 생성에 실패했어요. ")) {
                                            HStack {
                                                Text(history.description.replacingOccurrences(of: "GEMINI: ", with: ""))
                                                    .padding(.vertical, 13)
                                                    .foregroundStyle(Color(hex: "FF3B2F"))
                                                    .padding(.leading, 36)
                                                    .padding(.trailing, 100)
                                                    .id(history)
                                                Spacer()
                                            }
                                        } else if(history.starts(with: "GEMINI: api.slidesgpt.com")) {
                                            HStack {
                                                Button(action: {
                                                    if let url = URL(string: "https://" + history.description.replacingOccurrences(of: "GEMINI: ", with: "")) {
                                                        selectedURL = url
                                                        showWebView = true
                                                    }
                                                }, label: {
                                                    VStack(alignment: .leading, spacing: 0) {
                                                        Text("요청하신 교육자료가 생성되었어요.")
                                                            .foregroundStyle(Color.ruaBlack)
                                                        Text("교육자료 확인하기")
                                                            .foregroundStyle(Color.blue)
                                                    }
                                                    .padding(.vertical, 13)
                                                    .padding(.leading, 36)
                                                    .padding(.trailing, 100)
                                                    .id(history)
                                                })
                                                Spacer()
                                            }
                                        } else {
                                            HStack {
                                                Text(history.description.replacingOccurrences(of: "GEMINI: ", with: ""))
                                                    .padding(.vertical, 13)
                                                    .foregroundStyle(Color.ruaBlack)
                                                    .padding(.leading, 36)
                                                    .padding(.trailing, 100)
                                                    .id(history)
                                                Spacer()
                                            }
                                        }
                                    } else {
                                        HStack {
                                            Spacer()
                                            Text(history.description.replacingOccurrences(of: "나: ", with: ""))
                                                .padding(.vertical, 13)
                                                .foregroundStyle(Color.ruaBlack)
                                                .cornerRadius(15)
                                                .padding(.leading, 100)
                                                .padding(.trailing, 36)
                                                .id(history)
                                        }
                                    }
                                }
                                if let last = chatHis.last, last.starts(with: "나:") {
                                    VStack(alignment: .leading) {
                                        Image("Ruby")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100)
                                            .offset(imageOffset)
                                            .padding(.trailing, 80)
                                            .onAppear {
                                                withAnimation(.easeInOut(duration: 1.4)) {
                                                    imageOffset = CGSize(width: CGFloat.random(in: 0...30), height: CGFloat.random(in: -30...0))
                                                }
                                                Timer.scheduledTimer(withTimeInterval: 1.4, repeats: true) { _ in
                                                    withAnimation(.easeInOut(duration: 1.4)) {
                                                        imageOffset = CGSize(width: CGFloat.random(in: 0...30), height: CGFloat.random(in: -30...0))
                                                    }
                                                }
                                            }
                                        HStack {
                                            Text("루비와 Gemini가 교육 컨텐츠를 만들고 있어요..")
                                                .font(.system(size: 14))
                                                .foregroundStyle(Color(hex: "8C8D8F"))
                                            ProgressView()
                                            Spacer()
                                        }
                                        .padding(.leading, 36)
                                    }
                                }
                            }
                        }
                        .onChange(of: chatHis) { _ in
                            if let last = chatHis.last {
                                withAnimation {
                                    proxy.scrollTo(last, anchor: .bottom)
                                }
                            }
                        }
                        .onChange(of: aiContentViewModel.aiReturn) { _ in
                            if !aiContentViewModel.aiReturn.isEmpty {
                                chatHis.append("GEMINI: " + aiContentViewModel.aiReturn)
                                aiContentViewModel.aiReturn = ""
                            }
                        }
                        .frame(minHeight: gr.size.height)
                    }
                }
                .sheet(isPresented: $showWebView) {
                    if let url = selectedURL {
                        AuthWebView(url: url)
                    }
                }
                VStack{
                    HStack{
                        TextField("", text: $chat, prompt: Text("메시지 입력").foregroundStyle(Color(hex: "B6B9C0")).fontWeight(.bold),axis:.vertical)
                            .foregroundStyle(Color.black)
                            .padding(.horizontal,16)
                        Button(action:{
                            chatHis.append("나: " + chat)
                            aiContentViewModel.loadGemini(question: chat)
                            chat = ""
                        },label:{
                            ZStack{
                                Circle()
                                    .padding(.horizontal,16)
                                    .foregroundStyle(
                                        chat == "" ?
                                        LinearGradient(colors: [Color(hex: "D5FAE8"), Color(hex: "B4EDE5")], startPoint: .top, endPoint: .bottom) : LinearGradient(colors: [Color(hex: "79EEB5"), Color(hex: "08C2A7")], startPoint: .top, endPoint: .bottom)
                                    )
                                    .frame(width:70)
                                Image(systemName: "arrow.right")
                                    .foregroundStyle(Color.white)
                            }
                        })
                        .disabled(chat == "" ? true : false)
                    }
                    .padding(.vertical, 10)
                }
                .background(Color.white)
                .cornerRadius(15)
                .padding(.horizontal,16)
                .padding(.bottom, 10)
                .shadow(color: Color(hex: "EBEBEB"), radius: 5, x: 0, y: 0)
                Text("루비가 Google Gemini를 사용하여 교육 컨텐츠를 생성합니다. AI 답변은 부정확할 수 있습니다.")
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: "8C8D8F"))
            }
            .frame(width: 800)
            Spacer()
        }
    }
}

struct AuthWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        var request = URLRequest(url: url)
        request.setValue("Bearer iej2jnbyithl02o67061ygnlouxj9ju8", forHTTPHeaderField: "Authorization")
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
