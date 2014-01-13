#import <UIKit/UIKit.h>

@class FontPickerViewController;

@protocol FontPickerViewControllerDelegate <NSObject>
- (void)fontPickerViewController:(FontPickerViewController *)fontPicker didSelectFont:(NSString *)fontName;
@end

@interface FontPickerViewController : UITableViewController {
	id<FontPickerViewControllerDelegate> __weak delegate;
}

@property(nonatomic,weak)	id<FontPickerViewControllerDelegate> delegate;

@end
