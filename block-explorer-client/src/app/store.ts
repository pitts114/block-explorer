import { configureStore } from "@reduxjs/toolkit";

export const store = configureStore({
  reducer: (state = {}, action) => state,reducer: (state = {}, action) => state
});

export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;
export type AppStore = typeof store;
