//
//  KeyboardAccessoryView.h
//  PlainText
//
//  Created by Jesse Grosjean on 4/21/11.
//


@interface KeyboardAccessoryView : UIImageView {
	UIResponder *__weak target;
}

@property (nonatomic, weak) UIResponder *target;

@end
