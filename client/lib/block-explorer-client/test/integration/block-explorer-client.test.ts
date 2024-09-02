import BlockExplorerClient from '../../src/block-explorer-client';

describe('BlockExplorerClient Integration Test', () => {
  it('should make a single call using the BlockExplorerClient', async () => {
    const client = new BlockExplorerClient('http://localhost:3000');
    const response = await client.get('/blocks');

    expect(response).not.toBeNull();
    expect(response).toBeInstanceOf(Array);
  });
});
