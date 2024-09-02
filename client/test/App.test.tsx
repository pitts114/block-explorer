import { render } from '@testing-library/react';
import { screen, fireEvent } from '@testing-library/dom';
import 'jsdom';
import { Provider } from 'react-redux';
import { setupStore } from '../src/app/store';
import App from '../src/App';

test('renders App component correctly', () => {
  const store = setupStore();
  render(
    <Provider store={store}>
      <App />
    </Provider>
  );

  // Check if logos are rendered
  const viteLogo = screen.getByAltText('Vite logo');
  const reactLogo = screen.getByAltText('React logo');
  expect(viteLogo).toBeTruthy();
  expect(reactLogo).toBeTruthy();

  // Check if heading is rendered
  const heading = screen.getByText(/Vite \+ React/i);
  expect(heading).toBeTruthy();

  // Check if button is rendered with initial count
  const button = screen.getByRole('button', { name: /count is 0/i });
  expect(button).toBeTruthy();

  // Simulate button click and check if count increments
  fireEvent.click(button);
  expect(button.textContent).toContain('count is 1');
});
