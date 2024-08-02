/// Module: 02coin
module coin2::faucet_coin {
    use sui::coin::{Self,TreasuryCap};
    use sui::balance::{Self, Balance};

    public struct FAUCET_COIN has drop {}
    public struct FaucetWallet has key {
        id: UID,
        coin: Balance<FAUCET_COIN>
    }

    fun init(waitness: FAUCET_COIN, ctx: &mut sui::tx_context::TxContext) {
        let (treasury_cap, meta) = coin::create_currency(waitness,6,b"FAUCET", b"FAUCET", b"", option::none(), ctx);

        transfer::public_freeze_object(meta);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
        let wallet = FaucetWallet {
            id: object::new(ctx),
            coin: balance::zero()
        };
        transfer::share_object(wallet)
    }

    
    public entry fun mint(
        treasury_cap: &mut TreasuryCap<FAUCET_COIN>, wallet: &mut FaucetWallet, amount: u64, ctx: &mut TxContext
    ) {
        let coin1 = coin::mint(treasury_cap, amount, ctx);
        balance::join(&mut wallet.coin, coin::into_balance(coin1));
    }

    public entry fun faucet(
        wallet: &mut FaucetWallet,
        ctx: &mut TxContext,
    ) {
        let coin2 = coin::take(&mut wallet.coin, 10000, ctx);
        transfer::public_transfer(coin2, tx_context::sender(ctx));
    }
}

