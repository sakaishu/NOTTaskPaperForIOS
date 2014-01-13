//
//  TextFieldViewController.h
//  PlainText
//
//  Created by Jesse Grosjean on 12/23/10.
//

#import "ViewController.h"
#import "SMTEDelegateController.h"

@class TextFieldViewController;

@interface TextFieldViewController : ViewController <UITextFieldDelegate> {
	id __weak delegate;
	SMTEDelegateController *textExpander;
}

@property (weak, nonatomic, readonly) UITextField *textField;
@property (nonatomic, weak) id delegate;

@end
