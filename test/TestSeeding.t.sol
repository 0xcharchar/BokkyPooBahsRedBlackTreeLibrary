pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../contracts/BokkyPooBahsRedBlackTreeLibrary.sol";

contract TestSeeding is Test {
    using BokkyPooBahsRedBlackTreeLibrary for BokkyPooBahsRedBlackTreeLibrary.Tree;

    BokkyPooBahsRedBlackTreeLibrary.Tree tree;

    mapping(uint256 => BokkyPooBahsRedBlackTreeLibrary.Node) nodes;

    function setUp () public {
        uint256[] memory keys = new uint256[](4);
        keys[0] = 13;
        keys[1] = 11;
        keys[2] = 17;
        keys[3] = 1;

        nodes[8] = BokkyPooBahsRedBlackTreeLibrary.Node({
            parent: 0,
            left: 1,
            right: 13,
            red: false
        });

        nodes[1] = BokkyPooBahsRedBlackTreeLibrary.Node({
            parent: 8,
            left: 0,
            right: 0,
            red: false
        });

        nodes[11] = BokkyPooBahsRedBlackTreeLibrary.Node({
            parent: 13,
            left: 0,
            right: 0,
            red: true
        });

        nodes[13] = BokkyPooBahsRedBlackTreeLibrary.Node({
            parent: 8,
            left: 11,
            right: 17,
            red: false
        });

        nodes[17] = BokkyPooBahsRedBlackTreeLibrary.Node({
            parent: 13,
            left: 0,
            right: 0,
            red: true
        });

        BokkyPooBahsRedBlackTreeLibrary.seed(tree, keys, nodes, 8);
    }

    function testNodesExist () public {
        assertTrue(BokkyPooBahsRedBlackTreeLibrary.exists(tree, 8));
        assertTrue(BokkyPooBahsRedBlackTreeLibrary.exists(tree, 1));
        assertTrue(BokkyPooBahsRedBlackTreeLibrary.exists(tree, 13));
        assertTrue(BokkyPooBahsRedBlackTreeLibrary.exists(tree, 11));
        assertTrue(BokkyPooBahsRedBlackTreeLibrary.exists(tree, 17));
    }

    function testGetNode () public {
        BokkyPooBahsRedBlackTreeLibrary.Node memory node = tree.getNode(13);
        assertEq(node.left, 11);
        assertEq(node.right, 17);
        assertEq(node.parent, 8);
        assertFalse(node.red);
    }
}
