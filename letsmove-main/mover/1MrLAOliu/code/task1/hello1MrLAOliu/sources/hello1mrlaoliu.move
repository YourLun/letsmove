/// Module: hello1mrlaoliu
module hello1mrlaoliu::hello1mrlaoliu {
    use std::string;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct HelloWorldObject has key, store {
        id: UID,
        text: string::String
    }

    #[lint_allow(self_transfer)]
    public fun mint(ctx: &mut TxContext) {
        let object = HelloWorldObject {
            id: object::new(ctx),
            text: string::utf8(b"Hello 1MrLAOliu!")
        };
        transfer::public_transfer(object, tx_context::sender(ctx));
    }
}
