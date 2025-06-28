//
//  LectureViewModel.swift
//  rua
//
//  Created by 김아인 on 6/28/25.
//

import Foundation
import Alamofire
import SwiftUI

class LectureViewModel: ObservableObject {
    @Published var units: [Unit] = []
    @Published var subUnits: [SubUnit] = []
    @Published var contents: [Content] = []
    @Published var imageURLs: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // 중단원 컨텐츠 리스트 GET
    func loadUnits() {
        isLoading = true
        errorMessage = nil
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")"
        ]
        let url = "https://backend-978489391889.asia-northeast1.run.app/classroom/unit"
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: UnitListResponse.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let unitList):
                        self.units = unitList.units
                        print(self.units)
                        print("unit 가져오기 성공!!")
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error)
                    }
                }
            }
    }
    
    // 중단원 내 소단원 컨텐츠 리스트 GET
    func loadSubUnits(unitId: String) {
        isLoading = true
        errorMessage = nil
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")"
        ]
        let url = "https://backend-978489391889.asia-northeast1.run.app/classroom/unit/\(unitId)/subunit"
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: SubunitsListResponse.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let unitList):
                        self.subUnits = unitList.subunits
                        print(self.subUnits)
                        print("subunit 가져오기 성공!!")
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error)
                    }
                }
            }
    }
    
    // 소단원 내 이미지 등 다양한 컨텐츠 GET
    func loadContents(subunitId: String) {
        isLoading = true
        errorMessage = nil
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")"
        ]
        let url = "https://backend-978489391889.asia-northeast1.run.app/classroom/subunit/\(subunitId)/content"
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: ContentsListResponse.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let unitList):
                        self.contents = unitList.contents
                        print(self.contents)
                        self.imageURLs = self.contents.map { $0.body }
                        print("content 가져오기 성공!!")
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error)
                    }
                }
            }
    }
}
