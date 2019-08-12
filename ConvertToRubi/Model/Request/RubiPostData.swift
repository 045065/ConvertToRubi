//
//  RubiPostData.swift
//  ConvertToRubi
//
//  Created by 藤枝拓弥 on 2019/07/28.
//  Copyright © 2019 藤枝拓弥. All rights reserved.
//

// ふりがな変換API Requestデータ
struct RubiPostData: Codable {
    var app_id: String
    var request_id: String
    var sentence: String
    var output_type: String
}
