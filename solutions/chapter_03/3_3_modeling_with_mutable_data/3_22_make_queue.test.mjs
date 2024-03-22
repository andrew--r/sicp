import { test, describe } from "node:test";
import assert from "node:assert";
import { pair, set_tail, head, tail } from "./pair.mjs";

function makeQueue() {
  let frontPtr = null;
  let rearPtr = null;

  function isEmpty() {
    return frontPtr === null;
  }

  function front() {
    if (isEmpty()) {
      throw new Error("front called with an empty queue");
    }

    return head(frontPtr);
  }

  function insert(item) {
    const tail = pair(item, null);

    if (frontPtr === null) {
      frontPtr = tail;
    }

    if (rearPtr === null) {
      rearPtr = tail;
    } else {
      set_tail(rearPtr, tail);
      rearPtr = tail;
    }

    return dispatch;
  }

  function remove() {
    if (isEmpty()) {
      throw new Error("remove called with an empty queue");
    }

    frontPtr = tail(frontPtr);

    return dispatch;
  }

  function dispatch(command) {
    return {
      remove,
      front,
      insert,
      isEmpty,
    }[command];
  }

  return dispatch;
}

describe("3.22 makeQueue", () => {
  test("should return true for empty queue", () => {
    const queue = makeQueue();
    assert.strictEqual(queue("isEmpty")(), true);
  });

  test("should return false for non-empty queue", () => {
    const queue = makeQueue();
    queue("insert")("a");
    assert.strictEqual(queue("isEmpty")(), false);
  });

  test("should throw error when calling front on an empty queue", () => {
    const queue = makeQueue();
    assert.throws(() => queue("front")());
  });

  test("should insert and return front element", () => {
    const queue = makeQueue();
    assert.strictEqual(queue("insert")("a")("front")(), "a");
    assert.strictEqual(queue("front")(), "a");

    queue("insert")("b");
    queue("insert")("c");

    assert.strictEqual(queue("front")(), "a");
  });

  test("should throw when calling remove on an empty queue", () => {
    const queue = makeQueue();
    assert.throws(() => queue("remove")());
  });

  test("should remove front elements", () => {
    const queue = makeQueue();
    queue("insert")("a")("insert")("b")("insert")("c");

    assert.strictEqual(queue("front")(), "a");
    assert.strictEqual(queue("isEmpty")(), false);

    queue("remove")();
    assert.strictEqual(queue("front")(), "b");
    assert.strictEqual(queue("isEmpty")(), false);
    queue("remove")();
    assert.strictEqual(queue("front")(), "c");
    assert.strictEqual(queue("isEmpty")(), false);
    queue("remove")();
    assert.strictEqual(queue("isEmpty")(), true);
  });
});
