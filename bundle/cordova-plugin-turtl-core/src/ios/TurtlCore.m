#import <Cordova/CDVPlugin.h>

#import "TurtlCore.h"
#include "turtl_core.h"

@implementation TurtlCore

- (NSString*) make_err:(NSString*) msg withCode:(NSString*) code {
	NSMutableDictionary *dict = @{
		@"msg" : msg
	};
	if(code != nil) {
		[dict setValue:code forKey:@"code"];
	}
	NSError* e = nil;
	NSData* json = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableContainers error:&e];
	NSString* res = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
	return res;
}

- (void) start:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* result = nil;
	if(command.arguments.count == 0) {
		NSString* config = @"{}";
	} else {
		NSString* config = [command.arguments objectAtIndex:0];
	}
	const char* config_c = [config cStringUsingEncoding:NSUTF8StringEncoding];
	int32_t res = turtlc_start(config_c, 1);
	if(res == 0) {
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"0"];
	} else {
		NSString* error = [self make_err:@"Cannot start Turtl core" withCode:@"native_load_error"];
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error];
	}
	[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) send:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* result = nil;
	if(command.arguments.count == 0) {
		NSString* msg = @"";
	} else {
		NSString* msg = [command.arguments objectAtIndex:0];
	}
	NSData* bdata = [msg dataUsingEncoding:NSUTF8StringEncoding];
	size_t bytes_len = [bdata length];
	uint8_t* bytes_c = [bdata bytes]; 
	int32_t res = turtlc_send(bytes_c, bytes_len);
	if(res == 0) {
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"0"];
	} else {
		NSString* error = [self make_err:@"Cannot start Turtl core" withCode:@"native_load_error"];
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error];
	}
	[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) recv:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* result = nil;
	NSString* msg_id = nil;
	if(command.arguments.count > 0) {
		msg_id = [command.arguments objectAtIndex:0];
	}
	NSString* msg_id = [command.arguments objectAtIndex:0];
	if(msg_id == nil) {
		msg_id = @"";
	}
	const char* msg_id_c = [msg_id cStringUsingEncoding:NSUTF8StringEncoding];
	size_t len = 0;
	uint8_t* bytes = turtlc_recv(0, msg_id_c, &len);
	if(bytes == nil) {
		NSString* error = [self make_err:@"error receiving message" withCode:nil];
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error];
	} else {
		NSData* bdata = [NSData dataWithBytes:bytes length:len];
		NSString* msg_str = [[NSString alloc] initWithData:bdata encoding:NSUTF8StringEncoding];
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg_str];
		turtlc_free(bytes, len);
	}
	[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) recv_nb:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* result = nil;
	NSString* msg_id = nil;
	if(command.arguments.count > 0) {
		msg_id = [command.arguments objectAtIndex:0];
	}
	if(msg_id == nil) {
		msg_id = @"";
	}
	const char* msg_id_c = [msg_id cStringUsingEncoding:NSUTF8StringEncoding];
	size_t len = 0;
	uint8_t* bytes = turtlc_recv(1, msg_id_c, &len);
	if(bytes == nil && len > 0) {
		NSString* error = [self make_err:@"error receiving message" withCode:nil];
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error];
	} else if(bytes == nil) {
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
	} else {
		NSData* bdata = [NSData dataWithBytes:bytes length:len];
		NSString* msg_str = [[NSString alloc] initWithData:bdata encoding:NSUTF8StringEncoding];
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg_str];
		turtlc_free(bytes, len);
	}
	[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) recv_event:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* result = nil;
	size_t len = 0;
	uint8_t* bytes = turtlc_recv_event(0, &len);
	if(bytes == nil) {
		NSString* error = [self make_err:@"error receiving event" withCode:nil];
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error];
	} else {
		NSData* bdata = [NSData dataWithBytes:bytes length:len];
		NSString* msg_str = [[NSString alloc] initWithData:bdata encoding:NSUTF8StringEncoding];
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg_str];
		turtlc_free(bytes, len);
	}
	[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) recv_event_nb:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* result = nil;
	size_t len = 0;
	uint8_t* bytes = turtlc_recv_event(1, &len);
	if(bytes == nil && len > 0) {
		NSString* error = [self make_err:@"error receiving event" withCode:nil];
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error];
	} else if(bytes == nil) {
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
	} else {
		NSData* bdata = [NSData dataWithBytes:bytes length:len];
		NSString* msg_str = [[NSString alloc] initWithData:bdata encoding:NSUTF8StringEncoding];
		result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg_str];
		turtlc_free(bytes, len);
	}
	[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) lasterr:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* result = nil;
	char* msg = turtlc_lasterr();
	NSString* msg_str = [[NSString alloc] initWithUTF8String:msg];
	result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg_str];
	turtlc_free_err(msg);
	[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end

