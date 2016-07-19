//
//  TSLocationManager.m
//  TSLoCationManagerDemo
//
//  Created by Dylan on 7/19/16.
//  Copyright © 2016 Dylan. All rights reserved.
//

#import "TSLocationManager.h"

@interface TSLocationManager()<CLLocationManagerDelegate>
//used to trans information
//用与传值
@property (strong,nonatomic)void (^TSTempBlock)(NSError * error, NSDictionary * addressDic,CLLocation * addressCode);

//locationManager
//定位对象
@property (strong,nonatomic)CLLocationManager * locationManager;
@end

@implementation TSLocationManager

static TSLocationManager * _manager;
-(CLLocationManager *)locationManager
{
    if (_locationManager==nil)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^
                      {
                          _locationManager=[[CLLocationManager alloc]init];
                          _locationManager.delegate=self;
                          //set the precision of location
                          //设置定位精度
                          _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
                          //set the frequency of location
                          //定位频率,每隔多少米定位一次
                          CLLocationDistance distance=5;
                          _locationManager.distanceFilter=distance;
                      });
    }
    return _locationManager;
}

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      _manager=[[TSLocationManager alloc]init];
                  });
    return _manager;
}
- (void)startLocatWithCompleteBlock:(void (^)(NSError * error, NSDictionary *addressDic, CLLocation *location))complete
{
    
    [self configManager];
    [self setTSTempBlock:^(NSError * error1, NSDictionary *addressDic1, CLLocation *location1) {
        if (complete)
        {
            complete(error1,addressDic1,location1);
        }
        
    }];
}
-(void)configManager
{
    [self.locationManager startUpdatingLocation];
    if (![CLLocationManager locationServicesEnabled])
    {
        NSError * error=[NSError errorWithDomain:@"please open your location service" code:0 userInfo:nil];
        
        if (self.TSTempBlock)
        {
            self.TSTempBlock(error,nil,nil);
        }
        return;
    }
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
    {
        [self.locationManager requestAlwaysAuthorization];
    }
}

#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //get the first location
    //取出第一个位置
    CLLocation *location=[locations firstObject];
    
    //trans the latitude and longitude to address
    //转换坐标为地理位置
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    [clGeoCoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks,NSError *error)
     {
         for (CLPlacemark *placeMark in placemarks)
         {
             NSDictionary *addressDic=placeMark.addressDictionary;
             if (self.TSTempBlock)
             {
                 self.TSTempBlock(nil,addressDic,location);
             }
         }
         if (error)
         {
             NSLog(@"%@",error);
             if (self.TSTempBlock)
             {
                 self.TSTempBlock(error,nil,location);
             }
         }
     }];
    //stop the location service after we get location message
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error)
    {
        NSLog(@"%@",error);
        if (self.TSTempBlock)
        {
            self.TSTempBlock(error,nil,nil);
        }
    }
    [_locationManager stopUpdatingLocation];
}

@end
