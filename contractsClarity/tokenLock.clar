;; Voting Functions
(define-public (vote-for-completion (token <ft-trait>))
  (let
    (
      (has-voted (default-to false (map-get? voter-registry tx-sender)))
      (vote-weight (unwrap! (get-vote-weight tx-sender token) (err u110)))
    )
    (asserts! (not (var-get emergency-stop)) (err ERR-EMERGENCY-STOP))
    (asserts! (var-get voting-active) (err ERR-VOTING-INACTIVE))
    (asserts! (<= block-height (var-get voting-end-height)) (err u107))
    (asserts! (not has-voted) (err ERR-ALREADY-VOTED))
    (map-set voter-registry tx-sender true)
    (var-set current-votes (+ (var-get current-votes) vote-weight))
    (ok true)
  ))

;; Unlock and LP Functions  
(define-public (unlock-tokens (token <ft-trait>))
  (let
    (
      (locked-tokens (var-get locked-amount))
      (half-amount (/ locked-tokens u2))
    )
    (asserts! (var-get phase-complete) (err u101))
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err ERR-NOT-AUTHORIZED))
    (try! (as-contract (contract-call? token transfer half-amount (as-contract tx-sender) (var-get contract-owner) none)))
    (var-set locked-amount half-amount)
    (ok true)
  ))