//
//  FirstViewController.m
//  MyTimeApp
//
//  Created by Moises Gil on 3/5/17.
//  Copyright © 2017 Moises Gil. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (nonatomic) int timeTouchesCounter;
@property (nonatomic) int dateTouchesCounter;
@property (weak, nonatomic) IBOutlet UILabel *watchLabel;
@property (nonatomic) NSDateFormatter *watchFormatter;

-(void) updateTimeAndDate;
-(void) timeWatch;

@end

@implementation FirstViewController

 NSUInteger styles[3] = {NSDateFormatterShortStyle,NSDateFormatterMediumStyle,NSDateFormatterLongStyle};
 const int STYLES_SIZE = sizeof(styles) / sizeof(styles[0]);
 NSArray *colors;

- (void)viewDidLoad {
    [super viewDidLoad];

    colors = @[[UIColor blueColor],[UIColor greenColor],[UIColor orangeColor]];
    _watchFormatter = [[NSDateFormatter  alloc] init];
    
    NSTimer *watchTimer = [NSTimer scheduledTimerWithTimeInterval:1 target: self selector:@selector(timeWatch) userInfo:nil repeats:YES];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    [self updateTimeAndDate];
    
}


- (IBAction)updateDateAndTimeView:(UIButton *)sender {
    [self updateTimeAndDate];
}




-(void) updateTimeAndDate{
    
    NSDateFormatter *time = [[NSDateFormatter alloc] init];
    
    [time setDateStyle:NSDateFormatterNoStyle];
    [time setTimeStyle: NSDateFormatterMediumStyle];
    
    [_timeButton setTitle: [time stringFromDate: [NSDate date]] forState: UIControlStateNormal];
    
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    
    [date setDateStyle: NSDateFormatterMediumStyle];
    [date setTimeStyle: NSDateFormatterNoStyle];
    
    [_dateButton setTitle: [date stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    
}
- (IBAction)changeTimeFormat:(UIButton *)sender {
    
    UIColor *buttonTitleColor;
    
    if(_timeTouchesCounter == STYLES_SIZE){
        _timeTouchesCounter = 0;
        buttonTitleColor = [UIColor whiteColor];
    }else{
        buttonTitleColor = colors[_timeTouchesCounter];
    }
    
    NSDateFormatter *time = [[NSDateFormatter alloc] init];
        
    [time setDateStyle:NSDateFormatterNoStyle];
    [time setTimeStyle: styles[_timeTouchesCounter]];
    
    NSString *buttonNewTitle = [time stringFromDate:[NSDate date]];
    
    [_timeButton setTitle: buttonNewTitle forState:UIControlStateNormal];
    [_timeButton setTitleColor: buttonTitleColor forState:UIControlStateNormal];
        
    _timeTouchesCounter++;
    
}
- (IBAction)changeDatFormat:(UIButton *)sender {
    
    UIColor *buttonColor;
    
    if(_dateTouchesCounter == STYLES_SIZE){
        _dateTouchesCounter = 0;
        buttonColor = [UIColor whiteColor];
    }else{
        buttonColor = [colors objectAtIndex:_dateTouchesCounter];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateStyle:styles[_dateTouchesCounter]];
    
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    [_dateButton setTitle:dateString forState:UIControlStateNormal];
    [_dateButton setTitleColor:buttonColor forState:UIControlStateNormal];
    
    _dateTouchesCounter++;
    
}

-(void) timeWatch {
    
    NSDate *currentTime = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *secondComponent = [currentCalendar components:NSCalendarUnitSecond fromDate:currentTime];
    
    NSInteger currentSecond = [secondComponent second];
    

    if(currentSecond % 2 == 0){
        [_watchFormatter setDateFormat:@"hh:mm:ss a"];
    }else{
        [_watchFormatter setDateFormat:@"hh mm ss a"];
    }
    _watchLabel.text = [_watchFormatter stringFromDate:currentTime];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
