//
//  TileOverlay.m
//
//
//  Created by Vladimir Psyukalov on 09.11.17.
//  Copyright © 2017 none. All rights reserved.
//


#import "TileOverlay.h"


#define kTileOverlayPathFormatKey (@"tile_overlay_path_%ld_%ld_%ld_format_key")


@implementation TileOverlay

#pragma mark - Overriding

- (instancetype)initWithURLTemplate:(NSString *)URLTemplate {
    self = [super initWithURLTemplate:URLTemplate];
    if (self) {
        self.canReplaceMapContent = YES;
    }
    return self;
}

- (instancetype)initWithURLTemplate:(NSString *)URLTemplate identifier:(NSString *)identifier {
    self = [super initWithURLTemplate:URLTemplate];
    if (self) {
        self.canReplaceMapContent = YES;
        _identifier = identifier;
    }
    return self;
}

- (NSURL *)URLForTilePath:(MKTileOverlayPath)path {
    NSString *xyzString = [NSString stringWithFormat:@"x=%ld&y=%ld&z=%ld",
                           (long)path.x,
                           (long)path.y,
                           (long)path.z];
    NSString *URLTemplate = [NSString stringWithString:self.URLTemplate];
    NSRange range = [URLTemplate rangeOfString:@"x={x}&y={y}&z={z}"];
    NSString *URL = [URLTemplate stringByReplacingCharactersInRange:range
                                                         withString:xyzString];
    return [NSURL URLWithString:URL];
}

- (void)loadTileAtPath:(MKTileOverlayPath)path result:(void (^)(NSData *data, NSError *error))result {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:[self stringWithTileOverlayPath:path]];
    if (data) {
        if (result) {
            result(data, nil);
        }
    } else {
        NSURLSession *URLSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *sessionDataTask = [URLSession dataTaskWithURL:[self URLForTilePath:path]
                                                          completionHandler:^(NSData *data,
                                                                              NSURLResponse *response,
                                                                              NSError *error) {
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  if (error) {
                                                                      NSLog(@"Session error: %@;", error);
                                                                  } else if (!data) {
                                                                      NSLog(@"Empty data: %@;", data);
                                                                  } else {
                                                                      [userDefaults setObject:data forKey:[self stringWithTileOverlayPath:path]];
                                                                      [userDefaults synchronize];
                                                                  }
                                                                  if (result) {
                                                                      result(data, error);
                                                                  }
                                                              });
                                                          }];
        [sessionDataTask resume];
    }
}

#pragma mark - Other methods

- (NSString *)stringWithTileOverlayPath:(MKTileOverlayPath)tileOverlayPath {
    NSString *result =  [NSString stringWithFormat:kTileOverlayPathFormatKey,
                         (long)tileOverlayPath.x,
                         (long)tileOverlayPath.y,
                         (long)tileOverlayPath.z];
    if (_identifier) {
        result = [NSString stringWithFormat:@"%@_%@", result, _identifier];
    }
    return result;
}

@end
