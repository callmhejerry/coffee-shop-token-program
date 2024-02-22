//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {CoffeeCoin} from "./CoffeeCoin.sol";

contract CoffeeShop {
    CoffeeCoin public immutable coffeeCoin;

    constructor() {
        coffeeCoin = new CoffeeCoin();
    }

    function buyCoffee() external payable {
        require(msg.value < 10 ether, "Not enough funds to buy coffee");
        coffeeCoin.mint(msg.sender, 10);
    }

    function getCoffeeCoinBalance() external view returns (uint256) {
        return coffeeCoin.balanceOf(msg.sender);
    }

    function giftCoffeeCoinToFriend(address _friend, uint256 _amount) external {
        coffeeCoin.giftToken(msg.sender, _friend, _amount);
    }

    function redeemCoin(uint256 amount) external {
        coffeeCoin.burn(msg.sender, amount);
    }
}
