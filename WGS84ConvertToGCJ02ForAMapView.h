//
//  WGS84ConvertToGCJ02ForAMapView.h
//  ATT考勤
//
//  Created by Helen on 17/2/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface WGS84ConvertToGCJ02ForAMapView : NSObject

//判断是否已经超出中国范围
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;
//转GCJ-02
+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;

@end
