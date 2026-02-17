// Licence
// SPDX-License-Identifier: LGPL-3.0-only

//Solidity version
pragma solidity 0.8.33;


//Contract
contract CryptoBank {

    //Variables
    uint256 public maxBalance;
    address public admin;
    mapping (address =>uint256) public userBalance;

    //Events
    event etherDeposit(address user_, uint256 etherAmount_);
    event etherWithdraw(address user_, uint256 ehterAmount);

    //modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "not allowed");
        _;
    }

    //Constructor
    constructor(uint256 maxBalance_, address admin_) {
        maxBalance = maxBalance_;
        admin = admin_;
    }

    //External functions

    //1. Deposit
    function depositEther() external payable {
        require(userBalance[msg.sender] + msg.value <= maxBalance, "Max balance reached");
        userBalance[msg.sender] += msg.value;
        emit etherDeposit(msg.sender, msg.value);
    }

    //2. Witdraw
    function withdrawEther(uint256 amount_) external {
        //CEI Pattern:
        require(amount_ <= userBalance[msg.sender], "Not enough enter");

        //Update state
        userBalance[msg.sender] -= amount_;

        //Transfer ether
        (bool success,) = msg.sender.call{value: amount_}("");
        require(success, "transfer failed");

        emit etherWithdraw(msg.sender, amount_);
    }

    // Modify maxBalance only by owner
    function modifyMaxBalance(uint256 newMaxBalance_) external  onlyAdmin{
        maxBalance = newMaxBalance_;
    }


}