#import <Cordova/CDVPlugin.h>

@interface TurtlCore : CDVPlugin

- (void) start:(CDVInvokedUrlCommand*)command;
- (void) send:(CDVInvokedUrlCommand*)command;
- (void) recv:(CDVInvokedUrlCommand*)command;
- (void) recv_nb:(CDVInvokedUrlCommand*)command;
- (void) recv_event:(CDVInvokedUrlCommand*)command;
- (void) recv_event_nb:(CDVInvokedUrlCommand*)command;
- (void) lasterr:(CDVInvokedUrlCommand*)command;

@end

