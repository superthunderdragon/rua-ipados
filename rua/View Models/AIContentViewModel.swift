//
//  AIContentViewModel.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import Foundation
import Alamofire
import SwiftUI

class AIContentViewModel: ObservableObject {
    @Published var aiReturn: String = ""
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 300 // 5 minutes
        return Session(configuration: configuration)
    }()
    
    // Gemini 교육 컨텐츠 생성
    func loadGemini(question: String) {
        let PARAM:Parameters = [
            "question": question
        ]
        let url = "https://backend-aitutor-978489391889.asia-northeast1.run.app/teacher"
        self.session.request(url, method: .post, parameters: PARAM, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: AIContent.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let aireturn):
                        self.aiReturn = aireturn.result
                        print(self.aiReturn)
                        print("aicontent 가져오기 성공!!")
                    case .failure(let error):
                        self.aiReturn = "교육 컨텐츠 생성에 실패했어요. " + error.localizedDescription
                        print(error, error.localizedDescription)
                    }
                }
            }
    }
    
    // Gemini AI 튜터 채팅
    func chatGemini(question: String) {
        let PARAM:Parameters = [
            "question": question
        ]
        let url = "https://backend-aitutor-978489391889.asia-northeast1.run.app/student"
        self.session.request(url, method: .post, parameters: PARAM, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: AIContent.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let aireturn):
                        self.aiReturn = aireturn.result
                        print(self.aiReturn)
                        print("aitutor 가져오기 성공!!")
                    case .failure(let error):
                        self.aiReturn = "Gemini의 응답을 받아오는 데 실패했어요. " + error.localizedDescription
                        print(error, error.localizedDescription)
                    }
                }
            }
    }
}
