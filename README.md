# 🏦 CryptoBank (Simple Ether Bank)

---

## 🧾 Overview

**CryptoBank** is a simple Solidity smart contract that works like an on-chain “bank” for **Ether deposits and withdrawals**.  
Each user can deposit ETH up to a configurable **maximum balance** (`maxBalance`), withdraw their own ETH, and the **admin** can update the maximum allowed balance.

This project is designed to practice:
- State variables (`uint256`, `address`)
- `mapping` for user balances
- `payable` functions and ETH transfers
- `require` validations
- Modifiers (`onlyAdmin`)
- Events (`Deposit`, `Withdraw`)
- Basic security pattern: **CEI (Checks-Effects-Interactions)**

---

## 🚀 Features

| Feature | Description |
|--------|-------------|
| ETH Deposits | Users can deposit Ether into the contract. |
| Per-User Balance Tracking | Uses `mapping(address => uint256)` to store balances. |
| Max Balance Limit | Users cannot exceed `maxBalance` when depositing. |
| Withdrawals | Users can withdraw their own deposited Ether. |
| Admin Control | Admin can modify `maxBalance`. |
| Events | Emits events on deposit and withdrawal for tracking. |

---

## 📌 Contract Details

- **Contract Name:** `CryptoBank`
- **Solidity Version:** `0.8.33`
- **License:** LGPL-3.0-only
- **Admin:** Set at deployment (`admin_`)
- **Max Balance:** Set at deployment (`maxBalance_`)

---

## 🔐 Security Notes (What this contract does right)

### ✅ CEI Pattern (Checks-Effects-Interactions)
The `withdrawEther()` function follows the **CEI pattern**:
1. **Checks:** verify user has enough balance
2. **Effects:** update user balance
3. **Interactions:** send ETH via `.call`

This helps reduce risk from reentrancy-style issues.

---

## 🧠 Key Functions

### `depositEther() external payable`
- Deposits ETH into the contract
- Reverts if deposit would exceed `maxBalance`
- Updates user balance
- Emits `etherDeposit(user, amount)`

### `withdrawEther(uint256 amount_) external`
- Withdraws ETH from caller’s balance
- Requires enough balance
- Updates balance first, then sends ETH
- Emits `etherWithdraw(user, amount)`

### `modifyMaxBalance(uint256 newMaxBalance_) external onlyAdmin`
- Admin-only function to update `maxBalance`

---

## 🧪 Deploy & Test (Remix)

### 1) Compile
1. Open Remix IDE: https://remix.ethereum.org
2. Create `CryptoBank.sol` and paste the contract code
3. Go to **Solidity Compiler**
4. Select version **0.8.33**
5. Click **Compile**

### 2) Deploy
1. Go to **Deploy & Run Transactions**
2. Select contract: `CryptoBank`
3. Fill constructor parameters:
   - `maxBalance_`: e.g. `1000000000000000000` (1 ETH)
   - `admin_`: your deployer address (or any address you choose)
4. Click **Deploy**

### 3) Test Deposits
1. Set a value in Remix (e.g. `0.1 ether`)
2. Call `depositEther()`
3. Verify:
   - `userBalance(<your_address>)` increased
   - Event `etherDeposit` was emitted

### 4) Test Withdrawals
1. Call `withdrawEther(<amount_in_wei>)`
2. Verify:
   - `userBalance(<your_address>)` decreased
   - Event `etherWithdraw` was emitted

### 5) Test Admin Function
1. From the **admin address**, call:
   - `modifyMaxBalance(newMaxBalance_)`
2. From a non-admin address, try calling it:
   - Should revert with `"not allowed"`

---

## 📜 License
This project is licensed under **LGPL-3.0-only**.
