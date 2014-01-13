//
//  SearchView.h
//  PlainText
//
//  Created by Jesse Grosjean on 4/28/11.
//

#import "HUDBackgroundView.h"


@class SearchTextField;

@interface HUDSearchView : HUDBackgroundView {
	SearchTextField *searchTextField;
}

@property(weak, readonly, nonatomic) SearchTextField *searchTextField;

@end
