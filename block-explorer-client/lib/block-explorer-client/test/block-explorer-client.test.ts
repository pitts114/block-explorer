import BlockExplorerClient, { GetBlocksResponse, Block } from '../src/block-explorer-client';
import axios, { AxiosStatic } from 'axios';

describe('BlockExplorerClient', () => {
  describe('#get', () => {

    it('returns expected result', async () => {
      const mockBlock: Block = { height: 1, time: 1234567890, nTx: 1, size: 1 };
      const mockResponse: GetBlocksResponse = [mockBlock];
      const mockAxios: AxiosStatic = { ...axios, get: vi.fn().mockResolvedValue({ data: mockResponse }) };

      // Create an instance of the BlockExplorerClient
      const client = new BlockExplorerClient('http://localhost:3000', mockAxios);
      const response = await client.get('/blocks');

      expect(response).not.toBeNull();
      expect(response).toEqual(mockResponse);
    });
  });
});
