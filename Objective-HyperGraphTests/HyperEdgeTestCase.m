/*
 * HyperEdgeTestCase.m
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


#import "HyperEdgeTestCase.h"


#define VERTICES_MIN 5
#define VERTICES_MAX 25

@implementation HyperEdgeTestCase

- (void)setUp
{
    [super setUp];
    
    edge = [[HyperEdge alloc] init];

} // setUp()

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];

} // tearDown()

- (void)testHyperEdgeSize
{
    
    NSLog(@"%@ start", self.name);
    
    NSMutableArray *vertices = [NSMutableArray arrayWithCapacity:(rand() % VERTICES_MAX) + VERTICES_MIN];
        
    for (NSUInteger i = 0; i < [vertices count]; i++) {
        Vertex *vertex = [[Vertex alloc] init];
        //Vertex *vertex = [Vertex vertex];
        [vertices insertObject:vertex atIndex:i];
    }
    
    [edge addVertices:vertices];
    
    STAssertTrue([[edge getVertices] count] == [vertices count], @"HyperEdge size should have been %d but it was %d instead", [vertices count], [[edge getVertices] count]);

    NSLog(@"%@ end", self.name);    
    
} // testHyperEdge()

@end
