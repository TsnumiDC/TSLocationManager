//
//  ViewController.m
//  TSLoCationManagerDemo
//
//  Created by Dylan on 7/19/16.
//  Copyright © 2016 Dylan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *siteLable;
@property (weak, nonatomic) IBOutlet UILabel *siteCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *getSitBtn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)getSiteBtnAction:(id)sender
{
    __weak typeof(self) weakSelf=self;
    [[TSLocationManager shareManager]startLocatWithCompleteBlock:^(NSError *error, NSDictionary *addressDic, CLLocation *location)
    {
        if (error)
        {
            NSLog(@"%@",error);
            return ;
        }
        //get Location Message and show it on screen
        //获取定位信息
        NSString *CountryCode =addressDic[@"CountryCode"];
        NSString *Country =addressDic[@"Country"];
        NSString *State =addressDic[@"State"];
        NSString *City =addressDic[@"City"];
        NSString *SubLocality =addressDic[@"SubLocality"];
        NSString *Thoroughfare =addressDic[@"Thoroughfare"];
        NSString *SubThoroughfare =addressDic[@"SubThoroughfare"];

        NSArray *FormattedAddressLines =addressDic[@"FormattedAddressLines"];
        NSString *Name =addressDic[@"Name"];

        weakSelf.siteLable.text=[NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n",CountryCode,Country,State,City,SubLocality,Thoroughfare,SubThoroughfare,FormattedAddressLines[0],Name];
        weakSelf.siteCodeLabel.text=[NSString stringWithFormat:@"latitude:%f\nlongitude:%f",location.coordinate.latitude,location.coordinate.longitude];
        
        NSLog(@"out---%@",weakSelf.siteCodeLabel.text);
        NSLog(@"out---%@",weakSelf.siteLable.text);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
