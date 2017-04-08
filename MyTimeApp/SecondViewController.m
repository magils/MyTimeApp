//
//  SecondViewController.m
//  MyTimeApp
//
//  Created by Moises Gil on 3/5/17.
//  Copyright © 2017 Moises Gil. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UILabel *timeCounterLabel;
@property (weak,nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *timeOverLabel;
@property (weak, nonatomic) IBOutlet UITextField *minuteInput;
@property (weak, nonatomic) IBOutlet UITextField *secondInput;


-(void) startCounterDown;
-(void) pauseCounterDown;
-(void) formatDisplayWithMinutes:(int) minutes andSeconds:(int) seconds;


@end

@implementation SecondViewController

int minutes = 0, seconds = 0;


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startCountdown:(UIButton *)sender {
    
    
    _timeCounterLabel.textColor = [UIColor blackColor];
    
    if(minutes >= 0 && seconds > 0 ){
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startCounterDown) userInfo:nil repeats:YES];
    } else if(!_minuteInput.hasText || !_secondInput.hasText){

        //Alert when the fields for the minutes and seconds are empty
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated: YES completion: nil];
            
        }];
        
        UIAlertController *emptyAlert = [UIAlertController alertControllerWithTitle:@"Invalid values" message:@"The value of minutes or seconds are not valid " preferredStyle:UIAlertControllerStyleAlert];
        
        [emptyAlert addAction: okAction];
        
        [self presentViewController:emptyAlert animated:YES completion:nil];
        
    }else{
    
        minutes = [[_minuteInput text] intValue];
        seconds = [[_secondInput text] intValue];
        
        [self formatDisplayWithMinutes:minutes andSeconds:seconds];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startCounterDown) userInfo:nil repeats:YES];
        
    }
    
    
}

- (IBAction)stopCountdown:(UIButton *)sender {
    
    if([_timer isValid]){
       
        [_timer invalidate];
        
        minutes = 0;
        seconds = 0;
        
        [_timeCounterLabel setText:[NSString stringWithFormat:@"%02d:%02d",minutes,seconds]];
        
    }
    
}


- (IBAction)pauseCountdown:(UIButton *)sender {
    
    if(minutes >= 0 && seconds > 0 ){
        _timeCounterLabel.textColor = [UIColor orangeColor];
        [_timer invalidate];
    }else{
        UIAlertController *pauseAlert = [UIAlertController alertControllerWithTitle:@"Pause" message:@"The timer is not running" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [pauseAlert addAction: dismissAction];
        
        [self presentViewController:pauseAlert animated:YES completion:nil];
        
        
    }
}


-(void) startCounterDown{
    
    
        // Substract one minute and set the seconds to 59
        if(seconds == 0){
            
            minutes -= 1;
            seconds = 59;
            
        }else if(seconds > 0){
            //Discount seconds
            seconds -=1 ;
        }
        
        
        //Print the time in the screen
        
        if(minutes == 0 && seconds >= 0){
            [self formatDisplayWithMinutes:minutes andSeconds:seconds];
        }else{
            
            [_timer invalidate];
            
            
            UIAlertController *finishAlert = [UIAlertController alertControllerWithTitle:@"Countdown" message:@"Time over!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *dismissAlert = [UIAlertAction actionWithTitle:@"Dismiss" style: UIAlertActionStyleDefault handler:^(UIAlertAction *handler){
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
            
            [finishAlert addAction: dismissAlert];
            
            [self presentViewController:finishAlert animated:YES completion:nil];
            
        }
}



-(void) formatDisplayWithMinutes:(int)minutes andSeconds:(int)seconds{
    [_timeCounterLabel setText:[NSString stringWithFormat:@"%02d:%02d",minutes,seconds]];
}

@end
