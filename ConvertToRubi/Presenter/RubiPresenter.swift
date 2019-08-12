//
//  RubiPresenter.swift
//  ConvertToRubi
//
//  Created by 藤枝拓弥 on 2019/08/11.
//  Copyright © 2019 藤枝拓弥. All rights reserved.
//

import Alamofire

protocol RubiPresenterInterface: class {
    func convertToRubi(sentence: String)
}

class RubiPresenter: RubiPresenterInterface{
    weak private var view: RubiViewInterface?
    
    init(with view: RubiViewInterface) {
        self.view = view
    }
    
    // ふりがな変換API Request
    func requestConvertToRubi(sentence: String,
                              success: @escaping (RubiResponseData)->Void,
                              failure: @escaping (String)->Void) {
        // 入力文字が空の場合
        if sentence.isEmpty {
            failure(Message.Error.NO_INPUT_TEXT)
            return
        }
        
        // Request 作成
        let rubiPostData = RubiPostData(
            app_id: GooAPI.APP_ID,
            request_id: GooAPI.Rubi.REQUEST_ID,
            sentence: sentence,
            output_type: GooAPI.Rubi.OUTPUT_TYPE)
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(rubiPostData)
        var request = URLRequest(url: URL(string: GooAPI.Rubi.URL)!)
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(HeaderField.JSON, forHTTPHeaderField: HeaderField.CONTENT_TYPE)
        request.httpBody = jsonData
        
        // Request 実行
        Alamofire.request(request).responseJSON { (dataResponse) in
            if let error = dataResponse.error {
                failure(error.localizedDescription)
                return
            }
            if dataResponse.response?.statusCode != 200 {
                failure(Message.Error.CANT_CONNECT_SERVER)
                return
            }
            guard let data = dataResponse.data else {
                failure(Message.Error.NO_RESPONSE_DATA)
                return
                
            }
            guard let result = try? JSONDecoder().decode(RubiResponseData.self, from: data) else {
                failure(Message.Error.FAILED_JSON_PARSE)
                return
                
            }
            success(result)
        }
    }
    
    // ふりがな変換
    func convertToRubi(sentence: String) {
        requestConvertToRubi(sentence: sentence,
                             success:
            {[weak self] (result) in
                guard let weakSelf = self else { return }
                weakSelf.view?.showRubi(converted: result.converted)
                
            },
                             failure:
            {[weak self] (message) in
                guard let weakSelf = self else { return }
                weakSelf.view?.showError(errorMessage: message)
        })
    }
}
