/*
 * GraphNotifier.m
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

#import "GraphNotifier.h"


@implementation GraphNotifier

#pragma mark - Initialisation and memory management

- (id)init
{
    
    // Parent initialisation's check and adjacent matrix's population
	if ((self = [super init]) != nil) {
        _uuid = [NSString stringWithUUID];
        
        _vertices = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFCopyStringDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        _edges = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFCopyStringDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    }
    
    return self;
    
} // init()

- (void)dealloc
{
    
    if(_vertices) { 
        CFRelease(_vertices);
    }
    if (_edges) {
        CFRelease(_edges);
    }
    
    [_uuid dealloc];
    
    [super dealloc];
    
} // dealloc()

#pragma mark - Add vertex/vertices (single and set)

- (void)addIndex:(HyperEdge *)edge withVertex:(Vertex *)vertex
{

    if (edge == nil || vertex == nil) {
        return;
    }
    
    if (!CFDictionaryContainsKey(_edges, edge)) {
        CFDictionaryAddValue(_edges, edge, [NSMutableSet set]);
    }
 
    NSMutableSet *edges = (NSMutableSet *) CFDictionaryGetValue(_edges, edge);
    [edges addObject:vertex];
    
    if (!CFDictionaryContainsKey(_vertices, vertex)) {
        CFDictionaryAddValue(_vertices, vertex, [NSMutableSet set]);
    }
    
    NSMutableSet *vertices = (NSMutableSet *) CFDictionaryGetValue(_vertices, vertex);
    [vertices addObject:edge];
    
} // addIndex()

- (void)addIndex:(HyperEdge *)edge withVertices:(NSArray *)vertices
{
    
    if (edge == nil || vertices == nil) {
        return;
    }

    for (Vertex *v in vertices) {
        [self addIndex:edge withVertex:v];
    }
    
} // addIndex()

#pragma mark - Remove vertex/vertices (single and set)

- (void)removeIndex:(HyperEdge *)edge withVertex:(Vertex *)vertex
{
    
    if (edge == nil || vertex == nil) {
        return;
    }
    
    if (CFDictionaryContainsKey(_edges, edge)) {        
        NSMutableSet *edges = (NSMutableSet *) CFDictionaryGetValue(_edges, edge);
        [edges removeObject:vertex];
        
        if ([edges count] == 0) {
            CFDictionaryRemoveValue(_edges, edge);            
        }
    }

    if (CFDictionaryContainsKey(_vertices, vertex)) {        
        NSMutableSet *vertices = (NSMutableSet *) CFDictionaryGetValue(_vertices, vertex);
        [vertices removeObject:vertex];
        
        if ([vertices count] == 0) {
            CFDictionaryRemoveValue(_vertices, vertex);
        }        
    }
    
} // removeIndex()

- (void)removeIndex:(HyperEdge *)edge withVertices:(NSArray *)vertices
{

    if (edge == nil || vertices == nil) {
        return;
    }
    
    for (Vertex *v in vertices) {
        [self removeIndex:edge withVertex:v];
    }
    
} // removeIndex()

@end
