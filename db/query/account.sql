-- name: CreateAccount :one
INSERT INTO acounts (
  owner,
  balance,
  currency
) VALUES (
  $1, $2, $3
)RETURNING *;

-- name: GetAcount :one
SELECT * FROM acounts
WHERE id = $1 LIMIT 1;

-- name: ListAcounts :many
SELECT * FROM acounts
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateAcount :one
UPDATE acounts
  set balance = $2
WHERE id = $1
RETURNING *;

-- name: DeleteAcount :exec
DELETE FROM acounts
WHERE id = $1;