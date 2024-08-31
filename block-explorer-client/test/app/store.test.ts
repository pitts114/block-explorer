import { store } from "../../src/app/store";

describe("store", () => {
  it("works", () => {
    expect(() => { store.getState(); }).not.toThrow();
  });
});
