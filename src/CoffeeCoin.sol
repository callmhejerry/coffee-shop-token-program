//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CoffeeCoin is ERC20 {
    address public coffeeShop;

    constructor() ERC20("CoffeeCoin", "CFC") {
        coffeeShop = msg.sender;
    }

    function mint(address _to, uint256 amount) public onlyCoffeShop {
        _mint(_to, amount);
    }

    function burn(address customer, uint256 _value) public onlyCoffeShop {
        _burn(customer, _value);
    }

    function giftToken(address from, address to, uint256 amount) public onlyCoffeShop {
        _transfer(from, to, amount);
    }

    modifier onlyCoffeShop() {
        require(msg.sender == coffeeShop, "Only coffee shop can mint tokens");
        _;
    }
}
