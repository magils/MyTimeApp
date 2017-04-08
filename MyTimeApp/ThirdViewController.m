//
//  ThirdViewController.m
//  MyTimeApp
//
//  Created by Moises on 3/21/17.
//  Copyright © 2017 Moises Gil. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerDisplay;
@property (weak, nonatomic) NSTimer *timer;

-(void) updateTimer;
-(void) printTime:(NSDate *) date;

@end

@implementation ThirdViewController


NSDate *startDate;
BOOL isPaused = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTimer:(UIButton *)sender {
    
    if(!isPaused){
        startDate = [NSDate date];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [_timer fire];
    }else{
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    
}

- (IBAction)pauseTimer:(UIButton *)sender {
    
    UIAlertController *inDevelopmentAlert = [UIAlertController alertControllerWithTitle:@"This is under development" message:@"This feature is not available now, but it will soon" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [inDevelopmentAlert addAction: dismissAction];
    
    [self presentViewController:inDevelopmentAlert animated:YES completion:nil];

}



- (IBAction)stopTimer:(UIButton *)sender {
    if([_timer isValid]){
        [_timer invalidate];
        
        _timerDisplay.text = @"00:00:00.000";
    }
}



-(void) updateTimer {
    
    //Diff between the initial date and the current
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate: startDate];
    
    //Difference to Date
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    //Formatting the date
    [self printTime: timerDate];
        
}


-(void) printTime:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    _timerDisplay.text = [dateFormatter stringFromDate:date];
    
}

@end
