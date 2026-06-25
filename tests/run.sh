#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

TEST_ROOT="$(mktemp -d)"
export PATH="$ROOT_DIR:$PATH"

PASS=0
FAIL=0

say() {
  echo ""
  echo "==> $1"
}

ok() {
  echo "✓ $1"
  PASS=$((PASS + 1))
}

fail() {
  echo "✗ $1"
  FAIL=$((FAIL + 1))
}

assert_success() {
  local name="$1"
  shift

  if "$@" >/tmp/shipyard-test.out 2>/tmp/shipyard-test.err; then
    ok "$name"
  else
    fail "$name"
    cat /tmp/shipyard-test.err
  fi
}

assert_failure() {
  local name="$1"
  shift

  if "$@" >/tmp/shipyard-test.out 2>/tmp/shipyard-test.err; then
    fail "$name"
  else
    ok "$name"
  fi
}

cleanup() {
  rm -rf "$TEST_ROOT"
}

trap cleanup EXIT

say "Syntax checks"

for file in "$ROOT_DIR"/shipyard "$ROOT_DIR"/bin/* "$ROOT_DIR"/lib/*.sh; do
  assert_success "syntax: $(basename "$file")" bash -n "$file"
done

say "Static template checks"

assert_success "static nginx template exists" test -f "$ROOT_DIR/templates/nginx/static.conf"
assert_success "laravel nginx template exists" test -f "$ROOT_DIR/templates/nginx/laravel.conf"
assert_success "node nginx template exists" test -f "$ROOT_DIR/templates/nginx/node.conf"

say "Required files"

assert_success "README exists" test -f "$ROOT_DIR/README.md"
assert_success "VERSION exists" test -f "$ROOT_DIR/VERSION"
assert_success "installer exists" test -f "$ROOT_DIR/install.sh"

echo ""
echo "Passed: $PASS"
echo "Failed: $FAIL"

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
