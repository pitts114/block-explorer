import { configureStore, combineReducers } from "@reduxjs/toolkit";
import { blockExplorerApiSlice } from "../features/bitcoin/block-explorer-api-slice";

const rootReducer = combineReducers({
  [blockExplorerApiSlice.reducerPath]: blockExplorerApiSlice.reducer
});

export const setupStore = (preloadedState?: Partial<RootState>) => configureStore({
  reducer: rootReducer,
  middleware: (getDefaultMiddleware) => {
    return getDefaultMiddleware().concat(blockExplorerApiSlice.middleware);
  },
  preloadedState
});

export type RootState = ReturnType<typeof rootReducer>;
export type AppStore = ReturnType<typeof setupStore>;
export type AppDispatch = AppStore["dispatch"];
