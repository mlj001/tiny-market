;; sip009 nft that implements sip009-nft-trait
(impl-trait .sip009-nft-trait.sip009-nft-trait)

(define-non-fungible-token my-nft uint)
(define-constant contract-owner tx-sender) ;; 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM) ;; contract owner
(define-constant err-owner-only (err u101))
(define-constant err-token-id-failure (err u102))
;; store token-id-nonce
(define-data-var token-id-nonce uint u0)


;;uri
;;(define-data-var URI (string-ascii 256) "ipfs//url/{id}")

;; get last token id
;; read only because we are not making any changes
;; and it does not incur transaction fee
(define-read-only (get-last-token-id) 
    (ok (var-get token-id-nonce))
)

;; token uri
(define-read-only (get-token-uri (id uint)) 
    (ok none)
)

;; get owner
(define-read-only (get-owner (id uint)) 
    (ok (nft-get-owner? my-nft id))
)

;; transfer function, needs to be public
(define-public (transfer (id uint) (sender principal) (recipient principal)) 
    (nft-transfer? my-nft id sender recipient)
)

;; mint an NFT
(define-public (mint (recipient principal)) 
    (let 
        ( 
            (token-id (+ (var-get token-id-nonce) u1))
        )
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (try! (nft-mint? my-nft token-id recipient))
		(asserts! (var-set token-id-nonce token-id) err-token-id-failure)
		(ok token-id)
    )    
)

