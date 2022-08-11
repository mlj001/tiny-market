(define-trait sip009-nft-trait
    (
        ;; last token id    
        (get-last-token-id () (response uint uint))

        ;; uri for metadata
        (get-token-uri (uint) (response (optional (string-ascii 256)) uint))

        ;;gets ownder of nft
        (get-owner (uint) (response (optional principal) uint))

        ;; transfer from the sender to new recipient (principal)
        (transfer (uint principal principal) (response bool uint))

    )
)