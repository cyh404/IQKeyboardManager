
//

#import <UIKit/UIKit.h>

@class ZJErrorPageView , ZJLoadingView;

typedef enum {
    DefaultType = 0,
    ErrorNetWorkType = 1
} EmptyType;

@interface UIView (ZJEmptyView)

//ZJErrorPageView
@property (nonatomic,strong) ZJErrorPageView * errorPageView;
- (void)configReloadAction:(void(^)())block;
- (void)showErrorPageViewWithType:(EmptyType)emptyType;
- (void)hideErrorPageView;

//ZJLoadingView
@property (nonatomic,strong) ZJLoadingView * loadingView;
- (void)showLoadingView;
- (void)hideLoadingView;

@end

#pragma mark - ZJErrorPageView

@interface ZJErrorPageView : UIView

@property (nonatomic,weak) UIImageView* errorImageView;
@property (nonatomic,weak) UILabel* errorTipLabel;
@property (nonatomic,weak) UILabel* errorFootLabel;
@property (nonatomic,weak) UIButton* reloadButton;
@property (nonatomic,copy) void(^didClickReloadBlock)();

@end

#pragma mark - ZJLoadingView

@interface ZJLoadingView : UIView

@property (nonatomic ,strong) UIActivityIndicatorView * indicatorView;
@property (nonatomic,weak) UIImageView* nodataImageView;
@property (nonatomic,weak) UILabel* nodataTipLabel;

@end
