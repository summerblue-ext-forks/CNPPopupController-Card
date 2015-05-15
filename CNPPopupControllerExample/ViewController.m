//
//  ViewController.m
//  CNPPopupControllerExample
//
//  Created by Carson Perrotti on 2014-09-28.
//  Copyright (c) 2014 Carson Perrotti. All rights reserved.
//

#import "ViewController.h"

#import "CNPPopupController.h"

@interface ViewController () <CNPPopupControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *showButton;

@property (nonatomic, strong) CNPPopupController *popupController;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.showButton.layer.cornerRadius = 4;
}

-(void)showPopupCentered:(id)sender {
    [self showPopupWithStyle:CNPPopupStyleCentered];
}

- (void)showPopupFormSheet:(id)sender {
    [self showPopupWithStyle:CNPPopupStyleActionSheet];
}

- (void)showPopupFullscreen:(id)sender {
    [self showPopupWithStyle:CNPPopupStyleFullscreen];
}

- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"宠物一家亲"
                                                                attributes:@{
                                                                             NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0],
                                                                             NSParagraphStyleAttributeName : paragraphStyle,
                                                                             NSForegroundColorAttributeName : UIColorFromRGB(0x666666)
                                                                             }];

//    NSURL *myURL = [NSURL URLWithString:@"http://freephotos.atguru.in/hdphotos/sad-cat/sad-cat-8.jpg"];
//    UIImage *icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:myURL]];
    UIImage *icon = [UIImage imageNamed:@"sad-cat-8.jpg"];
    
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:@"12 成员 • Master: Keven"
                                                                  attributes:@{
                                                                               NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:11.0],
                                                                               NSParagraphStyleAttributeName : paragraphStyle,
                                                                               NSForegroundColorAttributeName : UIColorFromRGB(0x999999)
                                                                               }];

    NSMutableParagraphStyle *detailParagraphStyle = [[NSMutableParagraphStyle alloc]init] ;
    [detailParagraphStyle setAlignment:NSTextAlignmentLeft];
    [detailParagraphStyle setLineSpacing:3.0];
    
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:@"合创优设是基于互联网的珠宝首饰设计师项目交流平台，通过这个平台为设计师提供更多的订单机会和成长空间，同时合创优设的导师团也会助力设计师的成长。"
                                                                  attributes:@{
                                                                                NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:12.0],
                                                                               NSForegroundColorAttributeName : UIColorFromRGB(0x666666),
                                                                               NSParagraphStyleAttributeName : detailParagraphStyle
                                                                               }];
    
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"加入聊天室" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButtonItem *buttonItem = [CNPPopupButtonItem defaultButtonItemWithTitle:buttonTitle backgroundColor:UIColorFromRGB(0x54CE7C)];
    buttonItem.selectionHandler = ^(CNPPopupButtonItem *item){
        NSLog(@"Block for button: %@", item.buttonTitle.string);
    };
    
    self.popupController = [[CNPPopupController alloc] initWithTitle:title contents:@[icon, lineOne, lineTwo] buttonItems:@[buttonItem] destructiveButtonItem:nil];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    self.popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromBottom;
    [self.popupController presentPopupControllerAnimated:YES];
}

#pragma mark - CNPPopupController Delegate 

- (void)popupController:(CNPPopupController *)controller didDismissWithButtonTitle:(NSString *)title {
    NSLog(@"Dismissed with button title: %@", title);
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller {
    NSLog(@"Popup controller presented.");
}

@end
