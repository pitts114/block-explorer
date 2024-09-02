import { setupStore } from "../../src/app/store";

describe("store", () => {
  it("works", () => {
    const store = setupStore();
    expect(() => { store.getState(); }).not.toThrow();
  });
});
