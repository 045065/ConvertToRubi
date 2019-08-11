//
//  RubiPresenter.swift
//  ConvertToRubi
//
//  Created by 藤枝拓弥 on 2019/08/11.
//  Copyright © 2019 藤枝拓弥. All rights reserved.
//

import Foundation
import Alamofire

protocol RubiPresenterInterface: class {
    func requestConvertToRubi(sentence: String)
}

class RubiPresenter: RubiPresenterInterface{
    weak var view: RubiViewInterface?
    
    init(with view: RubiViewInterface) {
        self.view = view
    }
    
    // ふりがな変換API Request
    func requestConvertToRubi(sentence: String) {
        // Request 作成
        let rubiPostData = RubiPostData(
            app_id: "bc89b86b411dc8f1287f06613298d37c677be7d7736836144061c7e4586cc4a2",
            request_id: "",
            sentence: sentence,
            output_type: "hiragana")
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(rubiPostData)
        var request = URLRequest(url: URL(string: "https://labs.goo.ne.jp/api/hiragana")!)
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Request 実行
        Alamofire.request(request).responseJSON { (dataResponse) in
            DispatchQueue.main.async {
                if let error = dataResponse.error {
                    self.view?.showError(errorMessage: error.localizedDescription)
                    return
                }
                
                if dataResponse.response?.statusCode != 200 {
                    self.view?.showError(errorMessage: "サーバーに接続できません")
                    return
                }
                
                guard let data = dataResponse.data else {
                    self.view?.showError(errorMessage: "結果がありません")
                    return
                }
                
                if let result = try? JSONDecoder().decode(RubiResponseData.self, from: data) {
                    self.view?.showRubi(converted: result.converted)
                    return
                }
                
                self.view?.showError(errorMessage: "JSONのパースに失敗しました")
            }
        }
    }
}
