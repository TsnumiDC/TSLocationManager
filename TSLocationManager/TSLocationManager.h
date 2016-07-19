//
//  TSLocationManager.h
//  TSLoCationManagerDemo
//
//  Created by Dylan on 7/19/16.
//  Copyright © 2016 Dylan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TSLocationManager : NSObject



+ (instancetype)shareManager;
/**
 *  @param complete
 *   error     error message
 *   addressDic  we can get loation message in the Dictionary
 *   location.coordinate.latitude   经度
 *   location.coordinate.longitude  维度
 */
- (void)startLocatWithCompleteBlock:(void (^)(NSError * error, NSDictionary * addressDic,CLLocation * location))complete;

@end
