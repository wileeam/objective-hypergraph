/*
 * HyperEdgeProtocol.h
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

#import "Vertex.h"

@protocol HyperEdgeProtocol <NSObject>

- (Vertex *)addVertex:(Vertex *)vertex;
- (NSArray *)addVertices:(NSArray *)vertices;

- (Vertex *)removeVertex:(Vertex *)vertex;
- (NSArray *)removeVertices:(NSArray *)vertices;

- (BOOL)connectsVertex:(Vertex *)vertex;
- (BOOL)connectsVertices:(NSArray *)vertices;

- (NSArray *)getVertices;
- (NSArray *)getOtherVertices:(NSArray *)vertices;

- (void)destroy;

@end
