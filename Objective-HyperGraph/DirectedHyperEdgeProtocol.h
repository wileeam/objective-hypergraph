/*
 * DirectedHyperEdgeProtocol.h
 *
 * Copyright (C) 2011, Guillermo Rodriguez-Cano
 * All rights reserved.
 *
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 *
 * Contacting the author:
 *   Guillermo Rodriguez-Cano:  wileeam@acm.org
 *
 * @version $Id$
 *
 */


#import <Foundation/Foundation.h>

#import "HyperEdgeProtocol.h"
#import "Vertex.h"


@protocol DirectedHyperEdgeProtocol <HyperEdgeProtocol>

- (BOOL)addSourceVertex:(Vertex *)vertex;
- (BOOL)addSourceVertices:(NSArray *)vertices;

- (BOOL)addTargetVertex:(Vertex *)vertex;
- (BOOL)addTargetVertices:(NSArray *)vertices;

- (BOOL)addSourceAndTargetVertices:(NSArray *)sourceVertices:(NSArray *)targetVertices;

- (BOOL)removeSourceVertex:(Vertex *)vertex;
- (BOOL)removeSourceVertices:(NSArray *)vertices;

- (BOOL)removeTargetVertex:(Vertex *)vertex;
- (BOOL)removeTargetVertices:(NSArray *)vertices;

- (BOOL)removeSourceAndTargetVertices:(NSArray *)sourceVertices:(NSArray *)targetVertices;

- (NSSet *)getSourceVertices;
- (NSSet *)getOtherSourceVerticesExcludingVertex:(Vertex *)vertex;
- (NSSet *)getOtherSourceVerticesExcludingVertices:(NSArray *)vertices;

- (NSSet *)getTargetVertices;
- (NSSet *)getOtherTargetVerticesExcludingVertex:(Vertex *)vertex;
- (NSSet *)getOtherTargetVerticesExcludingVertices:(NSArray *)vertices;

- (BOOL)hasSource;
- (BOOL)hasSourceWithVertex:(Vertex *)vertex;
- (BOOL)hasSourceWithVertices:(NSArray *)vertices;

- (BOOL)hasTarget;
- (BOOL)hasTargetWithVertex:(Vertex *)vertex;
- (BOOL)hasTargetWithVertices:(NSArray *)vertices;

- (NSUInteger)countSourceVertices;
- (NSUInteger)countTargetVertices;

- (BOOL)isEqual:(id)object;

@end
