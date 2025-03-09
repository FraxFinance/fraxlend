# Fraxlend

## Overview

Fraxlend is a lending platform that allows anyone to create a market between a pair of ERC-20 tokens. Any token part of a Chainlink data feed can be lent to borrowers or used as collateral.  Each pair is an isolated, permission-less market which allows anyone to create and participate in lending and borrowing activities.

Fraxlend adheres to the EIP-4626: Tokenized Vault Standard, lenders are able to deposit ERC-20 assets into the pair and receive yield-bearing fTokens.  

![https://github.com/FraxFinance/fraxlend/raw/main/documentation/_images/PairOverview.png](https://github.com/FraxFinance/fraxlend/raw/main/documentation/_images/PairOverview.png)

<br>

## Usage

```bash
# Compile
forge build

# Test
forge test

# Deploy
source .env
forge script DeployFraxlend --private-key $PRIVATE_KEY --rpc-url $RPC_URL
```

<br>

## License
Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
