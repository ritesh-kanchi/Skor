//
//  Score+CoreDataProperties.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/3/20.
//
//

import Foundation
import CoreData


extension Score: Identifiable, Encodable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var teamColor: Int16
    @NSManaged public var totalScore: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var teamNumber: String?
    @NSManaged public var matchNumber: String?
    @NSManaged public var date: Date?
    @NSManaged public var notes: String?
    
    @NSManaged public var autonWobble: Bool
    @NSManaged public var autonWobble2: Bool
    @NSManaged public var autonLaunch: Bool
    @NSManaged public var autonLow: Int16
    @NSManaged public var autonMiddle: Int16
    @NSManaged public var autonPower: Int16
    @NSManaged public var autonHigh: Int16
    
    @NSManaged public var teleLow: Int16
    @NSManaged public var teleMiddle: Int16
    @NSManaged public var teleHigh: Int16
    
    @NSManaged public var endWobble: Int16
    @NSManaged public var endWobble2: Int16
    @NSManaged public var endSupport: Int16
    @NSManaged public var endPower: Int16
    
    private enum CodingKeys: String, CodingKey { case color,score,id,teamNumber,matchNumber,date,aWob,aWob2,aLaun,aLow,aMid,aHigh,aPow,tLow,tMid,tHigh,ePow,eWob,eWob2,eSup, note }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(teamColor, forKey: .color)
        try container.encode(totalScore, forKey: .score)
        try container.encode(id, forKey: .id)
        try container.encode(teamNumber, forKey: .teamNumber)
        try container.encode(matchNumber, forKey: .matchNumber)
        try container.encode(date, forKey: .date)
        try container.encode(notes, forKey: .note)
        
        try container.encode(autonWobble, forKey: .aWob)
        try container.encode(autonWobble2, forKey: .aWob2)
        try container.encode(autonLow, forKey: .aLow)
        try container.encode(autonMiddle, forKey: .aMid)
        try container.encode(autonHigh, forKey: .aHigh)
        try container.encode(autonPower, forKey: .aPow)
        try container.encode(autonLaunch, forKey: .aLow)
        
        try container.encode(teleLow, forKey: .tLow)
        try container.encode(teleMiddle, forKey: .tMid)
        try container.encode(teleHigh, forKey: .tHigh)
        
        try container.encode(endPower, forKey: .ePow)
        try container.encode(endWobble, forKey: .eWob)
        try container.encode(endWobble2, forKey: .eWob2)
        try container.encode(endSupport, forKey: .eSup)
        
    }

}

