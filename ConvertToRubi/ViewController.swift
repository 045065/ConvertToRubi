//
//  ViewController.swift
//  ConvertToRubi
//
//  Created by 藤枝拓弥 on 2019/07/28.
//  Copyright © 2019 藤枝拓弥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 入力テキスト
    @IBOutlet weak var inputText: UITextField!
    // 出力テキスト
    @IBOutlet weak var outputText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 出力テキストは空に
        outputText.text = ""
    }
    
    @IBAction func convertToRubi(_ sender: UIButton) {
        // request 作成
        var request = URLRequest(url: URL(string: "https://labs.goo.ne.jp/api/hiragana")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let rubiPostData = RubiPostData(app_id: "bc89b86b411dc8f1287f06613298d37c677be7d7736836144061c7e4586cc4a2", request_id: "", sentence: inputText.text!, output_type: "hiragana")
        guard let uploadData = try? JSONEncoder().encode(rubiPostData) else {
            print("fail create Json")
            return
        }
        request.httpBody = uploadData
        
        // request 実行
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
            }
            
            guard let data = data, let jsonData = try? JSONDecoder().decode(RubiResponseData.self, from: data) else {
                print("fail convert to Json")
                return
            }
            print(jsonData.converted)
            DispatchQueue.main.async {
                // ふりがなテキストを出力テキストに
                self.outputText.text = jsonData.converted
            }
        }
        task.resume()
    }
}
