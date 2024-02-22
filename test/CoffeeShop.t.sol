//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {CoffeeShop} from "../src/CoffeeShop.sol";

contract CoffeeShopTest is Test {
    CoffeeShop public coffeeShop;
    address jerry = makeAddr("jerry");
    address amaka = makeAddr("amaka");

    function setUp() public {
        coffeeShop = new CoffeeShop();
    }

    function testBuyCofffee() public {
        hoax(jerry, 20);
        coffeeShop.buyCoffee();

        assertEq(coffeeShop.coffeeCoin().balanceOf(jerry), 10);
    }

    function testCoffeShopOwner() public {
        assertEq(address(coffeeShop), coffeeShop.coffeeCoin().coffeeShop());
    }

    function testGiftToken() public {
        deal(jerry, 20);
        vm.startPrank(jerry);
        coffeeShop.buyCoffee();
        coffeeShop.giftCoffeeCoinToFriend(amaka, 10);
        vm.stopPrank();
        vm.prank(amaka);
        assertEq(coffeeShop.getCoffeeCoinBalance(), 10);
    }

    function testRedeemCoin() public {
        buyCoffee(jerry);
        vm.prank(jerry);
        coffeeShop.redeemCoin(10);
        assertEq(coffeeShop.getCoffeeCoinBalance(), 0);
    }

    function buyCoffee(address _account) internal{
        hoax(_account, 20);
        coffeeShop.buyCoffee();
    }
}
