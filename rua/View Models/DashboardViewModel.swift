//
//  DashboardViewModel.swift
//  rua
//
//  Created by 김아인 on 6/29/25.
//

import Foundation
import SwiftUI
import Alamofire

class DashboardViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func lmsStudyTime() {
        isLoading = true
        errorMessage = nil
        let PARAM:Parameters = [
            "metric": "studyTime",
            "value": ["timeMinute": 1]
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")"
        ]
        var url = "https://backend-978489391889.asia-northeast1.run.app/lms/metric"
        AF.request(url, method: .post, parameters: PARAM, encoding: JSONEncoding.default, headers: headers).validate().responseString { response in
            switch response.result {
            case .success(let token):
                print("success")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print(error)
            }
        }
    }
    
    func lmsProgress(subUnitId: String) {
        isLoading = true
        errorMessage = nil
        let PARAM:Parameters = [
            "metric": "progress",
            "value": ["progress": subUnitId]
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")"
        ]
        var url = "https://backend-978489391889.asia-northeast1.run.app/lms/metric"
        AF.request(url, method: .post, parameters: PARAM, encoding: JSONEncoding.default, headers: headers).validate().responseString { response in
            switch response.result {
            case .success(let token):
                print("success")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print(error)
            }
        }
    }
    
    func lmsCorrect(score: Int) {
        isLoading = true
        errorMessage = nil
        let PARAM:Parameters = [
            "metric": "correct",
            "value": ["score": score]
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")"
        ]
        var url = "https://backend-978489391889.asia-northeast1.run.app/lms/metric"
        AF.request(url, method: .post, parameters: PARAM, encoding: JSONEncoding.default, headers: headers).validate().responseString { response in
            switch response.result {
            case .success(let token):
                print("success")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print(error)
            }
        }
    }
    
    func lmsStudyTimeGet(completion: @escaping (Int?) -> Void) {
        isLoading = true
        errorMessage = nil
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")"
        ]
        var url = "https://backend-978489391889.asia-northeast1.run.app/lms/studytime"
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: Dashboard.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let unitList):
                        completion(unitList.result)
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error)
                        completion(nil)
                    }
                }
            }
    }
    
    func lmsAttendanceGet(completion: @escaping ([String]?) -> Void) {
        isLoading = true
        errorMessage = nil
        let PARAM:Parameters = [
            "startTime": ISO8601DateFormatter().string(from: Calendar.current.date(byAdding: .hour, value: 9, to: Date())!)
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")"
        ]
        var url = "https://backend-978489391889.asia-northeast1.run.app/lms/attendance"
        AF.request(url, method: .get, parameters: PARAM, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: DashboardArray.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let unitList):
                        completion(unitList.result)
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error)
                        completion(nil)
                    }
                }
            }
    }
    
    func lmsProgressGet(completion: @escaping (Int?) -> Void) {
        isLoading = true
        errorMessage = nil
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")"
        ]
        var url = "https://backend-978489391889.asia-northeast1.run.app/lms/progress"
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: Dashboard.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let unitList):
                        completion(unitList.result)
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error)
                        completion(nil)
                    }
                }
            }
    }
    
    func lmsCorrectGet(completion: @escaping (Int?) -> Void) {
        isLoading = true
        errorMessage = nil
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")"
        ]
        var url = "https://backend-978489391889.asia-northeast1.run.app/lms/correct"
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: Dashboard.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let unitList):
                        completion(unitList.result)
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error)
                        completion(nil)
                    }
                }
            }
    }
}
