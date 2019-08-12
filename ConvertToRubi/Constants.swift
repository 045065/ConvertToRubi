//
//  Constants.swift
//  ConvertToRubi
//
//  Created by 藤枝拓弥 on 2019/08/11.
//  Copyright © 2019 藤枝拓弥. All rights reserved.
//

struct GooAPI {
    static let APP_ID = "bc89b86b411dc8f1287f06613298d37c677be7d7736836144061c7e4586cc4a2"
    
    struct Rubi {
        static let URL = "https://labs.goo.ne.jp/api/hiragana"
        static let REQUEST_ID = ""
        static let OUTPUT_TYPE = "hiragana"
    }
}

struct HeaderField {
    static let CONTENT_TYPE =  "Content-Type"
    static let JSON =  "application/json"
}

struct Message {
    struct Error {
        static let NO_INPUT_TEXT = "文字が入力されていません"
        static let CANT_CONNECT_SERVER = "サーバーに接続できません"
        static let NO_RESPONSE_DATA = "結果がありません"
        static let FAILED_JSON_PARSE = "JSONのパースに失敗しました"
    }
    
    struct Button {
        static let OK = "OK"
    }
}
