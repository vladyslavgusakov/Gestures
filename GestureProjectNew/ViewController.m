//
//  ViewController.m
//  GestureProjectNew
//
//  Created by Vladyslav Gusakov on 4/17/16.
//  Copyright © 2016 Vladyslav Gusakov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *singleTapLabel;
@property (weak, nonatomic) IBOutlet UILabel *doubleTapLabel;

@property (strong, nonatomic) UIImageView *iphoneImageView;

@end

@implementation ViewController

NSUInteger singleTapCounter = 0;
NSUInteger doubleTapCounter = 0;

NSArray *pics;

NSInteger picsCounter = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    pics = @[@"iphone1.png", @"iphone2.png", @"iphone3.png"];

    self.iphoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 240, 316)];
    self.iphoneImageView.image = [UIImage imageNamed:@"iphone1.png"];
    self.iphoneImageView.userInteractionEnabled = YES;
    self.iphoneImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.iphoneImageView];
    
    //single tap gesture
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.numberOfTapsRequired = 1;
    [self.iphoneImageView addGestureRecognizer:singleTap];
    
    //double tap gesture
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.iphoneImageView addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];

    //pinch gesture
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImage:)];
    [self.iphoneImageView addGestureRecognizer:pinchGesture];
    
    //pan gesture
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragImage:)];
    [self.iphoneImageView addGestureRecognizer:panGesture];
    
    //swipe gestures
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
    
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    //rotation gesture
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
    [self.iphoneImageView addGestureRecognizer:rotationGesture];
    
    //long press gesture
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.iphoneImageView addGestureRecognizer:longPressGesture];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) handleSingleTap: (UITapGestureRecognizer *) recognizer {
    NSLog(@"single tap");
    self.singleTapLabel.text = [NSString stringWithFormat:@"Single taps: %lu", ++singleTapCounter];
}

-(void) handleDoubleTap: (UITapGestureRecognizer *) recognizer {
    NSLog(@"double tap");
    self.doubleTapLabel.text = [NSString stringWithFormat:@"Double taps: %lu", ++doubleTapCounter];
}

-(void) scaleImage: (UIPinchGestureRecognizer *) recognizer {
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

-(void) dragImage: (UIPanGestureRecognizer *) recognizer {
    NSLog(@"pan gesture");
    recognizer.view.center = [recognizer locationInView: recognizer.view.superview];
}

-(void) handleSwipes: (UISwipeGestureRecognizer *) recognizer {

    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            
        {
            if (++picsCounter >= pics.count) {
                picsCounter = 0;
            }
            
            self.iphoneImageView.image = [UIImage imageNamed:pics[picsCounter]];

        }
            break;
            
        case UISwipeGestureRecognizerDirectionLeft:
            
        {
            if (--picsCounter <= 0) {
                picsCounter = pics.count-1;
            }
            
            self.iphoneImageView.image = [UIImage imageNamed:pics[picsCounter]];
            
        }
            break;

        default:
            break;
    }
}

-(void) rotateImage: (UIRotationGestureRecognizer *) recognizer {
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

-(void) longPress: (UILongPressGestureRecognizer *) recognizer {
    recognizer.view.center = self.view.center;
}

@end
