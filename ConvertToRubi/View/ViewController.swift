//
//  ViewController.swift
//  ConvertToRubi
//
//  Created by 藤枝拓弥 on 2019/07/28.
//  Copyright © 2019 藤枝拓弥. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol RubiViewInterface: class {
    func showRubi(converted: String)
    func showError(errorMessage: String)
}

class ViewController: UIViewController , RubiViewInterface{
    // 入力テキスト
    @IBOutlet weak var inputText: UITextView!
    
    // 出力テキスト
    @IBOutlet weak var outputText: UITextView!
    
    // ルビAPIのレスポンスデータ
    private var rubiResponseData: RubiResponseData!
    
    // ルビ変換画面Presenter
    private var presenter: RubiPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initPresenter()
    }
    
    // UIの初期化
    private func initUI() {
        // 出力テキストは空に
        outputText.text = ""
    }
    
    // Presenterの初期化
    private func initPresenter() {
        presenter = RubiPresenter(with: self)
    }
    
    // ふりがな変換
    @IBAction func convertToRubi(_ sender: UIButton) {
        SVProgressHUD.show()
        presenter.convertToRubi(sentence: inputText.text!)
    }
    
    // ふりがな変換後テキストを出力
    func showRubi(converted: String) {
        SVProgressHUD.dismiss()
        self.outputText.text = converted
    }
    
    // エラーを出力
    func showError(errorMessage: String) {
        SVProgressHUD.dismiss()
        self.outputText.text = ""
        UIAlertController.showAlert(viewController: self,
                                    title: "",
                                    message: errorMessage,
                                    buttonTitle: Message.Button.OK,
                                    buttonAction: nil)
    }
}
