//
//  IPhoneDocumentViewFieldEditor.h
//  Documents
//
//  Created by Jesse Grosjean on 12/18/09.
//

#import <Foundation/Foundation.h>


@interface IPhoneDocumentViewFieldEditor : UITextView {
	BOOL uncommitedChanges;
	NSString *placeholderText;
}

+ (IPhoneDocumentViewFieldEditor *)sharedInstance;

@property(assign, nonatomic) BOOL uncommitedChanges;
@property(strong, nonatomic) NSString *placeholderText;
	
@end
