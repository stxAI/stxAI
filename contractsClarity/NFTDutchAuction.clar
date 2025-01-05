;; Dutch Auction Contract
(define-constant CONTRACT_OWNER tx-sender)
(define-constant INITIAL_PRICE u100000000) ;; 100 STX in micro STX
(define-constant PRICE_DECREMENT u100000) ;; 0.1 STX in micro STX

(define-data-var auction-start-block uint u0)
(define-data-var nft-id uint u0)

(define-public (start-auction (token-id uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) (err u100))
    (var-set auction-start-block block-height)
    (var-set nft-id token-id)
    (ok true)))

(define-read-only (get-current-price)
  (let (
    (blocks-passed (- block-height (var-get auction-start-block)))
    (price-reduction (* blocks-passed PRICE_DECREMENT))
  )
    (if (> price-reduction INITIAL_PRICE)
      u0
      (- INITIAL_PRICE price-reduction))))

(define-public (buy-nft)
  (let ((current-price (get-current-price)))
    (begin
      (asserts! (> current-price u0) (err u101))
      (try! (stx-transfer? current-price tx-sender CONTRACT_OWNER))
      ;; Add NFT transfer logic here
      (ok true))))