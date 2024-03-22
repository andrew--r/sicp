import { test, describe } from "node:test";
import assert from "node:assert";
import { pair, set_tail, head, tail } from "./pair.mjs";

function makeNode(payload, initialLeft, initialRight) {
  const node = pair(pair(payload, initialLeft), initialRight);

  function value() {
    return head(head(node));
  }

  function left() {
    return tail(head(node));
  }

  function right() {
    return tail(node);
  }

  function setLeft(value) {
    set_tail(head(node), value);
    return dispatch;
  }

  function setRight(value) {
    set_tail(node, value);
    return dispatch;
  }

  function hasLeft() {
    return left() !== null;
  }

  function hasRight() {
    return right !== null;
  }

  function dispatch(command) {
    return {
      left,
      right,
      value,
      hasLeft,
      hasRight,
      setLeft,
      setRight,
    }[command];
  }

  return dispatch;
}

function makeDequeue() {
  let frontPtr = null;
  let rearPtr = null;

  function isEmpty() {
    return frontPtr === null;
  }

  function front() {
    if (isEmpty()) {
      throw new Error("front called with an empty queue");
    }

    return frontPtr("value")();
  }

  function frontInsert(item) {
    const head = makeNode(item, null, frontPtr);
    if (frontPtr === null) {
      frontPtr = head;
    } else {
      frontPtr("setLeft")(head);
      frontPtr = head;
    }

    if (rearPtr === null) {
      rearPtr = frontPtr;
    }

    return dispatch;
  }

  function frontRemove() {
    if (isEmpty()) {
      throw new Error("frontRemove called with an empty queue");
    }

    frontPtr = frontPtr("right")();

    frontPtr?.("setLeft")(null);

    return dispatch;
  }

  function rear() {
    if (isEmpty()) {
      throw new Error("front called with an empty queue");
    }

    return rearPtr("value")();
  }

  function rearInsert(item) {
    const tail = makeNode(item, rearPtr, null);

    if (frontPtr === null) {
      frontPtr = tail;
    }

    if (rearPtr === null) {
      rearPtr = tail;
    } else {
      rearPtr("setRight")(tail);
      rearPtr = tail;
    }

    return dispatch;
  }

  function rearRemove() {
    if (isEmpty()) {
      throw new Error("rearRemove called with an empty queue");
    }

    rearPtr = rearPtr("left")();
    rearPtr?.("setRight")(null);

    if (rearPtr === null) {
      frontPtr = null;
    }

    return dispatch;
  }

  function dispatch(command) {
    return {
      front,
      frontInsert,
      frontRemove,
      isEmpty,
      rear,
      rearInsert,
      rearRemove,
    }[command];
  }

  return dispatch;
}

describe("3.23 makeDequeue", () => {
  test("isEmpty", () => {
    let dequeue = makeDequeue();
    assert.strictEqual(dequeue("isEmpty")(), true);
    dequeue("frontInsert")("a");
    assert.strictEqual(dequeue("isEmpty")(), false);

    dequeue = makeDequeue();
    assert.strictEqual(dequeue("isEmpty")(), true);
    dequeue("rearInsert")("a");
    assert.strictEqual(dequeue("isEmpty")(), false);
  });

  test("front insertion", () => {
    const dequeue = makeDequeue();
    dequeue("frontInsert")("a");
    assert.strictEqual(dequeue("front")(), "a");
    assert.strictEqual(dequeue("rear")(), "a");
    dequeue("frontInsert")("b");
    assert.strictEqual(dequeue("front")(), "b");
    assert.strictEqual(dequeue("rear")(), "a");
    dequeue("frontInsert")("c");
    assert.strictEqual(dequeue("front")(), "c");
    assert.strictEqual(dequeue("rear")(), "a");
  });

  test("rear insertion", () => {
    const dequeue = makeDequeue();
    dequeue("rearInsert")("a");
    assert.strictEqual(dequeue("front")(), "a");
    assert.strictEqual(dequeue("rear")(), "a");
    dequeue("rearInsert")("b");
    assert.strictEqual(dequeue("front")(), "a");
    assert.strictEqual(dequeue("rear")(), "b");
    dequeue("rearInsert")("c");
    assert.strictEqual(dequeue("front")(), "a");
    assert.strictEqual(dequeue("rear")(), "c");
  });

  test("front and rear insertion", () => {
    const dequeue = makeDequeue();

    dequeue("frontInsert")("c");
    dequeue("rearInsert")("d");
    assert.strictEqual(dequeue("front")(), "c");
    assert.strictEqual(dequeue("rear")(), "d");

    dequeue("rearInsert")("e");
    dequeue("frontInsert")("b");
    assert.strictEqual(dequeue("front")(), "b");
    assert.strictEqual(dequeue("rear")(), "e");
  });

  test("throw when calling front/rear on empty dequeue", () => {
    const deque = makeDequeue();

    assert.throws(() => deque("front")());
    assert.throws(() => deque("rear")());
  });

  test("front removal", () => {
    const deque = makeDequeue();
    deque("frontInsert")("a");
    deque("frontInsert")("b");
    deque("frontInsert")("c");

    assert.strictEqual(deque("front")(), "c");
    assert.strictEqual(deque("rear")(), "a");

    deque("frontRemove")();
    assert.strictEqual(deque("front")(), "b");
    assert.strictEqual(deque("rear")(), "a");

    deque("frontRemove")();
    assert.strictEqual(deque("front")(), "a");
    assert.strictEqual(deque("rear")(), "a");

    deque("frontRemove")();
    assert.strictEqual(deque("isEmpty")(), true);
  });

  test("rear removal", () => {
    const deque = makeDequeue();
    deque("rearInsert")("a");
    deque("rearInsert")("b");
    deque("rearInsert")("c");

    assert.strictEqual(deque("front")(), "a");
    assert.strictEqual(deque("rear")(), "c");

    deque("rearRemove")();
    assert.strictEqual(deque("front")(), "a");
    assert.strictEqual(deque("rear")(), "b");

    deque("rearRemove")();
    assert.strictEqual(deque("front")(), "a");
    assert.strictEqual(deque("rear")(), "a");

    deque("rearRemove")();
    assert.strictEqual(deque("isEmpty")(), true);
  });

  test("front and rear removal", () => {
    const deque = makeDequeue();
    deque("frontInsert")("b");
    deque("frontInsert")("a");
    deque("rearInsert")("c");
    deque("rearInsert")("d");

    assert.strictEqual(deque("front")(), "a");
    assert.strictEqual(deque("rear")(), "d");

    deque("rearRemove")();
    deque("frontRemove")();
    assert.strictEqual(deque("front")(), "b");
    assert.strictEqual(deque("rear")(), "c");

    deque("rearRemove")();
    deque("frontRemove")();
    assert.strictEqual(deque("isEmpty")(), true);
  });
});
