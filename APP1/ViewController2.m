//
//  ViewController2.m
//  APP1
//
//  Created by APPLE on 21/03/17.
//  Copyright © 2017 Vlada Gizatullina. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* urlString = @"https://oauth.vk.com/authorize?client_id=5957145&display=page&redirect_uri=http://vk.com/callback&scope=friends&response_type=token&v=5.63&state=123456";
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.testWebView loadRequest:request];
    // Нужно сказать webView чтобы оно нам отдавало все события (self это текущий класс)
    self.testWebView.delegate = self;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // Для начала нам нужно понять что мы ищем, и нужно выделить какую-то черту, к которой привяжемся, к примеру строку blank.html, она есть в нужном нам URL
    if([request.URL.absoluteString containsString:@"blank.html"]){
        NSString* stringURL = request.URL.absoluteString; // мы нашли нужную строку
        stringURL = [stringURL stringByReplacingOccurrencesOfString:@"#" withString:@"?"]; // Тут наверно не много сложно будет, нужно почитать что такое HTTP GET запрос, пока можно принять это как истину)
        NSURLComponents* components = [[NSURLComponents alloc] initWithString:stringURL];
        for(NSURLQueryItem* item in components.queryItems){ // Тут мы проходимся по всем query в GET запросе и ищем токен
            if([item.name isEqualToString:@"access_token"]){ // Мы его нашли
                NSLog(@"%@", item.value); // Выводим его, именно этот ключ нам и нужен, чтобы получить доступ к данным из VK
            }
        }
    
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
  
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
   
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

@end
