// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./interfaces/IVWallet.sol";

contract VWalletBase is VWallet {

    function transfer(
        address _to,
        uint256 _amount
    ) virtual external payable {
        require(_to != address(0));
        require(msg.value != 0, "Transfer must be greater than 0");
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Ether transfer failed.");
    }

    function getContractBalance(
        address _account
    ) virtual public view returns (uint) {
        require(
            msg.sender == _account,
            "Only the sender can call this function"
        );
        return _account.balance;
    }
}