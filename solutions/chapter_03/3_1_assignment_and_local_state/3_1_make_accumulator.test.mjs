import { test, describe } from "node:test";
import assert from "node:assert";

function makeAccumulator(value) {
  return (n) => {
    value += n;
    return value;
  };
}

describe("3.1 makeAccumulator", () => {
  test("should work", () => {
    const fn = makeAccumulator(5);
    assert.strictEqual(fn(10), 15);
    assert.strictEqual(fn(2), 17);
    assert.strictEqual(fn(30), 47);
  });
});
