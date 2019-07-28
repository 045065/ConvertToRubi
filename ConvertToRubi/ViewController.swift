//
//  ViewController.swift
//  ConvertToRubi
//
//  Created by 藤枝拓弥 on 2019/07/28.
//  Copyright © 2019 藤枝拓弥. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class ViewController: UIViewController {
    // 入力テキスト
    @IBOutlet weak var inputText: UITextField!
    // 出力テキスト
    @IBOutlet weak var outputText: UITextView!
    var rubiResponseData: RubiResponseData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 出力テキストは空に
        outputText.text = ""
    }
    
    // ふりがな変換
    @IBAction func convertToRubi(_ sender: UIButton) {
        SVProgressHUD.show()
        ViewController.requestConvertToRubi(sentence: inputText.text!,
                                             success:
            {[weak self] (rubi) in
                SVProgressHUD.dismiss()
                guard let weakSelf = self else { return }
                weakSelf.rubiResponseData = rubi
                weakSelf.displayRubi()
            },
                                             failure:
            {[weak self] (message) in
                SVProgressHUD.dismiss()
                guard let weakSelf = self else { return }
                UIAlertController.showAlert(viewController: weakSelf,
                                            title: "",
                                            message: message,
                                            buttonTitle: "OK",
                                            buttonAction: nil)
        })
    }
    
    // ふりがな変換API Request
    class func requestConvertToRubi(sentence: String,
                              success: @escaping (RubiResponseData)->Void,
                              failure: @escaping (String)->Void) {
        // request 作成
        let rubiPostData = RubiPostData(app_id: "bc89b86b411dc8f1287f06613298d37c677be7d7736836144061c7e4586cc4a2", request_id: "", sentence: sentence, output_type: "hiragana")
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(rubiPostData)
        var request = URLRequest(url: URL(string: "https://labs.goo.ne.jp/api/hiragana")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // request 実行
        Alamofire.request(request).responseJSON { (dataResponse) in
            DispatchQueue.main.async {
                if let error = dataResponse.error {
                    failure(error.localizedDescription)
                    return
                }
                
                if dataResponse.response?.statusCode != 200 {
                    failure("サーバーに接続できません")
                    return
                }
                
                guard let data = dataResponse.data else {
                    failure("結果がありません")
                    return
                }
                
                if let result = try? JSONDecoder().decode(RubiResponseData.self, from: data) {
                    success(result)
                    return
                }
                
                failure("JSONのパースに失敗しました")
            }
        }
    }
    
    // ふりがな変換後のテキストを表示
    private func displayRubi() {
        // ふりがなテキストを出力テキストに
        self.outputText.text = rubiResponseData.converted
    }
}
