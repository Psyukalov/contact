//
//  TileOverlay.h
//
//
//  Created by Vladimir Psyukalov on 09.11.17.
//  Copyright © 2017 none. All rights reserved.
//


#import <MapKit/MapKit.h>


@interface TileOverlay : MKTileOverlay

@property (strong, nonatomic, readonly) NSString *identifier;

- (instancetype)initWithURLTemplate:(NSString *)URLTemplate identifier:(NSString *)identifier;

@end
