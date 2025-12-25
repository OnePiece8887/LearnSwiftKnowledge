//
//  LSDIpConfigModel.swift
//  HandSignedTreasure
//
//  Created by 刘帅 on 2025/12/16.
//  Copyright © 2025 XACA. All rights reserved.
//

import UIKit

struct LSDIpConfigModel: Codable,Identifiable {
    var id: Int?
    var serverID: String?
    var serverName: String?
    var serverAddress: String?
    var status: String?
    var createTime: String?
    var createBy: String?
    var updateTime: String?
    var updateBy: String?
    var isDelete: String?
    var statusName: String?
    /// luohe 漯河卫建委  standard 标准版本
    var systemType: String? 
}
