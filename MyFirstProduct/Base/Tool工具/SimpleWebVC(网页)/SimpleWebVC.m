//
//  SimpleWebVC.m
//  WIFIEarnMoney
//
//  Created by kunge on 2017/2/13.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import "SimpleWebVC.h"
#import <WebKit/WebKit.h>

@interface SimpleWebVC ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic)WKWebView *wkWebView;

@end

@implementation SimpleWebVC

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (@available(iOS 11.0, *)) {
        self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
        if (kStringIsEmpty(self.htmlStr)) {
            [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        }else{
            [self.wkWebView loadHTMLString:self.htmlStr baseURL:nil];
        }
        [self.view addSubview:self.wkWebView];
        
    }else{
        self.wkWebView.hidden = YES;
        self.webView.delegate = self;
        if (kStringIsEmpty(self.htmlStr)) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        }else{
            [self.webView loadHTMLString:self.htmlStr baseURL:nil];
        }
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Disable user selection
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//    // Disable callout
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}


@end
