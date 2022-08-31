pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../contracts/BokkyPooBahsRedBlackTreeLibrary.sol";

// ----------------------------------------------------------------------------
// BokkyPooBah's Red-Black Tree Library v1.0-pre-release-a - Contract for testing
//
// A Solidity Red-Black Tree binary search library to store and access a sorted
// list of unsigned integer data. The Red-Black algorithm rebalances the binary
// search tree, resulting in O(log n) insert, remove and search time (and ~gas)
//
// https://github.com/bokkypoobah/BokkyPooBahsRedBlackTreeLibrary
//
//
// Enjoy. (c) BokkyPooBah / Bok Consulting Pty Ltd 2020. The MIT Licence.
// ----------------------------------------------------------------------------
contract TestBokkyPooBahsRedBlackTree is Test {
    using BokkyPooBahsRedBlackTreeLibrary for BokkyPooBahsRedBlackTreeLibrary.Tree;

    BokkyPooBahsRedBlackTreeLibrary.Tree tree;

    function setUp () public {
      tree.insert(8);
    }

    function testGetEmpty () public {
        assertEq(BokkyPooBahsRedBlackTreeLibrary.getEmpty(), 0);
    }

    function testGetNode () public {
        tree.insert(1);
        tree.insert(17);
        tree.insert(13);
        tree.insert(11);

        BokkyPooBahsRedBlackTreeLibrary.Node memory one = tree.getNode(1);
        assertEq(one.parent, 8);
        assertEq(one.left, 0);
        assertEq(one.right, 0);
        assertFalse(one.red);

        BokkyPooBahsRedBlackTreeLibrary.Node memory eight = tree.getNode(8);
        assertEq(eight.parent, 0);
        assertEq(eight.left, 1);
        assertEq(eight.right, 13);
        assertFalse(eight.red);

        BokkyPooBahsRedBlackTreeLibrary.Node memory eleven = tree.getNode(11);
        assertEq(eleven.parent, 13);
        assertEq(eleven.left, 0);
        assertEq(eleven.right, 0);
        assertTrue(eleven.red);

        BokkyPooBahsRedBlackTreeLibrary.Node memory thirteen = tree.getNode(13);
        assertEq(thirteen.parent, 8);
        assertEq(thirteen.left, 11);
        assertEq(thirteen.right, 17);
        assertFalse(thirteen.red);

        BokkyPooBahsRedBlackTreeLibrary.Node memory seventeen = tree.getNode(17);
        assertEq(seventeen.parent, 13);
        assertEq(seventeen.left, 0);
        assertEq(seventeen.right, 0);
        assertTrue(seventeen.red);
    }

    /*
     * Demonstration of tracking values for keys
    function getNode(uint _key) public view returns (uint key, uint parent, uint left, uint right, bool red, uint value) {
        if (tree.exists(_key)) {
            BokkyPooBahsRedBlackTreeLibrary.Node memory node = tree.getNode(_key);
            (parent, left, right, red) = (
              node.parent,
              node.left,
              node.right,
              node.red
            );
            key = _key;
            value = values[_key];
        }
    }
    */

    function testIsEmpty () public {
        // pointless?
        assertTrue(BokkyPooBahsRedBlackTreeLibrary.isEmpty(0));
    }

    function testInsert (uint256 _key) public {
        vm.assume(!tree.exists(_key) && _key != 0); // empty node and node used in setUp

        tree.insert(_key);
        assertTrue(BokkyPooBahsRedBlackTreeLibrary.exists(tree, _key));
    }

    function testRemove (uint256 _key) public {
        vm.assume(!tree.exists(_key) && _key != 0); // empty node and node used in setUp

        tree.insert(_key);
        assertTrue(tree.exists(_key));

        tree.remove(_key);
        assertFalse(tree.exists(_key));
    }
}
