import React, { PropsWithChildren } from 'react';
import { render } from '@testing-library/react';
import type { RenderOptions } from '@testing-library/react';
import { Provider } from 'react-redux';
import type { AppStore, RootState } from '../src/app/store';
import { setupStore } from '../src/app/store';

interface ExtendedRenderOptions extends Omit<RenderOptions, 'queries'> {
  preloadedState?: Partial<RootState>
  store?: AppStore
}

export function createWrapper(
  preloadedState = {},
  store = setupStore(preloadedState)
) {
  return ({ children }: PropsWithChildren) => (
    <Provider store={store}>{children}</Provider>
  );
}

export function renderWithProvider(
  ui: React.ReactElement,
  extendedRenderOptions: ExtendedRenderOptions = {}
) {
  const {
    preloadedState = {},
    store = setupStore(preloadedState),
    ...renderOptions
  } = extendedRenderOptions;

  const Wrapper = createWrapper(preloadedState, store);

  return {
    store,
    ...render(ui, { wrapper: Wrapper, ...renderOptions })
  };
}
