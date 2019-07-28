//
//  Rubi.swift
//  ConvertToRubi
//
//  Created by 藤枝拓弥 on 2019/07/28.
//  Copyright © 2019 藤枝拓弥. All rights reserved.
//

import Foundation

// ふりがな変換API Responseデータ
struct RubiResponseData:Codable {
    var request_id: String
    var output_type: String
    var converted: String
}
