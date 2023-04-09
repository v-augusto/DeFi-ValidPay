// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

interface VWallet {
    function transfer(address _to, uint256 _amount) external payable;
    function getContractBalance(address _account) external view returns (uint);
}