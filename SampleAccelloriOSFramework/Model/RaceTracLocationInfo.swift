//
//  RaceTracLocationInfo.swift
//  SampleProject
//
//  Created by Admin on 17/11/23.
//

import Foundation

public struct RaceTracLocationInfo: Codable
{
    public var locationId: Int = 0
    public var city: String = ""
    public var address: String = ""
    public var storeId: String = ""
    public var lat: Float = 0.0
    public var log: Float = 0.0
    public var distance: String = ""
    public var regularPrice: String = ""
    public var dieselPrice: String = ""
}

