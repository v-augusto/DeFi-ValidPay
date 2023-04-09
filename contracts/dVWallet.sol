// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "./VWalletBase.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract dVWallet is Initializable, PausableUpgradeable, OwnableUpgradeable, VWalletBase {
    function initialize() public initializer {
        __Pausable_init();
        __Ownable_init();
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function transfer(
        address _to,
        uint256 _amount
    ) external payable whenNotPaused override {
        require(_to != address(0));
        require(msg.value != 0, "Transfer must be greater than 0");
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Ether transfer failed.");
    }

    function getContractBalance(
        address _account
    ) public view whenNotPaused override returns (uint) {
        require(
            msg.sender == _account,
            "Only the sender can call this function"
        );
        return _account.balance;
    }
}