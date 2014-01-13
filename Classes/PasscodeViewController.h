//
//  PasscodeViewController.h
//  Secretnote
//
//  Created by Kim Young Hoo on 10. 10. 9..
//  Copyright 2010 Codingrobots. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	PasscodeCheck,
	PasscodeSetNewPasscode,
	PasscodeConfirmNewPasscode
} PasscodeViewState;


@interface PasscodeViewController : UIViewController <UITextFieldDelegate> {
	UITextField *_passcodeTextField1;
	UITextField *_passcodeTextField2;
	UITextField *_passcodeTextField3;
	UITextField *_passcodeTextField4;
	UITextField *_hiddenTextField;
	UILabel *_descriptionLabel;
	UILabel *_descriptionLabel2;
	PasscodeViewState viewState;
	NSString *_theNewPasscode;
}

@property (nonatomic, strong) IBOutlet UITextField *passcodeTextField1;
@property (nonatomic, strong) IBOutlet UITextField *passcodeTextField2;
@property (nonatomic, strong) IBOutlet UITextField *passcodeTextField3;
@property (nonatomic, strong) IBOutlet UITextField *passcodeTextField4;
@property (nonatomic, strong) IBOutlet UITextField *hiddenTextField;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel2;
@property (nonatomic, assign) PasscodeViewState viewState;
@property (nonatomic, strong) NSString *theNewPasscode;

- (NSString *)passcode;

@end
