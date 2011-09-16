/*
 * DirectedHyperGraphProtocol.h
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

#import "HyperGraphProtocol.h"
#import "DirectedHyperEdge.h"


@protocol DirectedHyperGraphProtocol <HyperGraphProtocol>

- (DirectedHyperEdge *)addEdgeWithSourceVertex:(Vertex *)source withTargetVertex:(Vertex *)target;
- (DirectedHyperEdge *)addEdgeWithSourceVertex:(Vertex *)source withTargetVertices:(NSArray *)target;
- (DirectedHyperEdge *)addEdgeWithSourceVertices:(NSArray *)source withTargetVertex:(Vertex *)target;
- (DirectedHyperEdge *)addEdgeWithSourceVertices:(NSArray *)source withTargetVertices:(NSArray *)target;

- (NSArray *)findEdgesWithSourceVertex:(Vertex *)source;
- (NSArray *)findEdgesWithSourceVertices:(NSArray *)source;
- (NSArray *)findEdgesWithTargetVertex:(Vertex *)target;
- (NSArray *)findEdgesWithTargetVertices:(NSArray *)target;

- (NSArray *)findEdgesWithSourceVertex:(Vertex *)source withTargetVertex:(Vertex *)target;
- (NSArray *)findEdgesWithSourceVertex:(Vertex *)source withTargetVertices:(NSArray *)target;
- (NSArray *)findEdgesWithSourceVertices:(NSArray *)source withTargetVertex:(Vertex *)target;
- (NSArray *)findEdgesWithSourceVertices:(NSArray *)source withTargetVertices:(NSArray *)target;

//- (BOOL)isEqual:(id)object;

@end
